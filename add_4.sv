module add_4 (
	input [3:0] a, b,
	output [3:0] s,
	output cout
);

	wire [2:0] c;
	add_one_bit A0 (.a(a[0]), .b(b[0]), .cin(1'b0), .cout(c[0]), .result(s[0]));
	add_one_bit A1 (.a(a[1]), .b(b[1]), .cin(c[0]), .cout(c[1]), .result(s[1]));
	add_one_bit A2 (.a(a[2]), .b(b[2]), .cin(c[1]), .cout(c[2]), .result(s[2]));
	add_one_bit A3 (.a(a[3]), .b(b[3]), .cin(c[2]), .cout(cout), .result(s[3]));
endmodule
