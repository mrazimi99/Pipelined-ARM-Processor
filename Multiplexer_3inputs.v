module Multiplexer_3inputs #(parameter N)(a ,b ,c ,mode ,out);
      input [N-1 : 0] a ,b ,c;
      input [1 :0] mode;
      output [N-1 :0] out;

      assign out = (mode == 2'b 00)  ? a :
                   (mode == 2'b 01)  ? b : c;

endmodule // Multiplexer
// MOV, MVN, ADDS, SUB, AND, EOR, ORR, SBC, ADC, CMP, TST, STR, LDR, BLT
