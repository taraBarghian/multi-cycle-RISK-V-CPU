module datapath (input logic clk, rst);

    //controler output
    
    logic [6:0] opcode;
    logic [31:0] complete_inst;
	logic pcWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg;
	logic [1:0] PCSource, ALUOp, ALUSrcB;
	logic ALUSrcA , RegWrite, RegDst; 

    logic [63:0] aluresult, aluout, address, PC, PCnext, writedata, readdata, data, WDregisterf;
    logic [63:0] read1, read2, immediate, A, B, SrcA, SrcB;
    logic [31:0] Instr;
    logic [4:0] WAregisterf;
    logic [3:0] alufalgs;
    logic [1:0] ALUcontrole;
    logic PCen;
    //pc
    controler controler(rst, clk, Instr[6:0], Instr, pcWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA , RegWrite, RegDst,);
    assign PCen = (alufalgs[2] & PCWriteCond) | pcWrite; 
    flopenr #(64) pcreg(clk, rst, PCen, PCnext, PC);
    mux2 #(64) muxaddress(PC, aluout, IorD, address);
    mem memory(clk, MemRead, MemWrite, address, writedata, readdata);
    flopenr #(32) Instrreg(clk, rst, IRWrite, readdata[31:0], Instr);
    flopr #(64) Memdatareg(clk, rst, readdata, data);
    mux2 #(5) muxWA(Instr[20:16], Instr[15:11], RegDst, WAregisterf);
    mux2 #(64) muxWD(aluout, data, MemtoReg, WDregisterf);
    regfile regfile(clk, RegWrite, Instr[25:21], Instr[20:16], WAregisterf, WDregisterf, read1, read2);
    extend extend(Instr, immediate);
    flopr #(128) SrcAB(clk, rst, {read1, read2}, {A, B});
    mux2 #(64) muxA(PC, A, ALUSrcA, SrcA);
    mux4 #(64) muxB(B, 64'b100, immediate, (immediate << 2), ALUSrcB, SrcB);
    ALUcontroler ALUcontroler(ALUOp, Instr[31:25], Instr[14:12], ALUcontrole); 
    ALU alu(SrcA, SrcB, ALUcontrole, aluresult, alufalgs);
    flopr #(64) ALUOut(clk, rst, aluresult, aluout);
    mux4 #(64) mux(aluresult, aluout, 64'bx, 64'bx, PCSource, PCnext);

    
endmodule