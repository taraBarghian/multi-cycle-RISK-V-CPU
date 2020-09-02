module extend(input logic [31:0] instruction,
             output logic [63:0] immediate);
    
    always @(*)begin
        immediate={12'b000000000000,20'b00000000000000000000,20'b00000000000000000000,12'b000000000000};
        case(instruction[6:0])
            7'b0000011: begin
                            case(instruction[31])
                            1'b1: immediate={12'b111111111111,20'b11111111111111111111,20'b11111111111111111111,instruction[31:20]};
                            1'b0: immediate={12'b000000000000,20'b00000000000000000000,20'b00000000000000000000,instruction[31:20]};
                            endcase
                            
                        end //load
            7'b0100011: begin immediate[11:5]=instruction[31:25]; immediate[4:0]=instruction[11:7]; end//store
            7'b1100011: begin 
                            case(instruction[31])
                            1'b1:  immediate={11'b11111111111,20'b11111111111111111111,20'b11111111111111111111,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}; 
                            1'b0:   immediate={11'b00000000000,20'b00000000000000000000,20'b00000000000000000000,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
                            endcase
                end//branch
            endcase
           
    end
endmodule