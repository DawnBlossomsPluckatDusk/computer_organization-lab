`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:17:00 06/01/2022 
// Design Name: 
// Module Name:    Fetch_PC 
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
module Fetch_PC(
	input clk,
	input rst,
	
	output reg [5:0] PC_code
    );
	 reg [31:0] PC;
	 
	 always@(posedge rst or negedge clk) begin
		if(rst) begin
			PC <= 32'h0;
		end else begin
			 PC_code = PC[7:2]; 
			 PC <= PC + 32'h4;
		end
	 end

endmodule
