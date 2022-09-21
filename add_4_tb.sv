module add_4_tb();
	logic cout;
	logic [3:0] a;
	logic [3:0] b;
	logic [3:0] s;
	
	//Device under test
	add_4 dut(
		.a (a),
		.b (b),
		.s (s),
		.cout (cout)
);

// input generation
	initial begin

	a = (4'b0011); b = 4'b0011; 
	#10;

	a =4'b0111; b = 4'b0111; 
	#10;

	a =4'b1011; b = 4'b1011; 
	#10;

	a =4'b0001; b = 4'b0001; 
	#10;
	
	end
	endmodule
	