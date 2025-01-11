// Verilog HDL File: task1_top.v
// Top-level module for Lab Task 1
// Function: Connects a hex input to a 7-segment display
// Date: 11 Jan 2025

module task3_top (
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
    hex_to_7seg  SEG0  (HEX0, SW[3:0]);
    hex_to_7seg  SEG1  (HEX1, SW[7:4]);
    hex_to_7seg  SEG2  (HEX2, {2'b00, SW[9:8]});

endmodule