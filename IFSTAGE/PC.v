module PC (input clk ,rst ,writeEn ,input [31 :0] nextPC ,output reg[31 :0] pc);

  always @ (posedge clk ,posedge rst) begin
    if (rst) pc <= 32'b 0;
    else if(writeEn) pc <= nextPC;
  end

endmodule // PC
