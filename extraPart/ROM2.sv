module ROM2 (input logic [6:0] Adr, 
             output logic [3:0] RD);
    
    always_comb
        case (Adr)
            //ld 
            7'b000_0011: RD = 4'b0011;
            //sd 
            7'b010_0011: RD = 4'b0101; 
            default: RD = 4'bx; 
        endcase
endmodule