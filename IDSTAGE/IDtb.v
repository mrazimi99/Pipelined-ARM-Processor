module IDtb ();
  reg clk, rst, en;
  wire[31: 0] reg1, reg2;

  RegisterFile registerFile(.clk(clk), .rst(rst), .write_back_en(en), .src1(1),
                            .src2(4), .dest_wb(5), .result_wb(32), .reg1(reg1),
                            .reg2(reg2));

  always #5 clk=~clk;
  initial begin
    rst=1;clk=1; en=0; #20
    rst=0; #40
    en=1;#40
    $stop;
  end

endmodule // IDtb
