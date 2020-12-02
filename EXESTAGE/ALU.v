module ALU (input[3: 0] command, status_in, input[31: 0] operand1, operand2,
            output[3: 0] status, output reg[31: 0] result);

  reg c_flag, v_flag;

  wire z_flag, n_flag;
  assign z_flag = ~|result;
  assign n_flag = result[31];

  assign status = {n_flag, z_flag, c_flag, v_flag};

  always @ ( command, operand1, operand2 ) begin
    case (command)
      // TODO: calculate the c , v flags

      4'b 0001: result = operand2 ; // MOV : Move

      4'b 1001: result = ~operand2; // MVN : BitWise Not and Move

      4'b 0010: {c_flag, result} = operand1 + operand2 ; // ADD

      4'b 0011: {c_flag, result} = operand1 + operand2 + status_in[1] ; // ADC : Add with Carry

      4'b 0100: result = operand1 - operand2;     // SUB : Subtraction

      4'b 0101: result = operand1 - operand2 - 1; // SBC : Subtraction with Carry

      4'b 0110: result = operand1 & operand2;     // AND : And

      4'b 0111: result = operand1 | operand2;     // ORR : Or

      4'b 1000: result = operand1 ^ operand2;     // EOR : Exlusive OR

      default: ;
    endcase
  end

endmodule // ALU
