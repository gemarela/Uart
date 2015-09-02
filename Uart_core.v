`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    12:37:33 11/24/2014 
// Design Name: 
// Module Name:    Uart Core
// Project Name: 	Uart Implementation
// Target Devices: Spartan3
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Uart(
		clkT,clkR,
		rst,baud_select,
		Tx_DATA,Tx_WR,Tx_EN, Tx_BUSY,
		Rx_DATA,Rx_FERROR,Rx_PERROR,
		Rx_VALID
    );
	
	/*****input / output Transmitter Module*/
	input wire rst,clkT;
	input wire [7:0] Tx_DATA;
	input wire [2:0] baud_select;
	input wire Tx_WR;
	input wire Tx_EN;
	
	wire TxD; //Transmitter output.Connected to RxD(Receiver)
	output wire Tx_BUSY; //output to Transmitter System
	
	
	/*****input / output Receiver Module*/
	input wire clkR;
	
	wire	Rx_EN;
	
	output wire [7:0] Rx_DATA; // Uart output to Receiver System
	output wire Rx_FERROR; // Framing Error //
	output wire Rx_PERROR; // Parity Error //
	output wire Rx_VALID; // Rx_DATA is Valid //
	
	
	assign Rx_EN = Tx_EN; //Enable Transmitter & Receiver.
	
	
	Uart_Tx TransmitterINST( 
		.rst(rst),.clk(clkT),
		.Tx_DATA(Tx_DATA),.baud_select(baud_select),
		.Tx_WR(Tx_WR),.Tx_EN(Tx_EN),.TxD(TxD),
		.Tx_BUSY(Tx_BUSY)
    );

	
	Uart_Receiver ReceiverINST(
		.rst(rst),.clk(clkR), 
		.Rx_DATA(Rx_DATA),.baud_select(baud_select), 
		.Rx_EN(Rx_EN),
		.RxD(TxD), //connection between Transmitter & Receiver
		.Rx_FERROR(Rx_FERROR),.Rx_PERROR(Rx_PERROR),
		.Rx_VALID(Rx_VALID)
    );
	 
	 
	 
	 
	
	

	


endmodule
