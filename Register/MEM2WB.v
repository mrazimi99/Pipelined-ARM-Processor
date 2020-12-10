module MEM2WB (input clk, rst, wb_en_in, mem_read_in, input[3: 0] dest_in,
               input[31: 0] alu_result_in, mem_data_in, output reg wb_en_out,
               mem_read_out, output reg[3: 0] dest_out, output reg[31: 0] mem_data_out,
               alu_result_out);

  always @ (posedge clk, posedge rst) begin

    if (rst) begin
      wb_en_out <= 0;
      mem_read_out <= 0;
      dest_out <= 0;
      mem_data_out <= 0;
      alu_result_out <= 0;
    end
    else begin
      wb_en_out <= wb_en_in;
      mem_read_out <= mem_read_in;
      dest_out <= dest_in;
      mem_data_out <= mem_data_in;
      alu_result_out <= alu_result_in;
    end

  end

endmodule // MEM2WB
