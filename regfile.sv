module regfile(input  logic clk, 
               input  logic WE3, 
               input  logic [3:0]  RA1, RA2, WA3, //Read Address 1 & 2, Write Address 4 bits for 16 Registers
               input  logic [31:0] WD3, R15,
               output logic [31:0] RD1, RD2);

  logic [31:0] rf[14:0];

  always_ff @(posedge clk)
    if (WE3) rf[WA3] <= WD3;	//Evaluates to true if we want to write to a register
										//WA3 contains the write address of the register we are modifying 
										//WD3 contains the result we want to save
  
  assign RD1 = (RA1 == 4'b1111) ? R15 : rf[RA1]; //If RA1 is 15 access Program Counter, otherwise use RA1 to determine our register
  assign RD2 = (RA2 == 4'b1111) ? R15 : rf[RA2]; //If RA2 is 15 access Program Counter, otherwise use RA2 to determine our register
	
endmodule
