module top(input logic clk, 
							  reset,
			  output logic MemWrite, 
			  output logic [31:0] WriteData, 
			                      ReadData, 
										 ALUResult);
										 
logic PCSrc, 
	   MemtoReg,
	   ALUSrc,
		we3;
		
logic [1:0]		RegSrc,
		         ImmSrc;
logic [2:0]    ALUControl; //new change
logic [3:0] ALUFlagOut;
logic [3:0] Cond;
logic [1:0] Op;
logic [5:0] Funct;

Datapath DataAndController(.PCSrc(PCSrc),
			.MemtoReg(MemtoReg),
			.we(MemWrite),
			.ALUSrc(ALUSrc),
			.we3(we3),
			.clk(clk),
			.reset(reset),
			.RegSrc(RegSrc),
			.ImmSrc(ImmSrc),
			.ALUControl(ALUControl),
			.ALUFlagOut(ALUFlagOut),
			.ALUResult(ALUResult), 
			.rd2(WriteData),
			.Cond(Cond),
			.Op(Op),
			.Funct(Funct),
			.ReadData(ReadData));

controller myController(.Cond(Cond),
								.Op(Op),
								.Funct(Funct),
								.ALUFlagOut(ALUFlagOut),
								.PCSrc(PCSrc), 
								.MemtoReg(MemtoReg),
								.we(MemWrite),
								.ALUSrc(ALUSrc),
								.we3(we3),
								.RegSrc(RegSrc),
								.ImmSrc(ImmSrc),
								.ALUControl(ALUControl));
endmodule
