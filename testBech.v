module TestBench ();
  reg clk, rst;
  PipeLineCpu cpu(clk, rst);
  always #5 clk=~clk;
  always begin
    rst = 1; clk=1;#20
    rst= 0; #120
    $stop;
  end
endmodule // TestBench
