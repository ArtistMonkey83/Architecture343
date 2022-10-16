module clkdiv(input logic clk, clr, output logic clk3);

logic [24:0] q;

always_ff @(posedge clk)
  begin
    if(clr)
      q<=0;
    else
      q<=q+1;
  end

  assign clk3 = q[23];
endmodule
