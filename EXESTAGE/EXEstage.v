module EXEstage (input I, mem_read, mem_write, input[3: 0] aluCommand, status_in,
                 input[31: 0] pc_in, reg1, reg2, forwarding_result, forwarding_wb,
                 input [1:0] sel_src1, sel_src2, input[11: 0] shifter_operand,
                 input[23: 0] b_signed_imm, output[31: 0] branch_address, result,
                 output [3: 0] status_out);

  assign pc = pc_in;
  wire[31: 0] val2, b_address, mux_to_alu, mux_to_val_rm;

  Multiplexer_3inputs#(.N(32)) mult1(reg1, forwarding_result, forwarding_wb, sel_src1, mux_to_alu);
	Multiplexer_3inputs#(.N(32)) mult2(reg2, forwarding_result, forwarding_wb, sel_src2, mux_to_val_rm);

  Val2Generator val2Generator(.I(I), .mem_en(mem_read|mem_write), .shifter(shifter_operand),
                              .register(mux_to_val_rm), .result(val2));


  ALU alu(.command(aluCommand), .status_in(status_in), .operand1(mux_to_alu),
          .operand2(val2), .status(status_out), .result(result));

  SignExtend#(.N(24)) signExtend(.in(b_signed_imm), .out(b_address));

  assign branch_address = pc_in + (b_address << 2) + 4; // Adder in the map!!

endmodule // EXEstage
