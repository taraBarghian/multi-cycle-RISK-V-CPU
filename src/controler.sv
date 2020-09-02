module controler (input logic rst, clk, 
                  input logic [6:0] opcode,
                  input logic [31:0] complete_inst,
	              output logic pcWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg,
				  output logic [1:0] PCSource, ALUOp, ALUSrcB,
				  output logic ALUSrcA , RegWrite, RegDst, 
				  output logic [3:0] state);
    parameter 
    LD = 7'b000_0011,
	SD = 7'b010_0011,
    BEQ = 7'b110_0111,
	ALUop = 7'b011_0011;

    enum logic [3:0] {fetch, decode, memAdr, memRead, memWB, memWrite, execute, R_type, branch, jump} next_state = fetch;
    logic [15:0] controls;

	always_ff@(posedge clk or posedge rst)begin 
			if(rst)
				state <= fetch;
			else 
				state <= next_state;
	end

    always@(*) begin
		case(state)
		
		fetch: begin
            controls = 16'b1001010000001000; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 

			next_state = decode;
		end
		//////////////////////
		decode: begin
		    controls = 16'b0000000000011000; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 

			if(opcode == ALUop)            
				begin next_state = execute; end
			else if ((opcode == LD) || (opcode == SD)) 
				begin next_state = memAdr; end
			else if (opcode == BEQ) 
                begin next_state = branch; end	
		end
		/////////////////////
		memAdr: begin
			controls = 16'b0000000000010100; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 	
			
			if(opcode == LD)
				begin next_state = memRead; end
			else if(opcode == SD)
				begin next_state = memWrite; end
		end
		/////////////////////
		memRead: begin
            controls = 16'b0011000000000000; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 
		
			next_state = memWB;
		end
		/////////////////////
		memWB: begin
			controls = 16'b0000001000000010; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 

			next_state = fetch;
		end
		/////////////////////
		memWrite: begin
			controls = 16'b0010100000000000; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 	
			
			next_state = fetch;
		end
		/////////////////////
		execute:begin
			controls = 16'b0000000001000100; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 	
			
			next_state = R_type;
		end
		/////////////////////
		R_type: begin
			controls = 16'b0000000000000011; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 	
		
			next_state = fetch;
		end
		/////////////////////
		branch: begin
            controls = 16'b0100000010100100; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 
			
			next_state = fetch;
		end
		/////////////////////
		jump: begin
			controls = 16'b1000000100000000; 
			{pcWrite, PCWriteCond, IorD, MemRead, 
	         MemWrite, IRWrite, MemtoReg, PCSource, 
			 ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = controls; 	
		
			next_state = fetch;
		end
		/////////////////////
		endcase
	end
    
endmodule
