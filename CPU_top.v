`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:25 06/01/2022 
// Design Name: 
// Module Name:    CPU_top 
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
module CPU_top(
	input clk,
	input rst,
	
	output [5:0] pc,
	output [31:0] inst,
	output [31:0] Data_A,
	output [31:0] Data_B,
	output [31:0] Data_C,
	
	output [31:0] F
	
	
    );
	 
	 wire [3:0] Addr_A;
	 wire [3:0] Addr_B;
	 wire [3:0] Addr_C;
	 wire [3:0] W_Addr;
	 wire [31:0] Shift_Data;
	 wire [31:0] ALU_A;
	 wire [7:0] Shift_Num;
	 wire [2:0] Shift_op;
	 wire [3:0] ALU_op;
	 wire 		Write_Reg;
	 wire 		S;
	 
	 
	 Fetch_PC pc0(
		.clk(clk),
		.rst(rst),
		.PC_code(pc)
		);
		
	 IF_ID if_id0(
		.clk(clk),
		.rst(rst),
		.PC(pc),
		.Inst(inst)
		);
		
	Reg_general Reg0(
		.clk(clk),
		.rst(rst),
		.R_Addr_A(Addr_A),
		.R_Addr_B(Addr_B),
		.R_Addr_C(Addr_C),
		.W_Addr(W_Addr),
		.W_Data(F),
		.Write_Reg(Write_Reg),
		.R_Data_A(Data_A),
		.R_Data_B(Data_B),
		.R_Data_C(Data_C)
		);
		
		
	 ID_EX id_ex0(
		.inst(inst),
		.Data_A(Data_A),
		.Data_B(Data_B),
		.Data_C(Data_C),
		.Shift_Data(Shift_Data),
		.ALU_A(ALU_A),
		.Shift_Num(Shift_Num),
		.Shift_op(Shift_op),
		.ALU_op(ALU_op),
		.Addr_A(Addr_A),
		.Addr_B(Addr_B),
		.Addr_C(Addr_C),
		.W_Addr(W_Addr),
		.Write_Reg(Write_Reg),
		.S(S)
		);
		
		ALU_barrel alu0(
			.Shift_Data(Shift_Data),
			.Shift_Num(Shift_Num),
			.Shift_op(Shift_op),
			.A(ALU_A),
			.ALU_op(ALU_op),
			.S(S),
			.clk(clk),
			.F(F)
			);

endmodule
