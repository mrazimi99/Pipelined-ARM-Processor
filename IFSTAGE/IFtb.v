module IFtb ();

  reg clk, rst;
  wire[31 :0] instruction, pc;

  IFSTAGE ifStage(.clk(clk) ,.rst(rst) ,.freeze(0) ,.branch_track(0) ,
                  .branch_addr(32'b 0),.instruction(instruction), .pc(pc));

  always #5 clk=~clk;
  initial begin
    rst=1;clk=1;#20
    rst=0; #220
    $stop;
  end

endmodule // IFtb
