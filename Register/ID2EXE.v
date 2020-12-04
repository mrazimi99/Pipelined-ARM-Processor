module ID2EXE (input clk, rst, flush, status_en_in, mem_read_in, mem_write_in,
               wb_en_in, branch_in, I_in, input[31: 0] pc_in, reg1_in, reg2_in,
               input[3: 0] aluCommand_in, dest_in, status_in, input[23: 0] b_signed_imm_in,
               input[11: 0] shifter_operand_in, output reg status_en_out, mem_read_out,
               mem_write_out, wb_en_out, branch_out, I_out, output reg[31: 0] pc_out,
               reg1_out, reg2_out, output reg[3: 0] aluCommand_out, dest_out, status_out,
               output reg[23: 0] b_signed_imm_out, output reg[11: 0] shifter_operand_out);

  always @ (posedge clk, posedge rst) begin

    if (rst | flush) begin
      pc_out <= 32'b 0;
      status_en_out <= 0;
      mem_read_out <= 0;
      mem_write_out <= 0;
      wb_en_out <= 0;
      branch_out <= 0;
      I_out <= 0;
      reg1_out <= 32'b 0;
      reg2_out <= 32'b 0;
      aluCommand_out <= 4'b 0;
      dest_out <= 4'b 0;
      status_out <= 4'b 0;
      b_signed_imm_out <= 24'b 0;
      shifter_operand_out <= 12'b 0;
    end
    else begin
      pc_out <= pc_in;
      status_en_out <= status_en_in;
      mem_read_out <= mem_read_in;
      mem_write_out <= mem_write_in;
      wb_en_out <= wb_en_in;
      branch_out <= branch_in;
      I_out <= I_in;
      reg1_out <= reg1_in;
      reg2_out <= reg2_in;
      aluCommand_out <= aluCommand_in;
      dest_out <= dest_in;
      status_out <= status_in;
      b_signed_imm_out <= b_signed_imm_in;
      shifter_operand_out <= shifter_operand_in;
    end

  end

endmodule // ID2EXE
