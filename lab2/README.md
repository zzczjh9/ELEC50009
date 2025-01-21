Department of Electrical & Electronic Engineering

Imperial College London

# Lab 2 – Design a NOIS2 System

### Tool -> Platform Designer to design a module with components
1. Search to add components and rename
2. add in a **System ID Peripheral Intel FPAG IP unit** 
2. Click junction to connect signal
3. Double click "external" to output signal
4. Save & generate HDL

### Quartus
- Design **top module** in verilog
- add `.qsys` file to project
- Compile get `.sopcinfo` file


### Eclipse
- use specific shell to open
- Project Explorer -> Nios II Application and BSP from Template. use `.sopcinfo` file, choose **Hello world** Small template
- Modify `hello_world.c`
- right click on the **hello_world_sw in the Project Explorer** -> Build Project
- get `.elf` file
- Quartus -> Tool -> Programmer -> Start
- Right click hello_world_sw_bsp-> Nios II -> Generate BSP
- Click on the Target Connection tab, and click Refresh Connections, then Resolve Names.
    * The connection should indicate that Eclipse has connected to the USB-blaster.


    <img src="./images/run_cfg.png" alt="drawing" width="720"/>

- Run button, and you should see "hello world" printed on the console tab at the bottom of the Eclipse window:

    <img src="./images/cmd_shell_win.png" alt="drawing" width="720"/>


## Task 3: Extensions - Challenges

Having learned to program our system, let’s make something fun.
Change the `hello_world.c` code to light up the LEDs in a sequence.
For example, you can light up the LEDs from left to right in a specific pattern by controlling the time to light up LED x after having light up LED x-1. Use the two keys (push buttons) to produce two different patterns. Print any related information on the terminal. Think how to produce a delay in lighting up the LEDs.
You can also think how to use the slide switches and the six 7-segment display to provide more complicated set of patterns

## Troubleshooting

In Quartus, if clicking Tools > NIOS2 Software Biuld Tools has no effect (eg. no window pops up). This is likely because you have not installed NIOS2 Eclipse properly. The new version of Quartus requires a separate install of NIOS2, which you should follow the instructions at `"C:\intelFPGA_lite\<your_version_number>\nios2eds\bin\README"` to install Eclipse and plugins.
