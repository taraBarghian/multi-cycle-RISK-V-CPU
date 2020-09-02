module controllertest();

	logic clk,rst;
	logic [6:0] opcode;
	logic [31:0] complete_inst;
	
	
	logic pcWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,
					 MemtoReg,ALUSrcA,RegWrite,RegDst;
	logic [3:0]	state;
	
	logic [1:0] PCSource,ALUOp,ALUSrcB;
	
	parameter 
   LD = 7'b000_0011,
	SD = 7'b010_0011,
   BEQ = 7'b110_0111,
	ALUop = 7'b011_0011;
	
	
	controler ctrl(rst,clk,opcode,complete_inst,
				pcWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,
				MemtoReg,PCSource,ALUOp,ALUSrcB,ALUSrcA,RegWrite,RegDst,
				state);
	
	

	// initialize test
	initial
		begin
		rst <= 0;
		opcode <= ALUop; #40;
		opcode<=LD; #50;
		opcode<=SD; #40;
		opcode<=BEQ; #30;
		
	end
		// generate clock to sequence tests
	always
		begin
			clk <= 1; #5; clk <= 0; #5;
		end
		
		
	
	
	
	


endmodule