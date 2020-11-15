module MEM2WB (input clk, rst, input[31: 0] pc_in, output reg[31: 0] pc);

  always @ (posedge clk, posedge rst) begin

    if (rst) begin
      pc <= 32'b 0;
    end
    else begin
      pc <= pc_in;
    end

  end

endmodule // MEM2WB
