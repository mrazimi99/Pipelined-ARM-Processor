module ConditionCheck_TB ();
  reg clock=0;

  wire result;
  reg[3: 0] condition, status;

  ConditionCheck conditionchecker(.condition(condition),
                                  .status(status),
                                  .result(result));
  always#10 clock=~clock;

  always @ ( posedge clock ) begin
    condition = condition + 1;
  end

  initial begin
    status = 4'b 1010;
    condition = 0;
    #340
    condition = 0;
    status = 4'b 0101;
    #340
    $stop;
  end
endmodule // ConditionCheck_TB
