module add_one_bit_tb();
	logic result;
	logic cout;
	logic a;
	logic b;
	logic cin;
	
	// Device under test
	add_one_bit dut(
	.a      (a),
	.b      (b),
	.cin    (cin),
	.cout   (cout),
	);
	
	// Input Generation
	initial begin
	a = 1'b0; b = 1'b0; cin = 1'b0;
	#10;
	//A=B=Cin =0
	a = 1'b0; b = 1'b1; cin = 1'b0;
	#10;
	//A=1 & B=Cin =0
	a =1'b1;b = 1'b0; cin = 1'b0;
	#10;
	//A=B=1 &Cin =0
	a = 1'b1; b = 1'b1; cin = 1'b0;
	#10;
	//A=B=0 & Cin =1
	a = 1'b0; b = 1'b0; cin = 1'b1;
	#10;
	//A=0 & B=Cin=1
	a = 1'b0; b = 1'b1; cin = 1'b1;
	#10;
	//A=Cin=1 & B=0
	a = 1'b1; b = 1'b0; cin = 1'b1;
	#10;
	//A=B=Cin=1
	a = 1; b = 1; cin = 1;
	#10;
	end
	endmodule
	