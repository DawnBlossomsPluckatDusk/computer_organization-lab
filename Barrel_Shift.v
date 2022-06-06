`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:08:17 04/18/2022 
// Design Name: 
// Module Name:    Barrel_Shift 
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
module Barrel_Shift(
	input  [31:0]      Shift_Data,
	input  [7:0]       Shift_Num,
	input              Carry_Flags,
	input  [2:0]       Shift_op,
	
	output reg [31:0]  Shift_out,
	output reg         Shift_carry_out
    );
	 always@(*)
	 begin
		case(Shift_op[2:1])
			2'b00: 
			begin
				if(Shift_Num == 0)
						Shift_out <= Shift_Data;
				if(Shift_Num >= 1 && Shift_Num <= 32)
					begin
						Shift_out <= Shift_Data << Shift_Num;
						Shift_carry_out <= Shift_Data[32-Shift_Num];
					end
				if(Shift_Num > 32)
					begin
						Shift_out <= 0;
						Shift_carry_out <= 0;
					end
			end
			2'b01: 
			begin
				if(Shift_op[0] == 0 && Shift_Num == 0)
					begin
						Shift_out <= 0;
						Shift_carry_out <= Shift_Data[31];
					end
				if(Shift_op[0] == 1 && Shift_Num == 0)
					Shift_out <= Shift_Data;
				if(Shift_Num >= 1 && Shift_Num <= 32)
					begin
						Shift_out <= Shift_Data >> Shift_Num;
						Shift_carry_out <= Shift_Data[Shift_Num-1];
					end
				if(Shift_Num > 32)
					begin
						Shift_out <= 0;
						Shift_carry_out <= 0;
					end
			end
			2'b10: 
			begin
				if(Shift_op[0] == 0 && Shift_Num == 0)
					begin
						Shift_out <= {32{Shift_Data[31]}};
						Shift_carry_out <= Shift_Data[31];
					end
				if(Shift_op[0] == 1 &&Shift_Num == 0)
					Shift_out <= Shift_Data;
				if(Shift_Num >= 1 && Shift_Num <=32)
					begin
						Shift_out <= {{32{Shift_Data[31]}},Shift_Data} >> Shift_Num;
						Shift_carry_out <= Shift_Data[31];
					end
				if(Shift_Num >32)
					begin
						Shift_out <= {32{Shift_Data[31]}};
						Shift_carry_out <= Shift_Data[31];
					end
			end
			2'b11:
			begin
				if(Shift_op[0] == 0 && Shift_Num == 0)
					begin
						Shift_out <= {Carry_Flags,Shift_Data[31:1]};
						Shift_carry_out <= Shift_Data[31];
					end
				if(Shift_op[0] == 1 && Shift_Num == 0)
						Shift_out <= Shift_Data;
				if(Shift_Num >= 1 && Shift_Num <=32)
					begin
						Shift_out <= {Shift_Data,Shift_Data} >> Shift_Num;
						Shift_carry_out <= Shift_Data[Shift_Num-1];
					end
				if(Shift_Num > 32)
					begin
						Shift_out <= {{32{Shift_Data}},Shift_Data} >> Shift_Num[4:0];
						Shift_carry_out <= Shift_Data[Shift_Num[4:0]-1];
					end
			end
					
		endcase
	 
	 end

endmodule
