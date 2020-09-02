module ALU(input  logic [63:0] a, b,
           input  logic [1:0]  ALUControl,
           output logic [63:0] Result,
           output logic [3:0]  ALUFlags);

  logic        neg, zero, carry, overflow;
  logic [63:0] condinvb;
  logic [64:0] sum;

  assign condinvb = ALUControl[0] ? ~b : b;
  assign sum = a + condinvb + ALUControl[0];

  always_comb
    casex (ALUControl[1:0])
      2'b0?: Result = sum;
      2'b10: Result = a & b;
      2'b11: Result = a | b;
    endcase

  assign neg      = Result[63];
  assign zero     = (Result == 64'b0);
  assign carry    = (ALUControl[1] == 1'b0) & sum[64];
  assign overflow = (ALUControl[1] == 1'b0) & 
                    ~(a[63] ^ b[63] ^ ALUControl[0]) & 
                    (a[63] ^ sum[63]); 
  assign ALUFlags    = {neg, zero, carry, overflow};
endmodule