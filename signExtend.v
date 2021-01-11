module SignExtend #(parameter N)( in, out);
  input [N-1 :0] in;
  output [31:0] out;
  assign out = {{(31 - N){in[N-1]}}, in};
endmodule // signExtend
