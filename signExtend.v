module SignExtend (input [12:0] in,output [31:0] out);
  assign out = (in[11] == 1) ? {24'b1111111111111111, in} : {24'b0000000000000000, in};
endmodule // signExtend
