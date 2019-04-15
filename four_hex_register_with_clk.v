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
module four_hex_register_with_clk(Out, In, clk, reset, load);
		
	input 		[3:0]In;
	input			clk, reset, load;
	output		[15:0]Out;
	
	wire 			w_clk;
	wire			[15:0]w_reg;
	wire			w_load;
	
	debouncer d0(clk, reset, load, w_load);
	clk_dvdr	m0 (.clk_in(clk), .rst(1'b0), .divided_clk(w_clk));
	four_hex_register_without_clk	m1(w_reg, In, w_clk, reset, w_load);
	
	assign Out = w_reg;
endmodule		