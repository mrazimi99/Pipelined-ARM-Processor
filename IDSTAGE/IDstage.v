module IDSTAGE (input clk, rst, write_back_en, hazard, input[31: 0] pc_in, instruction,
                reg_data_wb, input[3 :0] dest_wb, status, output[31: 0] pc, reg1, reg2,
                output[3: 0] aluCommand, dest, src1, src2, output status_en, mem_read, mem_write,
                wb_en, branch, I, two_src, output[23: 0] b_signed_imm, output[11: 0] shifter_operand);

  assign pc = pc_in;

  assign two_src = ~I | mem_write;
  assign src1 = instruction[19: 16];
  assign src2 = reg_src2;

  // Immidate
  assign I = instruction[25];
  assign b_signed_imm = instruction[23: 0];
  assign shifter_operand = instruction[11 :0];


  wire is_ok, cond_result;
  assign is_ok = (~cond_result | hazard) & (|instruction);

  wire c_mem_read, c_mem_write, c_branch, c_wb_en, c_status_en;
  wire[3: 0] c_aluCommand;

  //MUX
  assign wb_en      = is_ok ? 0: c_wb_en;
  assign mem_read   = is_ok ? 0: c_mem_read;
  assign mem_write  = is_ok ? 0: c_mem_write;
  assign branch     = is_ok ? 0: c_branch;
  assign status_en  = is_ok ? 0: c_status_en;
  assign aluCommand = is_ok ? 0: c_aluCommand;

  assign dest = instruction[15: 12];


  ConditionCheck conditionchecker(.condition(instruction[31: 28]),
                                  .status(status),
                                  .out_result(cond_result));

  ControlUnit controler(.mode(instruction[27 :26]), .op_code(instruction[24: 21]), .s(instruction[20]),
                        .alu_command(c_aluCommand), .mem_read(c_mem_read),
                        .mem_write(c_mem_write), .wb_en(c_wb_en), .branch(c_branch),
                        .status_en(c_status_en));


  wire[3: 0] reg_src2;
  assign reg_src2 = c_mem_write? instruction[15: 12]: instruction[3: 0];  // c_mem_write? Rd(STR): Rm;
  RegisterFile registerfile(.clk(clk), .rst(rst), .write_back_en(write_back_en),
                            .src1(instruction[19: 16]), .src2(reg_src2), .dest_wb(dest_wb),
                            .result_wb(reg_data_wb), .reg1(reg1), .reg2(reg2));

endmodule // IDSTAGE
