`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:39:14 04/17/2022 
// Design Name: 
// Module Name:    ALU_Main 
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
module ALU_Main(
	input 		clk,
	input 		 S,
	input [31:0] B,
	input [31:0] A,
	input [3:0] ALU_op,
	input Shift_carry_out,
	input CF,
	input VF,
	
	output reg [31:0] F,
	output reg [3:0] NZCV
    );
	 reg Cout;
	 localparam FN = 3,FZ = 2,FC = 1,FV = 0;
	 always@(*)
	 begin
		case(ALU_op)
			4'h0: 
			begin
				F <= A & B;
			end
			4'h1:
			begin
				F <= A ^ B;
			end
			4'h2:
			begin
				{Cout,F} <= A - B;
			end
			4'h3:
			begin
				{Cout,F} <= B - A;			
			end
			4'h4:
			begin
				{Cout,F} <= A + B;
			end
			4'h5:
			begin
				{Cout,F} <= A + B + CF;
			end
			4'h6:
			begin
				{Cout,F} <= A -B + CF-1;
			end
			4'h7:
			begin
				{Cout,F} <= B - A + CF -1;
			end
			4'h8:
			begin
				F <= A;
			end
			4'hA:
			begin
				{Cout,F} <= A - B + 32'h4;
			end
			4'hC:
			begin
				F <= A | B;
			end
			4'hD:
			begin
				F <= B;
			end
			4'hE:
			begin
				F <= A & (~B);
				
			end
			4'hF:
			begin
				F <= ~B;
			end
		endcase
	 end
	 always@(negedge clk) begin 
		if(S == 1) begin
			NZCV[FN] <= F[31];
			if(F != 32'b0) NZCV[FZ] <= 0;
			else NZCV[FZ] <= 1;
			
			case(ALU_op)
			4'h0,4'h1,4'hC,4'hE,4'hF,4'h8,4'hD: begin
				NZCV[FC] <= Shift_carry_out;
				NZCV[FV] <= VF;
			end
			4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'hA: begin
				NZCV[FC] <= ALU_op[1] ^ Cout;
				NZCV[FV] <= A[31] ^ B[31] ^ F[31] ^ Cout;
			end
			
			endcase
				
		end
	 end
endmodule
