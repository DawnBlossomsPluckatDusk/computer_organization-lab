`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:43 06/02/2022 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	input clk,
	input rst,
	input [5:0] PC,
	
	output [31:0] Inst
    );

Inst_rom inst_rom0 (
  .clka(clk), // input clka
  .addra(PC), // input [5 : 0] addra
  .douta(Inst) // output [31 : 0] douta
);

endmodule
