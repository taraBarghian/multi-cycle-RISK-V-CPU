module test();

	logic clk,rst;
	datapath datapath(clk, rst);
		// generate clock to sequence tests
	always
		begin
			rst = 1'b1; #10;
			rst = 1'b0;
			clk <= 1; #5; clk <= 0; #5;
		end
		
		
	
	
	
	


endmodule