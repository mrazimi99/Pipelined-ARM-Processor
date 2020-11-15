module IFSTAGE (input clk ,rst ,freeze ,branch_track ,input[31:0] branch_addr,
                output[31 :0] instruction, pc );
  wire[31 :0] nextPc ,npc;

  Adder adder(4 ,pc ,nextPc);

  Multiplexer_2inputs#(.N(32)) mux (branch_addr ,nextPc ,branch_track ,npc);

  PC Pc(clk ,rst ,~freeze ,npc ,pc);

  InstrcutionSet instructionSet(pc ,instruction);
endmodule // IFSTAGE
