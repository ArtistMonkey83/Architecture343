module controller(input logic [3:0] Cond,
				      input logic [1:0] Op,
					   input logic [5:0] Funct,
						input logic [3:0] ALUFlagOut,
						output logic PCSrc, 
									    MemtoReg,
									    we,
									    ALUSrc,
									    we3,
									    //clk,
									    //reset,
						output logic [1:0] RegSrc,
											    ImmSrc,
						output logic [2:0] ALUControl //new change
										 );
										 
		logic [11:0] controlsignals; //new change
		

always_comb
begin

	
	case(Op)
	
	2'b00: //Data
	case(Funct[4:1])
	
	
		
		4'b0100: //add
		case(Funct[5])
			1'b1:
			controlsignals=12'b0000001001x0;
			1'b0:
			controlsignals=12'b0000000xx100;
			default: 
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
			
		4'b0010: //sub
		case(Funct[5])
			1'b1:
			controlsignals=12'b0000011001x0;
			1'b0:
			controlsignals=12'b0000010xx100;
			default: 
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
		
		4'b0000: //and
		case(Funct[5])
			1'b1:
			controlsignals=12'b0000101001x0;
			1'b0:
			controlsignals=12'b0000100xx100;
			default: 
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
		
		4'b1100:// orr
		case(Funct[5])
			1'b1:
			controlsignals=12'b0000111001x0;
			1'b0:
			controlsignals=12'b0000110xx100;
			default: 
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
			
		4'b1111: //MVN - new change
		case(Funct[5])
			1'b1:
			controlsignals=12'b0001101001x0;
			1'b0:
			controlsignals=12'b0001100xx100;
			default:
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
			
		4'b0001: //EOR - new change
		case(Funct[5])
			1'b1:
			controlsignals=12'b0001011001x0;
			1'b0:
			controlsignals=12'b0001010xx100;
			default:
			controlsignals=12'bxxxxxxxxxxxx;
			endcase
		
		default: 
			controlsignals=12'bxxxxxxxxxxxx;
	
	endcase
	
	2'b01://Memory
	 case(Funct)
	 
		6'b011001:
			controlsignals=12'b0000001011x0;  //LDR [0,1,0,00,1,01,1,x0
		6'b011000:
			controlsignals=12'b0x1000101010;
			default: 
			controlsignals=12'bxxxxxxxxxxxx;
		endcase
	2'b10://Branch
			controlsignals=12'b1000001100x1;
	default: 
	controlsignals=12'bxxxxxxxxxxxx;
	
	
	endcase
end

assign {PCSrc, MemtoReg, we, ALUControl, ALUSrc, ImmSrc, we3, RegSrc} = controlsignals;
	
endmodule 

	
	
	
	
	
	
	
	