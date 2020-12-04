module StatusRegister (input clk, rst, enable, input[3: 0] status_in,
                       output reg[3: 0]status_out);

  always @ (posedge clk, posedge rst) begin
    if (rst)
      status_out <= 4'b 0;
    else if (enable)
      status_out <= status_in;
  end

endmodule // StatusRegister
