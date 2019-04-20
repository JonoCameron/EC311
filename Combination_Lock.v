`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:37 04/18/2019 
// Design Name: 
// Module Name:    Combination_Lock 
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
module Combination_Lock(input clk,
    input rst,
    input clr,
    input ent,
    input change,
	output reg [5:0] led,
	output reg [19:0] ssd,
    input [3:0] sw); 


//registers

 reg [15:0] password; 
 reg [15:0] inpassword;
 reg [5:0] current_state;
 reg [5:0] next_state;	
 reg clk;
 reg [3:0] seven_in;
 reg [6:0] seven_out_temp;
 output reg [3:0] active_digit;
 output [6:0] seven_out;

// parameters for States, you will need more states obviously
parameter IDLE 						= 6'b000000; //idle state 
parameter GetFirstDigit_lock 		= 6'b000001; // get_first_input_state // this is not a must, one can use counter instead of having another step, design choice
parameter GetSecondDigit_lock 	= 6'b000010;
parameter GetThirdDigit_lock		= 6'b000011;
parameter GetFourthDigit_lock		= 6'b000100;
parameter GetFirstDigit_unlock	= 6'b000101;
parameter GetSecondDigit_unlock	= 6'b000110;
parameter GetThirdDigit_unlock	= 6'b000111;
parameter GetFourthDigit_unlock	= 6'b001000;
parameter GetFirstDigit_change	= 6'b001001;
parameter GetSecondDigit_change	= 6'b001010;
parameter GetThirdDigit_change	= 6'b001011;
parameter GetFourthDigit_change	= 6'b001100;
parameter UNLOCK_MODE				= 6'b001101;
parameter CHANGE_PASSWORD_MODE	= 6'b001110;
parameter CHECK_STATE_L2U			= 6'b001111; //check password matches going from locked to unlocked mode
parameter CHECK_STATE_U2L			= 6'b010000; //check password matches going from unlocked to locked mode
//parameter BACKDOOR					= 6'b00????; 

  
 //get_second_input state
// parameters for output, you will need more obviously
parameter C=5'b01100; // you should decide on what should be the value of C, the answer depends on your binary_to_segment file implementation
parameter L=5'b10000; 
parameter S=5'b00101;// same for L and for other guys, each of them 5 bit. IN ssd module you will provide 20 bit input, each 5 bit will be converted into 7 bit SSD in binary to segment file.
parameter d=5'b10001;
parameter O=5'b00000;
parameter P=5'b10010;
parameter E=5'b01110; 
parameter n=5'b10011;
parameter DASH=5'b10100; 
parameter BLANK=5'b10101;

c0 clk_dvdr(clk, rst, clk);


//Sequential part for state transitions
	always @ (posedge clk or posedge rst)
	begin
		// your code goes here
		if (rst==1)
		begin
			current_state <= IDLE;
			assign password[15:0] = 16'b0000000000000000;
		end
		else
			current_state <= next_state;
		
	end

	


	// combinational part - next state definitions
	always @ (*)
	begin
		if (current_state == IDLE)
		begin
//			assign password[15:0] = 16'b0000000000000000; DONT THINK THIS SHOULD BE HERE
			
			if (ent == 1)
				next_state = GetFirstDigit_lock;
			else 
				next_state = current_state;
			
		end

		else if ( current_state == GetFirstDigit_lock )
			if (ent == 1)
			 	next_state = GetSecondDigit_lock;
			else
			 	next_state = current_state;
				
		else if ( current_state == GetSecondDigit_lock )
			if (ent == 1)
				next_state = GetThirdDigit_lock;
			else
				next_state = current_state;
		
		else if ( current_state == GetThirdDigit_lock )
			if (ent == 1)
				next_state = GetFourthDigit_lock;
			else
				next_state = current_state;
		
		else if ( current_state == GetFourthDigit_lock )
			if (ent == 1 )//&& inpassword == password)  // POTENTIAL FAILURE POINT AT "inpassword == password" PERHAPS CONDITION NEEDS MOVING ELSEWHERE
				next_state = CHECK_STATE_L2U;
			else
				next_state = current_state;
				
		else if ( current_state == CHECK_STATE_L2U )
			if ( password == inpassword )
				next_state = UNLOCK_MODE;
			else
				next_state = IDLE;
				
		else if ( current_state == UNLOCK_MODE )
			if (change == 1)
				next_state = GetFirstDigit_change;
			else
				next_state = current_state;
				
		else if ( current_state == GetFirstDigit_change )
			if (ent == 1)
				next_state = GetSecondDigit_change;
			else
				next_state = current_state;
				
		else if ( current_state == GetSecondDigit_change )
			if (ent == 1)
				next_state = GetThirdDigit_change;
			else
				next_state = current_state;
				
		else if ( current_state == GetThirdDigit_change )
			if (ent == 1)
				next_state = GetFourthDigit_change;
			else
				next_state = current_state;
				
		else if ( current_state == GetFourthDigit_change )
			if (ent == 1)
				next_state = UNLOCK_MODE;
			else
				next_state = current_state;
			
		else if ( current_state == UNLOCK_MODE )
			if (ent == 1)
				next_state = GetFirstDigit_unlock;
			else
				next_state = current_state;
		
		else if ( current_state == GetFirstDigit_unlock )
			if (ent == 1)
				next_state = GetSecondDigit_unlock;
			else
				next_state = current_state;
				
		else if ( current_state == GetSecondDigit_unlock )
			if (ent == 1)
				next_state = GetThirdDigit_unlock;
			else 
				next_state = current_state;
		
		else if ( current_state == GetThirdDigit_unlock )
			if (ent == 1)
				next_state = GetFourthDigit_unlock;
			else
				next_state = current_state;
		
		else if ( current_state == GetFourthDigit_unlock )
			if (ent == 1 )//&& inpassword == password)  // POTENTIAL FAILURE POINT AT "inpassword == password" PERHAPS CONDITION NEEDS MOVING ELSEWHERE
				next_state = CHECK_STATE_U2L;
			else
				next_state = current_state;
			
		else if ( current_state == CHECK_STATE_U2L )
			if ( password == inpassword )
				next_state = IDLE;
			else
				next_state = UNLOCK_MODE;
				
	end
		/*
		you have to complete the rest, in this combinational part, DO NOT ASSIGN VALUES TO OUTPUTS DO NOT ASSIGN VALUES TO REGISTERS
		just determine the next_state, that is all. password = 0000 -> this should not be there for instance or LED = 1010 this should not be there as well

		else if 

		else if



		
		else
			next_state = current_state;

	end

*/

	 //Sequential part for control registers, this part is responsible from assigning control registers or stored values
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
		begin
			inpassword[15:0]<=0; // password which is taken coming from user, 
			password[15:0]<=0;
		end

		else 
			if( current_state == IDLE )
			begin
//			 	password[15:0] <= 16'b0000000000000000; // Built in reset is 0, when user in IDLE state.
				 // you may need to add extra things here.
			end
		
			else if ( current_state == GetFirstDigit_lock )
			begin
				if(ent == 1)
					inpassword[15:12] <= sw[3:0]; // inpassword is the password entered by user, first 4 digin will be equal to current switch values
			end

			else if ( current_state == GetSecondDigit_lock )
			begin
				if (ent == 1)
					inpassword[11:8] <= sw[3:0]; // inpassword is the password entered by user, second 4 digit will be equal to current switch values
			end

			else if ( current_state == GetThirdDigit_lock )
			begin
				if (ent == 1)
					inpassword[7:4] <= sw[3:0];
			end
			
			else if ( current_state == GetFourthDigit_lock )
			begin
				if (ent == 1)
					inpassword[3:0] <= sw[3:0];
			end
				
			else if ( current_state == GetFirstDigit_change )
			begin
				if (ent == 1)
					password[15:12] <= sw[3:0];
			end
			
			else if ( current_state == GetSecondDigit_change )
			begin 
				if (ent == 1)
					password[11:8] <= sw[3:0];
			end
			
			else if ( current_state == GetThirdDigit_change )
			begin
				if (ent == 1)
					password[7:4] <= sw[3:0];
			end
			
			else if ( current_state == GetFourthDigit_change )
			begin
				if (ent == 1)
					password[3:0] <= sw[3:0];
			end
			
			else if ( current_state == GetFirstDigit_unlock )
			begin
				if (ent == 1)
					inpassword[15:12] <= sw[3:0];
			end
				
			else if ( current_state == GetSecondDigit_unlock )
			begin
				if (ent == 1)
					inpassword[11:8] <= sw[3:0];
			end
			
			else if (current_state == GetThirdDigit_unlock )
			begin
				if (ent == 1)
					inpassword[7:4] <= sw[3:0];
			end
			
			else if ( current_state == GetFourthDigit_unlock )
			begin
				if (ent == 1 )
					inpassword[3:0] <= sw[3:0];
			end
			
		/*

		Complete the rest of ASM chart, in this section, you are supposed to set the values for control registers, stored registers(password for instance)
		number of trials, counter values etc... 

		

	end


	// Sequential part for outputs; this part is responsible from outputs; i.e. SSD and LEDS


	always @(posedge clk)
	begin

		if(current_state == IDLE)
		begin
		ssd <= {C, L, five, d};	//CLSD
		end

		else if(current_state == GETFIRSTDIGIT)
		begin
		ssd <= { 0,sw[3:0], blank, blank, blank};	// you should modify this part slightly to blink it with 1Hz. The 0 is at the beginning is to complete 4bit SW values to 5 bit.
		end

		else if(current_state == GETSECONDIGIT)
		begin
		ssd <= { tire , 0,sw[3:0], blank, blank};	// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		end
		/*
		 You need more else if obviously

		
	end

binartosegment(ssd[19:15
active digit 4'b0111
assign sevenout = sevenouttemp;
endmodule

*/