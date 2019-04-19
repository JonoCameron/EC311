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

input [4:0] seven_in;
output [6:0] seven_out ;
reg [6:0] temp;

always @ (seven_in)
	begin
		case (seven_in)
			5'b00000: temp = 7'b0000001; // "0/O"     
			5'b00001: temp = 7'b1001111; // "1" 
			5'b00010: temp = 7'b0010010; // "2" 
			5'b00011: temp = 7'b0000110; // "3" 
			5'b00100: temp = 7'b1001100; // "4" 
			5'b00101: temp = 7'b0100100; // "5" 
			5'b00110: temp = 7'b0100000; // "6" 
			5'b00111: temp = 7'b0001111; // "7" 
			5'b01000: temp = 7'b0000000; // "8"     
			5'b01001: temp = 7'b0000100; // "9" 
			5'b01010: temp = 7'b0001000; // "A" 
			5'b01011: temp = 7'b1100000; // "B" 
			5'b01100: temp = 7'b0110001; // "C" 
			5'b01101: temp = 7'b1000010; // "D" 
			5'b01110: temp = 7'b0110000; // "E" 
			5'b01111: temp = 7'b0111000; // "F" 
			5'b10000: temp = 7'b1110001; // "L"
			5'b10001: temp = 7'b1000010; // "d"
			5'b10010: temp = 7'b0011000; // "P"
			5'b10011: temp = 7'b1101010; // "n"
			5'b10100: temp = 7'b1111110; // "-"
			5'b10101: temp = 7'B1111111; // "BLANK"
		endcase
	end
	
	assign seven_out = temp;
	
endmodule
