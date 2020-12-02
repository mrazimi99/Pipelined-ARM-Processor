module RegisterFile (input clk, rst, write_back_en, input[3: 0] src1, src2, dest_wb,
                    input[31: 0] result_wb, output[31: 0] reg1, reg2);

  reg [31:0] registers [0: 14];

  assign reg1 = registers[src1];
  assign reg2 = registers[src2];

  integer i;
  always @ (negedge clk, posedge rst) begin
    if (rst)
      for(i = 0 ; i < 15 ; i = i+1) registers[i] = i;

    if (write_back_en)
      registers[dest_wb] <= result_wb;

  end

endmodule // RegisterFile
