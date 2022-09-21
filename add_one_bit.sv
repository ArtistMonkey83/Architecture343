module add_one_bit(
	input a,
	input b,
	input cin,
	output cout,
	output result
 );
 
	assign result = a ^ b ^ cin;
	assign cout = (a && b) || (a && cin) || ( b && cin);
	endmodule
	