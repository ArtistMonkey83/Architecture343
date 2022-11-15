module PC_tb();
	logic[31:0] BranchAddress;
	logic[31:0] Instr;
	logic clk, PCsrc, reset;
	
	always #1 clk = ~clk;
	
	PC dut (.BranchAddress(BranchAddress),
	.PCSrc(PCSrc),
	.clk(clk),
	.reset(reset),
	.Instr(Instr)
	);	//device under test
	
	initial 
		begin
			BranchAddress = 32'h00000004; 
			clk = 0; 
			reset = 0;
			#10 PCsrc = 1;
			#5 PCsrc = 0;
			#100;
			$stop;
		end
endmodule	