module Val2Generator (input I, mem_en, input[11: 0] shifter, input[31: 0] register,
                      output[31 :0] result);

  reg [31: 0] im_result, not_im_result;
  wire[31: 0] offset;
  SignExtend#(.N(12)) signExtend(shifter, offset);

  assign result = mem_en ? offset :
                       I ? im_result : not_im_result;

  integer i, rounds;
  always @ (shifter) begin
    im_result = {24'b 0, shifter[7: 0]};
    rounds = shifter[11: 8];
    for( i=0 ; i < rounds; i=i+1)
      im_result = {im_result[1: 0], im_result[31: 2]};
  end

  integer rot_round, j;
  always @ ( shifter, register ) begin
    rot_round = shifter[11: 7];
    not_im_result = register;
    case (shifter[6: 5])
      2'b 00: not_im_result = not_im_result << rot_round; // Logical shift left
      2'b 01: not_im_result = not_im_result >> rot_round; // Logical shift right
      2'b 10: begin // Arithmetic shift right
                not_im_result = not_im_result >> rot_round;

                for(j=0 ; j < rot_round; j=j+1)
                  not_im_result[31-j] = not_im_result[31 - rot_round];
              end
      2'b 11: begin
                for( j=0 ; j < rot_round; j=j+1)
                  not_im_result = {not_im_result[0], not_im_result[31: 1]};
              end
      default: ;
    endcase

  end


endmodule // ShifterOperand
