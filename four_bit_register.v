`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:23 04/11/2019 
// Design Name: 
// Module Name:    four_bit_register 
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
module four_bit_register(Out, In, clk, reset, load);
	input 	[3:0]In;
	input		clk, reset, load;
	output	[3:0]Out;
	
	reg [3:0] Out;
	
	always@(posedge clk or posedge reset or posedge load)
	if (reset) begin
		Out <= 4'b0;
	end else if (load) begin
		Out <= In;
	end else begin
		Out <= Out;
	end
endmodule
				