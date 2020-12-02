module IDtb ();
  reg clk, rst;

  wire[31: 0] reg1, reg2, pc_if_out, pc_id_in, pc_id_out, instruction;
  wire[23: 0] b_signed_imm;
  wire[11: 0] shifter_operand;
  wire[3: 0] aluCommand, dest;
  wire status_en, mem_read, mem_write, wb_en, branch, I;

  IFSTAGE ifStage(.clk(clk), .rst(rst), .freeze(0), .branch_track(0),
                  .branch_addr(32'b 0), .instruction(instruction), .pc(pc_if_out));

  IDSTAGE idStage(.clk(clk), .rst(rst), .write_back_en(0), .hazard(0), .pc_in(pc_id_in),
                  .instruction(instruction), .reg_data_wb(32'b 0), .dest_wb(4'b 0),
                  .pc(pc_id_out), .reg1(reg1), .reg2(reg2), .aluCommand(aluCommand),
                  .dest(dest), .status_en(status_en), .mem_read(mem_read),
                  .mem_write(mem_write), .wb_en(wb_en), .branch(branch), .I(I),
                  .b_signed_imm(b_signed_imm), .shifter_operand(shifter_operand));

  always #5 clk=~clk;
  initial begin
    rst=1;clk=1; #20
    rst=0; #220
    $stop;
  end

endmodule // IDtb
