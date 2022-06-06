`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:19 04/18/2022 
// Design Name: 
// Module Name:    ALU_barrel 
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
module ALU_barrel(
	input 		clk,
	input 			S,
	input [31:0] Shift_Data,
	input [7:0] Shift_Num,
	input [2:0] Shift_op,
	
	input [31:0] A,
	input [3:0] ALU_op,
	
	output wire [31:0] F
    );
	 wire [31:0] B;
	 wire Shift_carry_out;
	 wire [3:0]			NZCV;
	Barrel_Shift shift(Shift_Data,Shift_Num,NZCV[1],Shift_op,B,Shift_carry_out);
	ALU_Main ALU(clk,S,B,A,ALU_op,Shift_carry_out,NZCV[1],NZCV[0],F,NZCV);
	 
endmodule
