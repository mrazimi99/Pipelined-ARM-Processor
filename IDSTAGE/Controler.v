module ControlUnit (input[1: 0] mode, input[3: 0] op_code, input s,
                    output [3: 0] alu_command, output mem_read, mem_write,
                    wb_en, branch, status_en);
  reg [3: 0] alu_mode;
  assign alu_command = alu_mode;

  reg inner_mem_read, inner_mem_write, inner_wb_en, inner_branch, inner_status_en;

  assign mem_read = inner_mem_read;
  assign mem_write = inner_mem_write;
  assign wb_en = inner_wb_en;
  assign branch = inner_branch;
  assign status_en = inner_status_en;

  always @ ( mode, op_code, s ) begin
    {alu_mode, inner_mem_read, inner_mem_write, inner_wb_en, inner_branch, inner_status_en} <= 9'b 0;
    if (mode == 2'b 10) //B : Branch
      inner_branch <= 1'b 1;
    else if (mode == 2'b 01) begin
      case (s)
          1'b 1:begin inner_status_en <= s; // LDR : Load Register
                      inner_mem_read <= 1'b 1;
                      alu_mode <= 4'b 0010;
                      inner_wb_en <= 1;
                end
          1'b 0:begin inner_status_en <= s; // STR : Store Register
                      inner_mem_write <= 1'b 1;
                      alu_mode <= 4'b 0010;
                end
      endcase
    end
    else begin
      case (op_code)
      4'b 0000: {alu_mode, inner_mem_read, inner_mem_write, inner_wb_en, inner_branch, inner_status_en} <= 9'b 0;

        4'b 1101: begin inner_status_en <= s;  // MOV : Move
                        alu_mode <= 4'b 0001;
                        inner_wb_en <= 1;
                  end

        4'b 1111: begin inner_status_en <= s; // MVN : BitWise Not and Move
                        alu_mode <= 4'b 1001;
                        inner_wb_en <= 1;
                  end

        4'b 0100: begin inner_status_en <= s;  // ADD : Add
                       alu_mode <= 4'b 0010;
                       inner_wb_en <= 1;
                 end

        4'b 0101:begin inner_status_en <= s;  // ADC : Add with Carry
                       alu_mode <= 4'b 0011;
                       inner_wb_en <= 1'b 1;
                 end

        4'b 0010:begin inner_status_en <= s;
                       alu_mode <= 4'b 0100;
                       inner_wb_en <= 1'b 1;
                end// SUB : Subtraction

        4'b 0110:begin inner_status_en <= s; // SBC : Subtraction with Carry
                       alu_mode <= 4'b 0101;
                       inner_wb_en <= 1'b 1;
                end

        4'b 0000:begin inner_status_en <= s; // AND : And
                       alu_mode <= 4'b 0110;
                       inner_wb_en <= 1'b 1;
                end

        4'b 1100:begin inner_status_en <= s; // ORR : Or
                       alu_mode <= 4'b 0111;
                       inner_wb_en <= 1'b 1;
                end

        4'b 0001:begin inner_status_en <= s; // EOR : Exlusive OR
                       alu_mode <= 4'b 1000;
                       inner_wb_en <= 1'b 1;
                end

        4'b 1010:begin inner_status_en <= 1'b 1; // CMP : Compare
                       alu_mode <= 4'b 0100;
                       inner_wb_en <= 1'b 1;
                end
        4'b 1000: begin inner_status_en <= 1; // TST : TEST
                        alu_mode <= 4'b 0110;
                  end

        default: {alu_mode, inner_mem_read, inner_mem_write, inner_wb_en, inner_branch, inner_status_en} <= 9'b 0;
      endcase
    end
  end
endmodule // ControlUnit
