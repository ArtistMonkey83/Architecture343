//Multiplexer determine what address to use for PC
module mux2_1 #(DataWidth = 32)(input logic [DataWidth - 1:0]PCPlus4,
				   input logic [DataWidth - 1:0]BranchAdd,
				   input logic  PCSrc, 
				   output logic[DataWidth - 1:0]PC);
	//if load is 1 branch address
	//if load is 0 PCPlus4
	always_comb begin	
		case(PCSrc)
	//enable is 0, we aren't adding value doesn't go through adder does
		1'b0: PC = PCPlus4;
	
	//enable is 1, we are using the multiplexer, value does go through
		1'b1: PC = BranchAdd;
		endcase
	end
endmodule
