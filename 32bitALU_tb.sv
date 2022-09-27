module ALU_32_bits_tb();
	
	logic [31:0] A,B;
	logic [3:0] ALU_Op;
	logic [31:0] Result;
	logic [3:0] ALUFlags;
	
	//Unit under test
	ALU_32_bits uut (
	.A (A),
	.B (B),
	.ALU_Op (ALU_Op),
	.Result (Result),
	.ALUFlags (ALUFlags)
	);
	
	//Input generator
	initial begin
	A = 32'b0000;
	B = 32'b0000;
	ALU_Op = 4'b0000; #10;
	ALU_Op = 4'b0001; #10;
	ALU_Op = 4'b0010; #10;
	ALU_Op = 4'b0011; #10;
	ALU_Op = 4'b0100; #10;
	ALU_Op = 4'b0101; #10;
	ALU_Op = 4'b0110; #10;
	ALU_Op = 4'b0111; #10;
	ALU_Op = 4'b1011; #10;
	ALU_Op = 4'b1101; #10;
	
	A = 32'b0000;
	B = 32'b0001;
	ALU_Op = 4'b0000; #10;
	ALU_Op = 4'b0001; #10;
	ALU_Op = 4'b0010; #10;
	ALU_Op = 4'b0011; #10;
	ALU_Op = 4'b0100; #10;
	ALU_Op = 4'b0101; #10;
	ALU_Op = 4'b0110; #10;
	ALU_Op = 4'b0111; #10;
	ALU_Op = 4'b1011; #10;
	ALU_Op = 4'b1101; #10;
	
	A = 32'h7FFFFFFF;
	B = 32'b0001;
	ALU_Op = 4'b0000; #10;
	ALU_Op = 4'b0001; #10;
	ALU_Op = 4'b0010; #10;
	ALU_Op = 4'b0011; #10;
	ALU_Op = 4'b0100; #10;
	ALU_Op = 4'b0101; #10;
	ALU_Op = 4'b0110; #10;
	ALU_Op = 4'b0111; #10;
	ALU_Op = 4'b1011; #10;
	ALU_Op = 4'b1101; #10;
	end
endmodule
