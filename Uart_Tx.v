`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    21:27:57 11/22/2014 
// Design Name: 
// Module Name:    Uart_Tx 
// Project Name: Uart Implementation
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
module Uart_Tx(
		rst,
		clk,
		Tx_DATA,
		baud_select,
		Tx_WR,
		Tx_EN,
		TxD,
		Tx_BUSY
    );

	/*input / output Transmitter */
	input rst,clk;
	input [7:0] Tx_DATA;
	input [2:0] baud_select;
	input Tx_WR;
	input Tx_EN;
	
	output reg TxD; 
	output reg Tx_BUSY;
	
	/* States definition*/
	parameter [2:0] idle = 3'b000,
						 start = 3'b001,
						 data = 3'b010,
						 parity = 3'b011,
						 stop = 3'b100;
					
	reg [2:0] state,next_state;
	reg [3:0] sample_counter, sample_next; // counter gia na elegxo sto kentro tis periodou tou palmou
	reg [3:0] data_counter, data_next;  //counter gia ta bits pros apostoli
	reg [7:0] DATA, DATA_next;
	reg even;
	reg TxD_next, Tx_BUSY_next;
	
	wire Tx_sample_ENABLE;
	
	baud_controller baud_controller_tx_inst(
							.rst(rst),.clk(clk), 
							.baud_select(baud_select), 
							.sample_enable(Tx_sample_ENABLE));
							

	
	
	always @(posedge clk or posedge rst)
	begin
		
		if(rst)begin
			
			state = idle;
			sample_counter = 0;
			data_counter = 0;
			DATA = 0;
			TxD = 1;
			Tx_BUSY = 0;
			
		end
		else begin
		
			state = next_state;
			sample_counter = sample_next;
			data_counter = data_next;
			DATA = DATA_next;
			TxD = TxD_next;
			Tx_BUSY = Tx_BUSY_next;
			
		end
	end
	
	
	always @(posedge clk)
	begin
		
		next_state = state;
		sample_next = sample_counter;
		data_next = data_counter;
		DATA_next = DATA;
		Tx_BUSY_next = Tx_BUSY;
		
		case(state) 
			
			idle : begin
						TxD_next = 1;
						if(Tx_EN) begin
							if(Tx_WR) begin
								
								Tx_BUSY_next = 0;
								DATA_next = Tx_DATA;
								next_state = start;
								sample_next = 0;
								even = 0;

							end
							else begin 
								Tx_BUSY_next = 1;
							end 
						end
					end
					
			start : begin 
						TxD_next = 0;
						if(Tx_sample_ENABLE) begin
							
							if(sample_counter == 15) begin
									sample_next = 0;
									data_next = 0;
									next_state = data;
							end
							else begin
									sample_next = sample_counter+1;
							end
						end
					end
					
			data : begin
						TxD_next = DATA[0];
						if(Tx_sample_ENABLE) begin
								if(sample_counter == 15) begin
										sample_next = 0;
										if(TxD_next == 1 && even == 1)begin
												even = 0;
										end
										else if (TxD_next == 1) begin
											even = 1;
										end
										
										DATA_next = DATA >> 1;
										
										if(data_counter == 7)begin
											next_state = parity;
											data_next = 0;
										end
										else begin
											data_next = data_counter+1;
										end
								end
								else begin
									sample_next = sample_counter+1;
								end
						end
					 end
					 
			parity : begin 
							TxD_next = even;
							if(Tx_sample_ENABLE)begin
								if(sample_counter == 15)begin
										sample_next = 0;
										next_state = stop;
								end
								else begin
										sample_next = sample_counter+1;
								end
							end
						end						
						
			stop : begin 
							TxD_next = 1;
							
							if(Tx_sample_ENABLE)begin
									if(sample_counter == 15)begin
										sample_next =0;
										next_state = idle;
										Tx_BUSY_next = 0;
									end
									else begin
										sample_next = sample_counter+1;
									end
							end
					 end
		endcase
	
	end
	
	

endmodule
