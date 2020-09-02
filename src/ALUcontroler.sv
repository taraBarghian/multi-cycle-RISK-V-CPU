module ALUcontroler (input logic [1:0] ALUOp,
                   input logic [6:0] funct7,
                   input logic [2:0] funct3, 
                   output logic [1:0] ALUcontrol);
    always@(*)  
    case (ALUOp)
        2'b00: ALUcontrol = 2'b00;
        2'b01: ALUcontrol = 2'b01;
        2'b10: begin
            if (funct3 == 3'b000) begin
                if (funct7 == 7'b0000000) begin
                    ALUcontrol = 2'b00; 
                end
                else if (funct7 == 7'b0100000) begin
                    ALUcontrol = 2'b01;
                end
            end
            else if (funct3 == 3'b111) begin
                ALUcontrol = 2'b10;
            end
            else if (funct3 == 3'b110) begin
                ALUcontrol = 2'b11;
            end
        end 
        default: ALUcontrol = 2'bxx;
    endcase            
    
endmodule