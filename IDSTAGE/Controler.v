module ControlUnit (input[1: 0] mode, input[3: 0] op_code, input s,
                    output reg[3: 0] aluCommand, output reg mem_read, mem_write,
                    wb_en, branch, status_en);

always @ ( mode, op_code, s ) begin
  {aluCommand, mem_read, mem_write, wb_en, branch, status_en} = 0;
  if (mode == 2'b 10) //B : Branch
    branch = 1'b 1;
  else if (mode == 2'b 01)
    case (s)
        1'b 1:begin status_en = s; // LDR : Load Register
                    mem_read = 1'b 1;
                    wb_en = 1;
              end
        1'b 0:begin status_en = s; // STR : Store Register
                    mem_write = 1'b 1;
              end
    endcase
  else
    case (op_code)
      4'b 0000: {aluCommand, mem_read, mem_write, wb_en, branch, status_en} = 0;

      4'b 1101: begin status_en = s;  // MOV : Move
                      aluCommand = 4'b 1010;
                      wb_en = 1;
                end

      4'b 1111: begin status_en = s; // MVN : BitWise Not and Move
                      aluCommand = 4'b 1011;
                      wb_en = 1;
                end

      4'b 0100: begin status_en = s;  // ADD : Add
                     aluCommand = 4'b 0001;
                     wb_en = 1;
               end

      4'b 0101:begin status_en = s;  // ADC : Add with Carry
                     aluCommand = 4'b 0010;
                     wb_en = 1'b 1;
               end

      4'b 0010:begin status_en = s; // SUB : Subtraction
                     aluCommand = 4'b 0011;
                     wb_en = 1'b 1;
              end

      4'b 0110:begin status_en = s; // SBC : Subtraction with Carry
                     aluCommand = 4'b 0100;
                     wb_en = 1'b 1;
              end

      4'b 0000:begin status_en = s; // AND : And
                     aluCommand = 4'b 0101;
                     wb_en = 1'b 1;
              end

      4'b 1100:begin status_en = s; // ORR : Or
                     aluCommand = 4'b 0111;
                     wb_en = 1'b 1;
              end

      4'b 0001:begin status_en = s; // EOR : Exlusive OR
                     aluCommand = 4'b 1000;
                     wb_en = 1'b 1;
              end

      4'b 1010:begin status_en = 1'b 1; // CMP : Compare
                     aluCommand = 4'b 1001;
                     wb_en = 1'b 1;
              end
      4'b 1000: begin status_en = 1;// TST : TEST
                      aluCommand = 4'b 1100;
                end

      default: {aluCommand, mem_read, mem_write, wb_en, branch, status_en} = 0;
    endcase

end
endmodule // ControlUnit
