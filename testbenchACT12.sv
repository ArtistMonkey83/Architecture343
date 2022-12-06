module testbench();

			 logic clk, reset, MemWrite, MemtoReg;
			 logic [3:0] ALUControl;
			 logic PCSrc,ALUScr,RegWrite;
			 logic [1:0] RegSrc,ImmScr;
			 logic [11:0] ToControler;
			 logic [3:0] Flags;
			 logic [31:0] dataout;
       logic [10:0] testvector[0:100];
			 logic [31:0] vectornumber;



topmodule uut(clk, reset, MemWrite, MemtoReg,
					  ALUControl,
					  PCSrc,ALUScr,RegWrite,
					  RegSrc,ImmScr,

					  ToControler,
					  Flags, dataout
					  );

  // instantiate device to be tested
//  activity10 dut(clk, reset, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, PCSrc, MemWrite, ALUFlags, ALUResult, WriteData);
//  activity9 uut(clk, reset,instructionoutput,BranchAdd,PCPLUS4,PCSrc);
  // initialize test
  initial
    begin
		clk=0;
      reset = 1; # 12; reset = 0;
		MemWrite=0; MemtoReg=0;
					  ALUControl=4'b0011;
					  PCSrc=0;
					  ALUScr=1;
					  RegWrite=1;
					  RegSrc=2'b00;
					  ImmScr=2'b00;
	#100 $stop;
    end

// apply testvector
$readmemb("alu.tv", testvector);   // read test vector
#10 vectornumber = 0;



  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end



endmodule
