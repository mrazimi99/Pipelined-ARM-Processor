module EXE2MEM (input clk, rst, wb_en_in, mem_read_in, mem_write_in,
                input[3: 0] dest_in, input[31: 0] result_in, reg2_in,
                output reg wb_en_out, mem_read_out, mem_write_out,
                output reg[3: 0] dest_out, output reg[31: 0] result_out, reg2_out);

  always @ (posedge clk, posedge rst) begin

    if (rst) begin
      wb_en_out <= 0;
      mem_read_out <= 0;
      mem_write_out <= 0;
      dest_out <= 0;
      result_out <= 0;
      reg2_out <= 0;
    end
    else begin
      wb_en_out <= wb_en_in;
      mem_read_out <= mem_read_in;
      mem_write_out <= mem_write_in;
      dest_out <= dest_in;
      result_out <= result_in;
      reg2_out <= reg2_in;
    end

  end

endmodule // EXE2MEM
