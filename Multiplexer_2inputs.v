module Multiplexer_2inputs #(parameter N)(a ,b ,mode ,out);
      input [N-1 : 0] a ,b;
      input mode;
      output [N-1 :0] out;

      assign out = mode ? a : b;

endmodule // Multiplexer
