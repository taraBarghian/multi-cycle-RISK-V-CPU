module control(rst,clk,opcode,complete_inst,
	pcWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,
	MemtoReg,PCSource,ALUOp,ALUSrcB,ALUSrcA,RegWrite,RegDst,
	state
	);


	
	input logic clk,rst;
	input logic [6:0] opcode;
	input logic [31:0] complete_inst;

	output logic pcWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,
					 MemtoReg,ALUSrcA,RegWrite,RegDst,
					 state;
	
	output logic [1:0] PCSource,ALUOp,ALUSrcB;

	enum{fetch,decode,memAdr,memRead,memWB,memWrite,execute,R_type,branch,jump} next_state=fetch;


	always_ff@(posedge clk or negedge rst)begin 
			if(rst)begin
				state <= fetch;
			end else begin
				state <= next_state;
			end
	end

	
	
	always_comb begin
		case(state)
		
		fetch: begin
		
			pcWrite =1;
			PCWriteCond =0;	
			IorD =0;
			MemRead=1;	
			MemWrite =0;	
			IRWrite	=1;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =01;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =0;

		
		
		end
		//////////////////////
		decode: begin
		
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =11;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =0;
			
		end
		/////////////////////
		memAdr: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =10;	
			ALUSrcA	=1;
			RegWrite	=0;
			RegDst =0;
		end
		/////////////////////
		memRead: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =1;
			MemRead=1;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =0;
		end
		/////////////////////
		memWB: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=1;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=1;
			RegDst =0;
		end
		/////////////////////
		memWrite: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =1;
			MemRead=0;
			MemWrite =1;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =0;
		end
		/////////////////////
		execute:begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=10;
			ALUSrcB =00;	
			ALUSrcA	=1;
			RegWrite	=0;
			RegDst =0;
		end
		
		/////////////////////
		R_type: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=1;
			RegDst =1;
		end
		/////////////////////
		
		
		branch: begin
		
			pcWrite =0;
			PCWriteCond =1;
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=01;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =1;
		end
		/////////////////////
		
		jump: begin
				
			pcWrite =0;
			PCWriteCond =0;	
			IorD =0;
			MemRead=0;
			MemWrite =0;	
			IRWrite =0;
			MemtoReg	=0;
			PCSource	=00;
			ALUOp	=00;
			ALUSrcB =00;	
			ALUSrcA	=0;
			RegWrite	=0;
			RegDst =0;
		end
		/////////////////////
		
		endcase
	end



endmodule