`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:44 04/17/2019 
// Design Name: 
// Module Name:    SSD_four_hex 
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
module SSD_four_hex(clk, load ,reset, user_inp, active_digit, seven_out);

input clk, load, reset;
input [3:0] user_inp;
reg [1:0] count = 2'b00;
reg [3:0] seven_in;
wire [6:0] seven_out_temp;

output reg [3:0] active_digit;
output [6:0] seven_out;
	
	// Also count value is operating in very  high frequency? Think about how to fix it!
wire w_load;
wire w_clk;

clk_dvdr		c0(clk, reset, w_clk);
debouncer 	d0(w_clk, reset, load, w_load);

always @(posedge load or posedge reset)
	if (reset)
		begin
				active_digit 	= 4'b0000;
				seven_in 		= 4'b1000;
				count				<= 2'b00;
		end
	else
		begin
		case (count)
		0: 
			begin 
				active_digit 	= 4'b1110; 			//display digit 1 (right)
				seven_in 		= user_inp [3:0];
				count 			<= 2'b01;
			end
		1:
			begin 
				active_digit 	= 4'b1101; 	//display digit 2
				seven_in 		= user_inp [3:0];
				count 			<= 2'b10;
			end
		2: 
			begin 
				active_digit 	= 4'b1011; 	//display digit 3
				seven_in 		= user_inp [3:0];
				count 			<= 2'b11;
			end	
		3:
			begin 
				active_digit 	= 4'b0111; 	//display digit 4
				seven_in 		= user_inp [3:0];
				count 			<= 2'b00;
			end
		endcase
		end
	
	

binaryToSegment a1(seven_in, seven_out_temp);
assign seven_out = seven_out_temp;


endmodule
