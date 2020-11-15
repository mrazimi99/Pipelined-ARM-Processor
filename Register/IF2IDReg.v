module IF2ID (input clk, rst, flush, freeze, input[31: 0] pc_in, instruction_in,
              output reg [31: 0] pc, instruction);

  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 0;
      instruction <= 0;
    end
    else begin
      if (~freeze) begin
        if (flush) begin
          instruction <= 0;
          pc <= 0;
        end
        else begin
          instruction <= instruction_in;
          pc <= pc_in;
        end
      end
    end
  end

endmodule // IF2ID
