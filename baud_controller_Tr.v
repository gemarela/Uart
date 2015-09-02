`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Marelas George
// 
// Create Date:    22:17:25 10/29/2014 
// Design Name: 
// Module Name:    baud_controller 
// Project Name: 	UART Implementation
// Target Devices: SPARTAN3
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
module baud_controller_Tr(
			rst,
			clk,
			baud_select,
			sample_enable
    );
	/*FPGA's clk =50Mz*/
	input rst,clk;
	input [2:0] baud_select;
	output sample_enable;
	
	/*kataxwritis gia tin apothikeysi tou kentro tis periodou (1/16*Baud_Rate)/2*/
	reg [9:0] divided_baud;
	
	reg [9:0] sample_counter;
	
	reg sample;
	
	/*assign to sima deigmatolipsias*/
	assign sample_enable = sample; 
	
	
	always @ (posedge clk or posedge rst)
	begin
			if(rst) begin
					 divided_baud = 10'b0;
			end
			else begin
			
				case(baud_select)
						
						3'b000: begin
										divided_baud = 10417; //Baud_rate=300bits/sec
									end
					
						3'b001: begin
										divided_baud = 2604; //Baud rate=1200 bits/sec
									end
						
						3'b010: begin
										divided_baud = 651; //Baud_rate=4800 bits/sec
									end
						
						3'b011: begin
										divided_baud = 326; //Baud_rate = 9600bits/sec
									end
						
						3'b100: begin
										divided_baud = 163; //Baud_Rate = 19200bits/sec
									end
						
						3'b101: begin
										divided_baud = 81; //Baud_Rate = 38400bits/sec
									end
						
						3'b110:	begin
										divided_baud = 54; //Baud_rate = 57600bits/sec
									end
						3'b111: begin
										divided_baud = 27; //Baud_rate = 115200bits/
									end
				
				
				endcase		
				
			end
			
	end
	
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
			sample_counter = 22'b0;
		end
		else begin
			
			if(sample_counter==divided_baud) begin
					sample = 1'b1;
					sample_counter = 10'b0;
			end
			else begin
					sample_counter = sample_counter + 1;
					sample = 1'b0;
			end
			
		end
			
	end
	
endmodule
