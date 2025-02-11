#include "system.h"
#include "altera_up_avalon_accelerometer_spi.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include <stdlib.h>
#include <math.h>  // for abs()
#include <stdio.h>
#include <string.h> // for strcmp
#include "altera_avalon_jtag_uart_regs.h"

#define OFFSET      -32
#define PWM_PERIOD  16
#define FIR_TAPS 5

alt_8 pwm = 0;
alt_u8 led;
int level;
int mode = 0;  // Default to Mode 0 (No Filtering)

/* FIR filter coefficients */
const float fir_coeff[FIR_TAPS] = {0.2f, 0.2f, 0.2f, 0.2f, 0.2f};

/* FIR filter function */
float fir_filter(float sample) {
    static float buffer[FIR_TAPS] = {0.0f};
    float output = 0.0f;
    int i;

    for (i = FIR_TAPS - 1; i > 0; i--) {
        buffer[i] = buffer[i - 1];
    }
    buffer[0] = sample;

    for (i = 0; i < FIR_TAPS; i++) {
        output += fir_coeff[i] * buffer[i];
    }
    return output;
}

/* LED write function */
void led_write(alt_u8 led_pattern) {
    IOWR(LED_BASE, 0, led_pattern);
}

/* Convert accelerometer reading to LED pattern */
void convert_read(alt_32 acc_read, int *level, alt_u8 *led) {
    acc_read += OFFSET;
    alt_u8 val = (acc_read >> 6) & 0x07;
    *led = (8 >> val) | (8 << (8 - val));
    *level = (acc_read >> 1) & 0x1f;
}

/* Timer ISR */
void sys_timer_isr() {
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_BASE, 0);

    if (pwm < abs(level)) {
        if (level < 0) {
            led_write(led << 1);
        } else {
            led_write(led >> 1);
        }
    } else {
        led_write(led);
    }

    if (pwm > PWM_PERIOD) {
        pwm = 0;
    } else {
        pwm++;
    }
}

/* Timer Initialization */
void timer_init(void *isr) {
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_BASE, 0x0003);
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_BASE, 0);
    IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_BASE, 0x0900);
    IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_BASE, 0x0000);
    alt_irq_register(TIMER_IRQ, 0, isr);
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_BASE, 0x0007);
}

/* Read command from JTAG UART */
void check_jtag_command() {
    if (IORD_ALTERA_AVALON_JTAG_UART_DATA(JTAG_UART_BASE) & 0x00008000) {
        char cmd = IORD_ALTERA_AVALON_JTAG_UART_DATA(JTAG_UART_BASE) & 0xFF;

        if (cmd == '0') {
            mode = 0;
            alt_printf("Mode 0: No Filtering\n");
        } else if (cmd == '1') {
            mode = 1;
            alt_printf("Mode 1: FIR Filtering Enabled\n");
        }
    }
}

int main(void) {
    alt_up_accelerometer_spi_dev *acc_dev;
    alt_32 x_read;
    float filtered_x;
    char buf[32];

    // Set default mode to 0 (Unfiltered)
    mode = 0;
    alt_printf("System started in Mode 0 (No Filtering)\n");

    acc_dev = alt_up_accelerometer_spi_open_dev("/dev/accelerometer_spi");
    if (acc_dev == NULL) {
        alt_printf("Error: Could not open accelerometer device\n");
        return 1;
    }

    while(1) {
        check_jtag_command(); // Poll for mode change

        alt_up_accelerometer_spi_read_x_axis(acc_dev, &x_read);

        if (mode == 1) {
            filtered_x = fir_filter((float)x_read);
        } else {
            filtered_x = (float)x_read;  // Directly use raw data in Mode 0
        }

        int scaled = (int)(filtered_x * 1000);
        sprintf(buf, "Output: %d.%03d (Mode %d)\n", scaled / 1000, abs(scaled % 1000), mode);
        alt_printf("%s", buf);
    }

    return 0;
}
