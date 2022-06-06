`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:11 04/20/2022 
// Design Name: 
// Module Name:    Reg_general 
// Project Name: 
// Target Devices: 
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
module Reg_general(
	input clk,
	input rst,
	input [3:0] R_Addr_A,
	input [3:0] R_Addr_B,
	input [3:0] R_Addr_C,
	input [3:0] W_Addr,
	input [31:0] W_Data,
	input Write_Reg,
	
	output reg [31:0] R_Data_A,
	output reg [31:0] R_Data_B,
	output reg [31:0] R_Data_C
    );
	 
	 //reg 
	 reg [31:0] R[15:0];
	 
	 //Error
	 reg Error_M_MSB;
	 reg Error_M_other;
	 reg Error_Read;
	//others
	 integer i;
	//write
	always@(negedge clk or posedge rst)
	begin
		//reset
		if(rst == 1)
		begin
			//clear Reg
			for(i=0;i<=15;i=i+1)
			begin 
				R[i] <= 0;
			end
		end
	   else
		begin
			//Work mode error
			if(W_Addr == 15)
			begin
				Error_M_MSB <= 1;
			end else
			begin
				Error_M_MSB <= 0;
				if(Write_Reg)
				begin 
					if(W_Addr < 15) R[W_Addr] <= W_Data;
				end
			end
		end
	end
	//read
	always@(*)
	begin
			//A
			R_Data_A <= R[R_Addr_A];
			
			//B
			R_Data_B <= R[R_Addr_B];
			
			//C
			R_Data_C <= R[R_Addr_C];
	end
endmodule
