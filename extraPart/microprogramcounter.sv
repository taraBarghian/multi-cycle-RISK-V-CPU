module  microprogramcounter (input logic rst, clk,
                             input logic [3:0] d,
                             output logic [3:0]q);

    always_ff@(posedge clk or posedge rst)begin 
		if(rst)
                  q <= 4'b0000;
		else
			q <= d;
	end

endmodule