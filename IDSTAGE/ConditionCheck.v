module ConditionCheck (input[3: 0] condition, status, output reg result);

  wire n_flag;
  assign n_flag = status[3];
  wire z_flag;
  assign z_flag = status[2];
  wire c_flag;
  assign c_flag = status[1];
  wire v_flag;
  assign v_flag = status[0];
  // reg result;
  // assign out_result = result;

  always @ ( condition, status ) begin
  case (condition)
    4'b 0000: result = z_flag ;   // EQ : Equal

    4'b 0001: result = ~z_flag ;  // NE : Not Equal

    4'b 0010: result = c_flag ;   // CS/HS : Carry Set/ Unsigned higher or same

    4'b 0011: result = ~c_flag ;  // CC/LO : Carry clear/ Unsigned lower

    4'b 0100: result = n_flag ;   // MI : Minus/negetive

    4'b 0101: result = ~n_flag ;  // PL: Plus/Posotive or Zero

    4'b 0110: result = v_flag ;   // VS : Overflow

    4'b 0111: result = ~v_flag ;  // VC : no Overflow

    4'b 1000: result = (c_flag & ~z_flag) ;   // HI : Unsigned higher

    4'b 1001: result = (~c_flag & z_flag) ;   // LS : Unsigned Lower or Same

    4'b 1010: result = (n_flag == v_flag) ;   // GE : Signed Grater than or Equal

    4'b 1011: result = (n_flag != v_flag) ;   // LT : Signed Less than

    4'b 1100: result = (~z_flag & (n_flag == v_flag)) ;   // GT : Signed Greater than

    4'b 1101: result = (z_flag & (n_flag != v_flag)) ;   // LE : Signed Less than or Equal

    4'b 1110 , 4'b 1111: result = v_flag ;   // VS : Overflow

    default: result = 1'b 0;
  endcase
  end

endmodule // ConditionCheck
