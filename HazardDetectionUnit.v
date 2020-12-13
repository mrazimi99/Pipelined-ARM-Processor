module HazardDetectionUnit(input [4:0] src1, src2, Exe_Dest, Mem_Dest,
		input Exe_WB_EN, Mem_WB_EN, double_source, output hazard_detected)

	assign hazard_detected = Exe_WB_EN == 1'b1 ? (src1 == Exe_Dest || (double_source == 1'b1 && src2 == Exe_Dest == 1'b1))
			: Mem_WB_EN == 1'b1 ? (src1 == Mem_Dest || (double_source == 1'b1 && src2 == Mem_Dest))
			: 0;
endmodule