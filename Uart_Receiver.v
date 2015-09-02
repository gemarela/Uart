`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    18:38:59 11/23/2014 
// Design Name: 	
// Module Name:    Uart_Receiver 
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
module Uart_Receiver(
		rst, clk, 
		Rx_DATA, baud_select, 
		Rx_EN, RxD, 
		Rx_FERROR, 
		Rx_PERROR,
		Rx_VALID
    );
	 
	input rst, clk;
	input [2:0] baud_select;
	input Rx_EN;
	input RxD;
	
	output [7:0] Rx_DATA;
	output reg Rx_FERROR; // Framing Error //
	output reg Rx_PERROR; // Parity Error //
	output Rx_VALID; // Rx_DATA is Valid //

	wire Rx_sample_ENABLE;
	
	parameter [2:0] idle = 3'b0,
						 start = 3'b001,
						 data = 3'b010,
						 parity = 3'b011,
						 stop = 3'b100;
					
	reg [2:0] state,next_state;
	reg [3:0] sample_counter,sample_next; // counter gia na elegxo sto kentro tis periodou tou palmou
	reg [3:0] data_counter,data_next;
	reg [7:0] DATA,DATA_next;
	reg done,even;
	
	assign Rx_DATA = DATA;
	
	assign Rx_VALID = ~(done || Rx_PERROR || Rx_FERROR );
	
	baud_controller baud_controller_rx_inst(
							.rst(rst),
							.clk(clk), 
							.baud_select(baud_select), 
							.sample_enable(Rx_sample_ENABLE));
							
	
	always @(posedge clk or posedge rst)
	begin
		
		if(rst)begin
			
			state = idle;
			sample_counter = 0;
			data_counter = 0;
			DATA = 0;
			
		end
		else begin
		
			state = next_state;
			sample_counter = sample_next;
			data_counter = data_next;
			DATA = DATA_next;
		
		end
	end
	
	
	always @(posedge clk)
	begin
		
		next_state = state;
		sample_next = sample_counter;
		data_next = data_counter;
		DATA_next = DATA;
		done = 1;
		
		case(state) 
			
			idle : begin
						if(~RxD && Rx_EN) begin
							next_state = start;
							sample_next = 0;
							even = 0;
							Rx_FERROR = 0;
							Rx_PERROR = 0;
						end
					end
					
			start : begin 
						if(Rx_sample_ENABLE) begin
							
							if(sample_counter == 7) begin
									sample_next = 0;
									data_next = 0;
									next_state = data;
									if(RxD) begin //elegxos an exei allaksei se 1 wste na vgaloume ferror
											Rx_FERROR = 1'b1;
									end
									else begin
											Rx_FERROR = 1'b0;
									end
							end
							else begin
									sample_next = sample_counter+1;
							end
						end
					end
					
			data : begin
						if(Rx_sample_ENABLE) begin
								if(sample_counter == 15) begin
										sample_next = 0;
										DATA_next = {DATA[6:0],RxD};
										if(RxD == 1 && even == 1)begin
												even = 0;
										end
										else if(RxD == 1)begin
											even = 1;
										end
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
							if(Rx_sample_ENABLE)begin
								if(sample_counter == 15)begin
										sample_next = 0;
										next_state = stop;
										if(RxD == even )begin
												Rx_PERROR = 0;
										end
										else begin
												Rx_PERROR = 1;
										end
								end
								else begin
										sample_next = sample_counter+1;
								end
							end
						end						
						
			stop : begin 
							if(Rx_sample_ENABLE)begin
									if(sample_counter == 15)begin
										done = 0;
										sample_next =0;
										next_state = idle;
									end
									else begin
										sample_next = sample_counter+1;
									end
							end
					 end
		endcase
	
	end
	
	

endmodule
