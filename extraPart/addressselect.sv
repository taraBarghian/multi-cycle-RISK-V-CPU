module addressselect (input logic [1:0] AddrCtl,
                      input logic [6:0] Op,
                      input logic [3:0] plus1,
                      output logic [3:0] Out);
    
    logic [3:0] out1, out2;  

    ROM1 ROM1(Op, out1);
    ROM2 ROM2(Op, out2);
    mux Mux (4'b0, out1, out2, plus1, AddrCtl, Out);
    
endmodule