// EECE 343 Fall 2022
// Activity 8 
// Student Name: Yolanda Reyes
// 
// Simple calculator that only adds
// Do not change module name or port definitions. 



module Activity8 #(
			parameter DATA_WIDTH = 8)
			(input logic clk, reset, load, display, 
			 input logic [DATA_WIDTH-1:0] value, 
			 output logic [2*DATA_WIDTH-1:0] sum);

logic [15:0] wvalue, wsum, wdata, wdout, wtotal, wdisplay;
logic wload,waccen;
	
// Clock
always_ff @(posedge Clk, posedge Reset)
	if(Reset)begin total = 0; sum = 0;end
	else total <= sum;
endmodule
	
//Memory, flip flop for total
module ffmem(input logic [15:0] sum,
				 input logic display,
				 output logic [15:0] total);
				 
	always_ff @(posedge Clk, posedge Reset)
		if (display) total = sum;
		else
			sum = sum + adderdata; 
endmodule

//Display or Accumulate
module accumulator(input logic clk, enable, Reset, adderdata, adderenable,
						 input logic [15:0] muxdata,
						 output [15:0] sum);
						 
	//checking if the Reset is activated
	if(Reset) sum = 16'h00; //reset the sum to zero
	else if (enable) sum = muxdata;

	always_comb begin	
		//represents the NAND
		case(enable)
			//enable is 0, we are displaying, data isn't let through
			1'b0: sum = sum + adderdata;
	
			//enable is 1, we are accummulating data is let through
			1'b1: sum = adderdata;
		
		endcase
	end
endmodule 

//padder
module pad(logic input [7:0] value, logic output [15:0] paddedval);
	paddedval = {00000000, value}; //taking the 8 bit value and padding it with 0's
endmodule

//adder
module adder(logic input [15:0] paddedval, sum, 
				 logic output [15:0] data);
	// takes padded value and sum, adds them to data
	assign sum = paddedval + sum;

	//passes data to the multiplexer
	data <= sum;
endmodule

//multiplexer
module multi(logic input [15:0]data, value, 
				 logic input select, 
				 logic output [15:0]dout);
	//if load is 1 activate multiplexer
	//if load is 0 deactivate multiplexer
	always_comb begin	
		case(select) begin
	//enable is 0, we aren't adding value doesn't go through adder does
		1'b0: dout = data;
	
	//enable is 1, we are using the multiplexer, value does go through
		1'b1: dout = value;
	
		endcase
	end

endmodule

 	