module ROM1 (input logic [6:0] Adr, 
             output logic [3:0] RD);
    
    always_comb
        case (Adr)
            //R-format
            7'b011_0011: RD = 4'b0110;
            //beq
            7'b110_0111: RD = 4'b1000; 
            //ld
            7'b000_0011: RD = 4'b0010;
            //sd
            7'b010_0011: RD = 4'b0010;  
            default: RD = 4'bx; 
        endcase
endmodule