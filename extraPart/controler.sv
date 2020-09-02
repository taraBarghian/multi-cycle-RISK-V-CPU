module controler (input logic rst, clk, 
                  input logic [6:0] opcode,
                  input logic [31:0] complete_inst,
	              output logic pcWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg,
				  output logic [1:0] PCSource, ALUOp, ALUSrcB,
				  output logic ALUSrcA , RegWrite, RegDst, 
				  output logic [3:0] state);

	logic [17:0] microinstruction; 			  
    logic [3:0] Mc, As, plus1;
	logic [1:0] AdrCtl; 

	microcodememory microcodememory(Mc, microinstruction);
	assign {pcWrite, PCWriteCond, IorD, MemRead, 
	        MemWrite, IRWrite, MemtoReg, PCSource, 
			ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, AdrCtl} = microinstruction; 
	microprogramcounter microprogramcounter(rst, clk, As, Mc);
	adder adder(4'b1, Mc, plus1);
	addressselect addressselect(AdrCtl, opcode, plus1, As);
    assign state = Mc;

endmodule