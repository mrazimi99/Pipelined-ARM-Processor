module PipeLineCpu(input clk ,rst);

  wire [31: 0] instruction, pc_out_if;

  IFSTAGE ifStage(.clk(clk) ,.rst(rst) ,.freeze(0) ,
                  .branch_track(0) ,.branch_addr(0) ,.instruction(instruction),
                  .pc(pc_out_if));

  wire[31: 0] pc_in_id, pc_out_id;
  IF2ID if2id(.clk(clk), .rst(rst), .freeze(0), .flush(0), .pc_in(pc_out_if),
              .instruction_in(instruction), .pc(pc_in_id), .instruction(instruction_out));

  IDSTAGE idSTAGE(.clk(clk) ,.rst(rst) ,.pc_in(pc_in_id) ,.pc(pc_out_id));

  wire[31: 0] pc_in_exe, pc_out_exe;
  ID2EXE id2exe(.clk(clk), .rst(rst), .pc_in(pc_out_id), .pc(pc_in_exe));

  EXEstage exeSTAGE(.clk(clk), .rst(rst), .pc_in(pc_in_exe), .pc(pc_out_exe));

  wire[31: 0] pc_in_mem, pc_out_mem;
  EXE2MEM exe2mem(.clk(clk), .rst(rst), .pc_in(pc_out_exe), .pc(pc_in_mem));

  MEMstage memSTAGE(.clk(clk) , .rst(rst), .pc_in(pc_in_mem), .pc(pc_out_mem));

  wire[31: 0] pc_in_wb, pc_out_wb;
  MEM2WB mem2wb(.clk(clk), .rst(rst), .pc_in(pc_out_mem), .pc(pc_in_wb));

  WBstage wbSTAGE(.clk(clk), .rst(rst), .pc_in(pc_in_wb), .pc(pc_out_wb));

endmodule
