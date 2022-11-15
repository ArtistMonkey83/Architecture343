module activity10_tb();
logic [31:0] instructionoutput,WriteData,RD2,SrcA,SrcB;
logic [31:0] BranchAdd;
logic [31:0] PCPLUS4, PCPlus8, Result;
logic clk,PCSrc, reset;
logic [1:0] RegSrc, RegWrite, ImmScr, ALUScr, WE3

			 
			 
			 
			 logic [DATA_WIDTH-1:0] wPC,wA,RD,ExtImm;
			 logic [3:0] RA1, RA2;

	// Device under test
	activity10 dut(
		.clk(clk),
		.instructionoutput (instructionoutput),
		.PCPLUS4 (PCPLUS4),.BranchAdd(BranchAdd),
		.PCSrc   (PCSrc)
	);
	
initial begin 
reset=1;
clk=0;
PCSrc = 0;
BranchAdd=32'h00000000;
end

always #5 clk=~clk;

initial begin
reset=0;
PCSrc = 1;


#20 PCSrc = 0;

#100 $stop;


end 

endmodule 