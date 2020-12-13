module HazardDetectionUnit(input [3:0] src1, src2, Exe_Dest, Mem_Dest,
		input Exe_WB_EN, Mem_WB_EN, two_src, output hazard_detected);

	assign hazard_detected = (Exe_WB_EN == 1'b1) && (src1 == Exe_Dest || (two_src == 1'b1 && src2 == Exe_Dest)) ? 1'b1
			: (Mem_WB_EN == 1'b1) && (src1 == Mem_Dest || (two_src == 1'b1 && src2 == Mem_Dest)) ? 1'b1
			: 1'b0;
endmodule