module ALU_32_bits (
	input logic [31:0] A,B,
	input logic [3:0] ALU_Op,
	output logic [31:0] Result,
	output logic [3:0] ALUFlags
);
	logic [31:0] Cin;
	logic [32:0] Sum;
	logic V,C,Z,N;
	
	always_comb begin
	case(ALU_Op)
		32'b0000: Result = A & B; //AND
		32'b0001: Result = A | B; //OR
		32'b0010: Result = A ^ B; //XOR
		32'b0011: Result = A + B; //ADD
		32'b0100: Result = A << B[4:0]; //Logical shift left
		32'b0101: Result = A >> B[4:0]; //Logical shift right
		32'b0110: Result = A >>> B[4:0]; //Arithmetic shigt right
		32'b0111: Result = A << (32-B[4:0] | A >> B[4:0]); //Rotate right
		32'b1011: Result = A + ~B + 1; //Subtract
		32'b1100: Result = A & ~B; //Bit clear
		default: Result = 0; //Undefined
	endcase
	end
	assign Cin = ALU_Op[0] ? ~B : B;
	assign Sum = A + Cin + ALU_Op[0];
	
	assign ALUFlags = {V,C,Z,N};
	assign V = (ALU_Op[1] == 1'b0) & ~(A[31] ^ B[31] ^ ALU_Op[0]) & (A[31] ^ Sum[31]);
	assign C = (ALU_Op[1] == 1'b0) & Sum[32];
	assign Z = (Result == 32'b0000);
	assign N = Result[31];

endmodule
