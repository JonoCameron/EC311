`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:31 04/14/2019 
// Design Name: 
// Module Name:    binary_to_segment 
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
module binaryToSegment( seven_in, seven_out);

input [3:0] seven_in;
output [6:0] seven_out ;
reg [6:0] temp;

always @ (seven_in)
	begin
		case (seven_in)
			4'b0000: temp = 7'b0000001; // "0"     
			4'b0001: temp = 7'b1001111; // "1" 
			4'b0010: temp = 7'b0010010; // "2" 
			4'b0011: temp = 7'b0000110; // "3" 
			4'b0100: temp = 7'b1001100; // "4" 
			4'b0101: temp = 7'b0100100; // "5" 
			4'b0110: temp = 7'b0100000; // "6" 
			4'b0111: temp = 7'b0001111; // "7" 
			4'b1000: temp = 7'b0000000; // "8"     
			4'b1001: temp = 7'b0000100; // "9" 
			4'b1010: temp = 7'b0001000; // "A" 
			4'b1011: temp = 7'b1100000; // "B" 
			4'b1100: temp = 7'b0110001; // "C" 
			4'b1101: temp = 7'b1000010; // "D" 
			4'b1110: temp = 7'b0110000; // "E" 
			default: temp = 7'b0111000; // "F" 
		endcase
	end
	
	assign seven_out = temp;
	
endmodule
