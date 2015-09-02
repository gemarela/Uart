`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:01:56 11/24/2014
// Design Name:   Uart_Tx
// Module Name:   C:/Users/marelas/Documents/LAB2/Uart_Transmitter/UartTransmitter/uartT_tb.v
// Project Name:  UartTransmitter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Uart_Tx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uartT_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [7:0] Tx_DATA;
	reg [2:0] baud_select;
	reg Tx_WR;
	reg Tx_EN;

	// Outputs
	wire TxD;
	wire Tx_BUSY;

	// Instantiate the Unit Under Test (UUT)
	Uart_Tx uut (
		.rst(rst), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		Tx_DATA = 0;
		baud_select = 0;
		Tx_WR = 0;
		Tx_EN = 0;


			// Wait 100 ns for global reset to finish
		#100;
      	rst = 0;
		Tx_EN = 1;
		baud_select = 3'b111;
		Tx_WR = 1;
		Tx_DATA = 8'b10101010;
		#20
		Tx_WR = 0;
		#180000
		Tx_WR = 1;
		Tx_DATA = 8'b01010101;
		#20
		Tx_WR = 0;
		#180000
		Tx_WR = 1;
		Tx_DATA = 8'b11001100;
		#20
		Tx_WR = 0;
		#180000
		Tx_WR = 1;
		Tx_DATA = 8'b10001001;
		#20
		Tx_WR = 0;
		#400000 $finish;

	end
   
	always #10 clk = ~clk;
      
endmodule

