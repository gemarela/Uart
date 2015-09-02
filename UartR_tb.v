`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:00:29 11/24/2014
// Design Name:   Uart_Receiver
// Module Name:   C:/Users/marelas/Documents/LAB2/Uart_Receiver/UartReceiver/UartR_tb.v
// Project Name:  UartReceiver
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Uart_Receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UartR_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [2:0] baud_select;
	reg Rx_EN;
	reg RxD;

	// Outputs
	wire [7:0] Rx_DATA;
	wire Rx_FERROR;
	wire Rx_PERROR;
	wire Rx_VALID;

	// Instantiate the Unit Under Test (UUT)
	Uart_Receiver uut (
		.rst(rst), 
		.clk(clk), 
		.Rx_DATA(Rx_DATA), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(RxD), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		baud_select = 0;
		Rx_EN = 0;
		RxD = 0;

		// Wait 100 ns for global reset to finish
		#100;
      Rx_EN = 1;
      rst = 0;
		RxD = 1;
		baud_select = 3'b111;
		/*10101010*/
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		/*
		####################
		#new value 01010101#
		####################
		*/
		
		#26880
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		
		/*
		####################
		#new value 11001100#
		####################
		*/
		
		#26880
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		
		/*
		####################
		#new value 11101110#
		####################
		*/
		
		#26880
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		
		/*value 01001010 */
		#26880
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=1;
		#8960
		RxD=0;
		#8960
		RxD=0;
		#8960
		RxD=1;
		
		#550000 $finish;

	end
   
	always #10 clk=~clk;

      
endmodule

