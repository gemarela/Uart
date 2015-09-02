`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:52 11/22/2014
// Design Name:   baud_controller
// Module Name:   C:/Users/marelas/Documents/LAB2/baud_controller/Baud_Controller/baud_controller_tb.v
// Project Name:  Baud_Controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: baud_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module baud_controller_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [2:0] baud_select;

	// Outputs
	wire sample_enable;

	// Instantiate the Unit Under Test (UUT)
	baud_controller uut (
		.rst(rst), 
		.clk(clk), 
		.baud_select(baud_select), 
		.sample_enable(sample_enable)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		baud_select = 3'b0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		#100
		
		baud_select = 3'b111;
		
		#4000
		
		baud_select = 3'b101;
		
		#13000$finish;
		
	end
	
	always #10 clk = ~clk;
      
endmodule

