module microcodememory (input logic [3:0] Input,
                        output logic [17:0] Outputs);

    always_comb 
        case (Input)
            4'b0000: Outputs = 18'b100101000000100011;
            4'b0001: Outputs = 18'b000000000001100001;
            4'b0010: Outputs = 18'b000000000001010010;
            4'b0011: Outputs = 18'b001100000000000011;
            4'b0100: Outputs = 18'b000000100000001000;
            4'b0101: Outputs = 18'b001010000000000000;
            4'b0110: Outputs = 18'b000000000100010011;
            4'b0111: Outputs = 18'b000000000000001100;
            4'b1000: Outputs = 18'b010000001010010000;
            default:  Outputs = 18'bx;
        endcase
endmodule