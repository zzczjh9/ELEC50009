// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| George Totolos    :| 08/22/2016:| Initial Revision
// ============================================================================


//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

`define ENABLE_ADC_CLOCK
`define ENABLE_CLOCK1
`define ENABLE_CLOCK2
`define ENABLE_SDRAM
`define ENABLE_HEX0
`define ENABLE_HEX1
`define ENABLE_HEX2
`define ENABLE_HEX3
`define ENABLE_HEX4
`define ENABLE_HEX5
`define ENABLE_KEY
`define ENABLE_LED
`define ENABLE_SW
`define ENABLE_VGA
`define ENABLE_ACCELEROMETER
`define ENABLE_ARDUINO
`define ENABLE_GPIO

module DE10_LITE_Golden_Top(

`ifdef ENABLE_CLOCK1
	input 		          		MAX10_CLK1_50,
`endif

	//////////// SEG7: 3.3-V LVTTL //////////
`ifdef ENABLE_HEX0
	output		     [7:0]		HEX0,
`endif
`ifdef ENABLE_HEX1
	output		     [7:0]		HEX1,
`endif
`ifdef ENABLE_HEX2
	output		     [7:0]		HEX2,
`endif
`ifdef ENABLE_HEX3
	output		     [7:0]		HEX3,
`endif
`ifdef ENABLE_HEX4
	output		     [7:0]		HEX4,
`endif
`ifdef ENABLE_HEX5
	output		     [7:0]		HEX5,
`endif

	//////////// KEY: 3.3 V SCHMITT TRIGGER //////////
`ifdef ENABLE_KEY
	input 		     [1:0]		KEY,
`endif

	//////////// LED: 3.3-V LVTTL //////////
`ifdef ENABLE_LED
	output		     [9:0]		LEDR,
`endif

	//////////// SW: 3.3-V LVTTL //////////
`ifdef ENABLE_SW
	input 		     [9:0]		SW
`endif

);

	nios_setup_v2 u0 (
		.clk_clk (MAX10_CLK1_50), //clk.clk
		.led_external_connection_export (ledFromNios[9:0]), //led_external_connection.export //CHANGED TO LEDR
		.reset_reset_n (1'b1), //reset.reset_n
		.button_external_connection_export (KEY[1:0]), //button_external_connection.export
		.switch_external_connection_export (SW[9:0]), //switch_external_connection.export
		.hex0_external_connection_export (HEX0), //hex0_external_connection.export
		.hex1_external_connection_export (HEX1), //hex1_external_connection.export
		.hex2_external_connection_export (HEX2), //hex2_external_connection.export
		.hex3_external_connection_export (HEX3), //hex3_external_connection.export
		.hex4_external_connection_export (HEX4), //hex4_external_connection.export
		.hex5_external_connection_export (HEX5) //hex5_external_connection.export
	);

	
	//Uncomment the line below by deleting the "//"
	assign LEDR[2] = SW[2];

	//ignore what is below here

   wire [9:0] ledFromNios;
	assign LEDR[1:0] = ledFromNios[1:0];
	assign LEDR[9:3] = ledFromNios[9:3];
	assign HEX0[7] = 1'b1;
	assign HEX1[7] = 1'b1;
	assign HEX2[7] = 1'b1;
	assign HEX3[7] = 1'b1;
	assign HEX4[7] = 1'b1;
	assign HEX5[7] = 1'b1;
endmodule
