// Verilog HDL File: task2_top.v
// Top-level module for Lab Task 2
// Function: Connects a 10-bit input to three 7-segment displays
// Date: 11 Jan 2025

module task2_top (
    SW,      // Input switches
    HEX0,    // Output to 7-segment display
    HEX1,
    HEX2
);

    input [9:0] SW;
    output [6:0] HEX0;
    output [6:0] HEX1;
    output [6:0] HEX2;
 
    // Instantiate the hex_to_7seg module
    hex_to_7seg SEG0 (
        .hex(SW[3:0]),    // Connect SW[3:0] to HEX0
        .seg(HEX0)
    );

    hex_to_7seg SEG1 (
        .hex(SW[7:4]),    // Connect SW[7:4] to HEX1
        .seg(HEX1)
    );

    hex_to_7seg SEG2 (
        .hex({2'b00, SW[9:8]}), // Zero-extend SW[9:8] to 4 bits and connect to HEX2
        .seg(HEX2)
    );

endmodule
