module TestBench ();
  reg clk, rst;
  ARM_CPU cpu(clk, rst);
  always #5 clk=~clk;
  always begin
    rst = 1; clk=1;#20
    rst= 0; #5200
    $stop;
  end
endmodule // TestBench
