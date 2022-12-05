module alu(input logic [31:0] a, b,
 input logic [2:0] ALUControl, //new change 
 output logic [31:0] ALUResult,
 output logic [3:0] ALUFlags);
 
 logic [31:0] sum;
 logic cout;
 logic [31:0] sb;
 
 my_mux mux1(.ALUselect(ALUControl[0]), .B(b), .sb(sb));
 rc_adder adder1(.a(a), .b(sb), .cin(ALUControl[0]), .sum(sum), .cout(cout));
 
 
 
 
 always_comb
	begin
		cout=0;
		ALUFlags[0]=1'b0; //V
	   ALUFlags[1]=1'b0; //C
		ALUFlags[2]=1'b0; //Z
		ALUFlags[3]=1'b0; //N
		ALUResult=sum;
		
		
		if(ALUControl == 3'b000) //Add
			begin
			ALUFlags[3] = ALUResult[31];
			ALUFlags[1] = cout;
			if(a[31] == b[31])
				begin
				if(a[31] == ~ALUResult[31])
					ALUFlags[0] = 1;
				else 
					ALUFlags[0] = 0;
				end
			if (ALUResult == 0)
				ALUFlags[2] = 1;
			else
				ALUFlags[2] = 0;
			end
					
	
	
		
		
		else if(ALUControl == 3'b010) //And
			begin
			ALUResult = a & b;
			if (ALUResult==0)
			begin
			ALUFlags[2] = 1;
			end
			else begin
			ALUFlags[2] = 0;
			end
			ALUFlags[1] = 0;
			ALUFlags[0] = 0;
			ALUFlags[3] = ALUResult[31]; 
			end
			
		else if(ALUControl == 3'b001) //Subtract 
			begin
			ALUFlags[3] = ALUResult[31];
			if (a >= b)
				ALUFlags[1] = 1;
			
			else if (a < b)
				ALUFlags[1] = 0;
				
			if (a[31] == ~b[31])
              begin 
                if (a[31] == ~ALUResult[31])
                   ALUFlags[0] =1;
                else
                    ALUFlags[0]=0;
                end
				
			if (ALUResult == 0)         
				ALUFlags[2] = 1;
			else
				ALUFlags[2] = 0;
			end

		else if (ALUControl == 3'b011)
		begin
		ALUResult = a|b;
		end
		
		else if(ALUControl == 3'b101) //Eor - new change
			begin
			ALUResult = a^b;
			end
		
		else if(ALUControl == 3'b110) //MOVN - new change
			begin
			ALUResult = 32'b11111111111111111111111111111111^b;
			end
		
		else
		begin
		ALUFlags[0]=1'b0;
	   ALUFlags[1]=1'b0;
		ALUFlags[2]=1'b0;
		ALUFlags[3]=1'b0;
		end
		end

	
	


    endmodule
	
	module full_adder (
	input        a,
	input        b,
	input        cin,
	output logic sum,
	output logic cout
);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule



module rc_adder (
  input cin,
	input        [31:0] a,
	input        [31:0] b,
	output logic [31:0] sum,
	output logic        cout
);

	logic [30:0] carry;


	full_adder b31(.a(a[31]), .b(b[31]), .cin(carry[30]), .sum(sum[31]), .cout(cout));
	full_adder b30(.a(a[30]), .b(b[30]), .cin(carry[29]), .sum(sum[30]), .cout(carry[30]));
	full_adder b29(.a(a[29]), .b(b[29]), .cin(carry[28]), .sum(sum[29]), .cout(carry[29]));
	full_adder b28(.a(a[28]), .b(b[28]), .cin(carry[27]), .sum(sum[28]), .cout(carry[28]));
	full_adder b27(.a(a[27]), .b(b[27]), .cin(carry[26]), .sum(sum[27]), .cout(carry[27]));
	full_adder b26(.a(a[26]), .b(b[26]), .cin(carry[25]), .sum(sum[26]), .cout(carry[26]));
	full_adder b25(.a(a[25]), .b(b[25]), .cin(carry[24]), .sum(sum[25]), .cout(carry[25]));
	full_adder b24(.a(a[24]), .b(b[24]), .cin(carry[23]), .sum(sum[24]), .cout(carry[24]));
	full_adder b23(.a(a[23]), .b(b[23]), .cin(carry[22]), .sum(sum[23]), .cout(carry[23]));
	full_adder b22(.a(a[22]), .b(b[22]), .cin(carry[21]), .sum(sum[22]), .cout(carry[22]));
	full_adder b21(.a(a[21]), .b(b[21]), .cin(carry[20]), .sum(sum[21]), .cout(carry[21]));
	full_adder b20(.a(a[20]), .b(b[20]), .cin(carry[19]), .sum(sum[20]), .cout(carry[20]));
	full_adder b19(.a(a[19]), .b(b[19]), .cin(carry[18]), .sum(sum[19]), .cout(carry[19]));
	full_adder b18(.a(a[18]), .b(b[18]), .cin(carry[17]), .sum(sum[18]), .cout(carry[18]));
	full_adder b17(.a(a[17]), .b(b[17]), .cin(carry[16]), .sum(sum[17]), .cout(carry[17]));
	full_adder b16(.a(a[16]), .b(b[16]), .cin(carry[15]), .sum(sum[16]), .cout(carry[16]));
	full_adder b15(.a(a[15]), .b(b[15]), .cin(carry[14]), .sum(sum[15]), .cout(carry[15]));
	full_adder b14(.a(a[14]), .b(b[14]), .cin(carry[13]), .sum(sum[14]), .cout(carry[14]));
	full_adder b13(.a(a[13]), .b(b[13]), .cin(carry[12]), .sum(sum[13]), .cout(carry[13]));
	full_adder b12(.a(a[12]), .b(b[12]), .cin(carry[11]), .sum(sum[12]), .cout(carry[12]));
	full_adder b11(.a(a[11]), .b(b[11]), .cin(carry[10]), .sum(sum[11]), .cout(carry[11]));
	full_adder b10(.a(a[10]), .b(b[10]), .cin(carry[9]),  .sum(sum[10]), .cout(carry[10]));
	full_adder b9(.a(a[9]), .b(b[9]), .cin(carry[8]), .sum(sum[9]), .cout(carry[9]));
	full_adder b8(.a(a[8]), .b(b[8]), .cin(carry[7]), .sum(sum[8]), .cout(carry[8]));
	full_adder b7(.a(a[7]), .b(b[7]), .cin(carry[6]), .sum(sum[7]), .cout(carry[7]));
	full_adder b6(.a(a[6]), .b(b[6]), .cin(carry[5]), .sum(sum[6]), .cout(carry[6]));
	full_adder b5(.a(a[5]), .b(b[5]), .cin(carry[4]), .sum(sum[5]), .cout(carry[5]));
	full_adder b4(.a(a[4]), .b(b[4]), .cin(carry[3]), .sum(sum[4]), .cout(carry[4]));
	full_adder b3(.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
	full_adder b2(.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder b1(.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder b0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));
	
endmodule

module my_mux #(parameter DATA_WIDTH = 32)
            (input logic ALUselect, input logic [DATA_WIDTH-1:0] B, output logic [DATA_WIDTH-1:0] sb);
always_comb
    begin
        if(ALUselect == 1)
           sb = ~B;
        else
            sb = B;
    end
endmodule




