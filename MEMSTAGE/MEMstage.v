module MEMstage (input clk, rst, write_en, read_en, input[31: 0] input_data,
                 address, output[31: 0] data);

  reg [31:0] registers [0: 64*1024]; //2^16 = 64KB

  assign data = read_en ? registers[address] : 0;

  integer i;
  always @ (posedge clk, posedge rst) begin
    if (rst)
      for(i = 0 ; i < 64*1024 ; i = i+1) registers[i] = i;
    if (write_en)
      registers[address] <= input_data;
  end

endmodule // MEMstage
