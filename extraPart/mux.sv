module mux (input logic [3:0] d0, d1, d2, d3,
            input logic [1:0] S,
            output logic [3:0] Out);
            
    always_comb
    case (S)
        2'b00: Out = d0;
        2'b01: Out = d1;
        2'b10: Out = d2;
        2'b11: Out = d3;
        default: Out = 4'b0000; 
    endcase
endmodule