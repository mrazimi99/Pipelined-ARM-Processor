module SignExtend #(parameter N)( in, out);
  input [N-1 :0] in;
  output [31:0] out;
  // assign out = (in[N-1] == 1) ? {1'b 1 >>> 31-N, in} : {1'b 0  >>> 31-N , in};
  assign out = in >>> (32 - N);
endmodule // signExtend
