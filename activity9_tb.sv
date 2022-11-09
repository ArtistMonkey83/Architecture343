module activity9_tb();
logic [31:0] instructionoutput;
logic [31:0] BranchAdd;
logic [31:0] PCPLUS4;
logic clk,PCSrc, reset;

	// Device under test
	activity9 dut(
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