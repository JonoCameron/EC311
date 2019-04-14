`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:17 04/14/2019 
// Design Name: 
// Module Name:    four_bit_register_with_clk 
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
module four_bit_register_with_clk(Out, In, clk, reset, load);
	input 		[3:0]In;
	input			clk, reset, load;
	output		[3:0]Out;
	
	//reg 		[3:0] Out;
	wire 			w_clk;
	wire			[3:0]w_reg;

	clk_dvdr	m0 (.clk_in(clk), .rst(1'b0), .divided_clk(w_clk));
	four_bit_register	m1(w_reg, In, w_clk, reset, load);
	
	assign Out = w_reg;
endmodule
 