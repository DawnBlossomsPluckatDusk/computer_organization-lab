`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:56 06/02/2022 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	input [31:0] inst,
	
	input [31:0] Data_A,
	input [31:0] Data_B,
	input [31:0] Data_C,
	
	output reg[31:0] Shift_Data,
	output reg[31:0] ALU_A,
	output reg[7:0]  Shift_Num,
	output reg[2:0]  Shift_op,
	output reg[3:0]  ALU_op,
	
	output reg[3:0] Addr_A,
	output reg[3:0] Addr_B,
	output reg[3:0] Addr_C,
	output reg[3:0] W_Addr,
	output reg 		 Write_Reg,
	output reg		 S
	
    );
	 
	 reg[31:0] imm_data;
	 reg[7:0]  imm1_shift;
	 reg[8:0]  imm2_shift;
	 reg 		  rm_imm_s;
	 reg[1:0]  rs_imm_s;
	 reg 		  Error;
	 
	 always@(*) begin
		Write_Reg <= 1;
		S <= inst[20];
		ALU_op <= inst[24:21];
		Addr_A <= inst[19:16];
		Addr_B <= inst[3:0];
		Addr_C <= inst[11:8];
		W_Addr <= inst[15:12];
		imm_data <= {24'b0,inst[7:0]};
		imm1_shift <= {3'b0,inst[11:7]};
		imm2_shift <= {{3'b0,inst[11:8]},2'b0};
		if((inst[27:25]==3'b000) &&(inst[4]==0) && (inst[15:12]!=4'b1111)) begin
			rm_imm_s <= 1'b0;
			rs_imm_s <= 2'b0;
			Shift_op <= {inst[6:5],1'b0};
			
		end
		else if((inst[27:25]==3'b000) &&(inst[4]==1) && (inst[7]==0) && (inst[15:12]!=4'b1111)) begin
			rm_imm_s <= 1'b0;
			rs_imm_s <= 2'b1;
			Shift_op <= {inst[6:5],1'b1};
		end
		else if((inst[27:25]==3'b001) && (inst[15:12]!=4'b1111)) begin
			rm_imm_s <= 1'b1;
			rs_imm_s <= 2'b10;
			Shift_op <= 3'b111;
		end
		else begin
			Error =1;
		end
	 end
	 
	 always@(*) begin
		if(rm_imm_s == 1'b0) Shift_Data <= Data_B;
		else Shift_Data <= imm_data;
		if(rs_imm_s == 2'b00) Shift_Num <= imm1_shift;
		else if(rs_imm_s ==2'b01) Shift_Num <= Data_C;
		else Shift_Num <= imm2_shift;
		
		ALU_A <= Data_A;
	 end

endmodule
