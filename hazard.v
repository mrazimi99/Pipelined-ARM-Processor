module HazardUnit(input with_forwarding, input have_two_src, ignore_hazard, 
    input ignore_from_forwarding, input EXE_mem_read_en, input [3:0] src_address1, src_address2, input [3:0] exe_wb_dest, mem_wb_dest,
    input exe_wb_en, mem_wb_en,  output hazard_detected);
    
    wire internal_hazard_with_forwarding;
    wire hazard_without_forwarding;

    assign hazard_with_forwarding = ((src_address1 == exe_wb_dest) && (exe_wb_en == 1'b1)) ? 1'b1
            : ((src_address2 == exe_wb_dest) && (exe_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
            : 1'b0;

    assign hazard_without_forwarding = ((src_address1 == exe_wb_dest) && (exe_wb_en == 1'b1)) ? 1'b1
            : ((src_address1 == mem_wb_dest) && (mem_wb_en == 1'b1)) ? 1'b1
            : ((src_address2 == exe_wb_dest) && (exe_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
            : ((src_address2 == mem_wb_dest) && (mem_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
            : 1'b0;
    
    assign hazard_detected = (ignore_hazard == 1'b1) ? 1'b0
        : (with_forwarding == 1'b1) ? hazard_with_forwarding & EXE_mem_read_en
        : hazard_without_forwarding;
endmodule