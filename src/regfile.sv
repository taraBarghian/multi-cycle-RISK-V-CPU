module regfile(input logic clk,
               input logic we3,
               input logic [4:0] ra1, ra2, wa3,
               input  logic [63:0] wd3,
               output logic [63:0] rd1, rd2);
    logic [63:0] rf[31:0];
   
    assign rd1 = rf[ra1];
    assign rd2 = rf[ra2];

    always @(posedge clk)begin
        if (we3) rf[wa3] <= wd3;
    end    
endmodule