module activity10 #(
			 parameter DATA_WIDTH = 32)
			 (output logic [DATA_WIDTH-1:0] WriteData, 
			  input logic [DATA_WIDTH-1:0] BranchAdd,
			  output logic [DATA_WIDTH-1:0] PCPLUS4,
			  input clk, reset,
			  input logic PCSrc);
			 
			 
			 
			 logic [DATA_WIDTH-1:0] wPC,wA;
			 
			 //Implement modules from activity 9
			 ff pc(.clk(clk),.PC(wPC), .A(wA), .reset(reset));
			 adder addy4(.A(wA), .PCPlus4(PCPLUS4));
	       mux2_1 plexi(.PCPlus4(PCPLUS4), .BranchAdd(BranchAdd), .PCSrc(PCSrc), .PC(wPC));
			 Instruction ROM(.RD(instructionoutput),.A(wA));
			 
			 //Implement modules for activity 10
			 mux2_1 #(32)  (plexiRA1(.PCPlus4(PCPLUS4), .BranchAdd(BranchAdd), .PCSrc(PCSrc), .PC(wPC));
			 mux2_1 #(4)   (plexiRA2(.PCPlus4(PCPLUS4), .BranchAdd(BranchAdd), .PCSrc(PCSrc), .PC(wPC));
			 mux2_1 #(4)   (plexiRD2(.PCPlus4(PCPLUS4), .BranchAdd(BranchAdd), .PCSrc(PCSrc), .PC(wPC));
			 extend signExtend(.ImmSrc(ImmSrc), .Instr(RD[23:0]), .ExtImm(ExtImm);
			 adder addy8(.A(wA), .PCPlus4(PCPLUS4));

endmodule 