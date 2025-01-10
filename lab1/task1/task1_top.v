// Verilog HDL File: task1_top.v
// Top-level module for Lab Task 1
// Function: Connects a hex input to a 7-segment display
// Date: 11 Jan 2025

module task1_top (
    SW,      // Input switches
    HEX0    // Output to 7-segment display
);

    input [3:0] SW;
    output [6:0] HEX0;

    // Instantiate the hex_to_7seg module
    hex_to_7seg  SEG0  (HEX0, SW[3:0]);

endmodule
