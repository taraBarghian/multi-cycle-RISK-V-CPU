module mem(input logic clk,
	       input logic MemRead,
	       input logic MemWrite,
	       input logic [63:0] Address,
	       input logic [63:0] WriteData,
	       output logic[63:0] ReadData);

    logic [63:0] Instr_DataMemory[0:1023];

//initial 
//$readmemh("memfile.dat",InstrMemory[14:0]);

    initial begin
        Instr_DataMemory[0] <= 8'h32003683;
        Instr_DataMemory[4] <= 8'h32803603;
        Instr_DataMemory[8] <= 8'h32803303;
        Instr_DataMemory[12] <= 8'h33003383;
        Instr_DataMemory[16] <= 8'h33803403;
        Instr_DataMemory[20] <= 8'h34003283;
        Instr_DataMemory[24] <= 8'h36803483;
        Instr_DataMemory[28] <= 8'h3202B583;
        Instr_DataMemory[32] <= 8'h0095E5B3;
        Instr_DataMemory[36] <= 8'h32B2B023;
        Instr_DataMemory[40] <= 8'h008282B3;
        Instr_DataMemory[44] <= 8'h00C30333;
        Instr_DataMemory[48] <= 8'h00733267;
        Instr_DataMemory[52] <= 8'hFED03267;





        Instr_DataMemory[800] <= 0;
        Instr_DataMemory[808] <= 1;
        Instr_DataMemory[816] <= 5;
        Instr_DataMemory[824] <= 8;
        Instr_DataMemory[832] <= 40;
    //array for test
        Instr_DataMemory[840] <= 1;
        Instr_DataMemory[848] <= 2;
        Instr_DataMemory[856] <= 3;
        Instr_DataMemory[864] <= 4;

        Instr_DataMemory[872] <= 10; 
    end



    assign ReadData = MemRead ? Instr_DataMemory[Address >> 3] : Instr_DataMemory[Address >> 2];
 	
	always@(posedge clk)
        if (MemWrite) 
	        Instr_DataMemory[Address >> 3] = WriteData;

endmodule
