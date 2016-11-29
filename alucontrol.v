module alucontrol(aluop,fun,aluctrl);

	input wire [1:0] aluop;
	input wire [5:0] fun;
	output wire [3:0] aluctrl;

	assign aluctrl[3] = aluop[0] ~& aluop[0];
	assign aluctrl[2] = aluop[0] | (aluop[1] & fun[1]);
	assign aluctrl[1] =  ~(aluop[1]) | ~(fun[2]);
	assign aluctrl[0] =  (aluop[1]) & ((fun[3])|(fun[0]));


endmodule
