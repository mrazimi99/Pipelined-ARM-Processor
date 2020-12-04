module ALU (input[3: 0] command, status_in, input signed[31: 0] operand1, operand2,
            output[3: 0] status, output reg[31: 0] result);

  reg c_flag, v_flag;

  wire z_flag, n_flag;
  assign z_flag = ~|result;
  assign n_flag = result[31];

  assign status = {n_flag, z_flag, c_flag, v_flag};

  always @ ( command, operand1, operand2 ) begin
    {result, c_flag, v_flag} = 0;
    case (command)

      4'b 0001: result = operand2 ; // MOV : Move

      4'b 1001: result = ~operand2; // MVN : BitWise Not and Move

      4'b 0010: begin   // ADD
                  {c_flag, result} = operand1 + operand2 ;
                  v_flag = (~(operand1[31] ^ operand2[31]) & ~(operand1[31] ^ result[31])) ?
                                1'b 1 : 1'b 0;
                end

      4'b 0011: begin   // ADC : Add with Carry
                  {c_flag, result} = operand1 + operand2 + status_in[1] ;
                  v_flag = (~(operand1[31] ^ operand2[31]) & ~(operand1[31] ^ result[31])) ?
                    1'b 1 : 1'b 0;
                  end

      4'b 0100: begin   // SUB : Subtraction
                  result = operand1 - operand2;
                  v_flag = ((operand1[31] ^ operand2[31]) & ~(operand2[31] ^ result[31])) ?
                    1'b 1 : 1'b 0;
                end

      4'b 0101: begin   // SBC : Subtraction with Carry
                  result = operand1 - operand2 - 1;
                  v_flag = ((operand1[31] ^ operand2[31]) & ~(operand2[31] ^ result[31])) ?
                    1'b 1 : 1'b 0;
                end

      4'b 0110: result = operand1 & operand2;     // AND : And

      4'b 0111: result = operand1 | operand2;     // ORR : Or

      4'b 1000: result = operand1 ^ operand2;     // EOR : Exlusive OR

      default: ;
    endcase
  end

endmodule // ALU
