module EXEstage (input I, mem_read, mem_write, input[3: 0] aluCommand, status_in,
                 input[31: 0] pc_in, reg1, reg2, input[11: 0] shifter_operand,
                 input[23: 0] b_signed_imm, output[31: 0] branch_address, result,
                reg2_out, output [3: 0] status_out);

  assign pc = pc_in;
  wire[31: 0] val2, b_address;

  Val2Generator val2Generator(.I(I), .mem_en(mem_read|mem_write), .shifter(shifter_operand),
                              .register(reg2), .result(val2));


  ALU alu(.command(aluCommand), .status_in(status_in), .operand1(reg1),
          .operand2(val2), .status(status_out), .result(result));


  assign branch_address = pc_in + b_address; // Adder in the map!!

endmodule // EXEstage
