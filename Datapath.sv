//wires to deal with any muxs and alu/result thing
//A3 isnt a thing
module Datapath(input logic PCSrc, 
									 MemtoReg,
									 we,
									 ALUSrc,
									 we3,
									 clk,
									 reset,
					 input logic [1:0] RegSrc,
											 ImmSrc,
					 input logic [2:0] ALUControl, //new change
					output logic [3:0] ALUFlagOut,
					output logic [31:0] ALUResult, rd2, ReadData,
					output logic [3:0] Cond,
					output logic [1:0] Op,
					output logic [5:0] Funct);
					
					
					  logic [31:0] PCN, PC, PC4, PC8;
							 logic [31:0] rd, a;
							 logic [3:0] ra1, ra2, wa3, ALUFlags; //registers
							 logic [31:0] Result, wd, rd1, wd3, ExtImm, SrcB;
							 
// instantiate your components here. Make sure you declare all your internal wire connections. 

	
		mux2 #(32) PCMux(.d0(PC4), .d1(Result), .s(PCSrc), .y(PCN));
		flopr #(32) PCCLK(.clk(clk), .d(PCN), .q(PC), .reset(reset));
		adder #(32) PC4Adder(.a(PC), .b(32'd4), .y(PC4));
		adder #(32) PC8Adder(.a(PC4), .b(32'd4), .y(PC8));
		imem myInstr(.a(PC), .rd(rd));
		mux2 #(4) A2Mux(.d0(rd[3:0]), .d1(rd[15:12]), .s(RegSrc[1]), .y(ra2));
		mux2 #(4) A1Mux(.d0(rd[19:16]), .d1(4'b1111), .s(RegSrc[0]), .y(ra1));
		regfile myReg(.clk(clk), .we3(we3), .ra1(ra1), .ra2(ra2), .wa3(rd[15:12]), .wd3(Result), .r15(PC8), .rd1(rd1), .rd2(rd2));
		extend myextend(.Instr(rd[23:0]), .ImmSrc(ImmSrc), .ExtImm(ExtImm));
		mux2 #(32) ALUMux(.d0(rd2), .d1(ExtImm), .s(ALUSrc), .y(SrcB));
		alu myalu(.a(rd1), .b(SrcB), .ALUControl(ALUControl), .ALUResult(ALUResult), .ALUFlags(ALUFlags));
		flopr #(4) ALUFLAG(.clk(clk), .reset(reset), .d(ALUFlags), .q(ALUFlagOut));
//		flopr #(4) Condition(.clk(clk), .reset(reset), .d(rd[31:28]), .q(Cond));
//		flopr #(2) OpC(.clk(clk), .reset(reset), .d(rd[27:26]), .q(Op));
//		flopr #(6) FunctC(.clk(clk), .reset(reset), .d(rd[25:20]), .q(Funct));
		dmem myMem(.clk(clk), .a(ALUResult), .we(we), .wd(rd2), .rd(ReadData));
		mux2 #(32) MemMux(.d0(ALUResult), .d1(ReadData), .s(MemtoReg), .y(Result));
				
		assign Cond = rd[31:28]; 
		assign Op = rd[27:26];
		assign Funct = rd[25:20];
	
endmodule 					  

// adder to be used for PC+4					  
module adder #(parameter WIDTH=8)
              (input  logic [WIDTH-1:0] a, b,
               output logic [WIDTH-1:0] y);
             
  assign y = a + b;
endmodule

// FlipFlop with enable and reset

module flopenr #(parameter WIDTH = 8)
                (input  logic             clk, reset, en,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);

  always_ff @(posedge clk, posedge reset)
    if (reset)   q <= 0;
    else if (en) q <= d;
endmodule

// FlipFlop with reset only
module flopr #(parameter WIDTH = 8)
              (input  logic             clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule

// 2X1 Mux
module mux2 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, 
              input  logic             s, 
              output logic [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 
endmodule

