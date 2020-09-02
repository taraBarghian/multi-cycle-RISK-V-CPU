module adder (input logic [3:0] SrcA, SrcB,
              output logic [3:0] Out);

    assign Out = SrcA + SrcB;
endmodule