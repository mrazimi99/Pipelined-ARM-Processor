module WBstage (input mem_read, input[31: 0] alu_result, mem_data,
                output[31: 0] result);

assign result = mem_read ? mem_data : alu_result;

endmodule // WBstage
