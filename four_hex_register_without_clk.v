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
module four_hex_register_without_clk(Out, In, clk, reset, load);
		
		input 	[3:0]In;
		input 	clk, reset, load;
		output	[15:0]Out;
		
		reg 		[1:0]select;
		reg		[15:0]Out;

		
always@(posedge load or posedge reset)
	if (reset == 1'b1)
		begin
			select <= 2'b0;
			Out <= 16'b0;
		end
	else
		begin
			case(select)
				2'b00: Out[15:12] <= In[3:0];
				2'b01: Out[11:8] <= In[3:0];
				2'b10: Out[7:4] <= In[3:0];
				2'b11: Out[3:0] <= In[3:0];
			endcase
			select <= select + 2'b01; 
		end
endmodule
				