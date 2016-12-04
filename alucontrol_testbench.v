module alucontrol_stimulus;
	
	reg [1:0] aluop;
	reg [5:0] fun;
	wire [3:0] aluctrl;
	
	reg [1:0] aluop_in [0:7];
	reg[5:0] fun_in [0:7];
	reg [3:0] aluctrl_in [0:7];
	
	reg [3:0] aluctrl_cmp;
	
	
	alucontrol_v2 myAlucontrol(
		.aluop(aluop),
		.fun(fun),
		.aluctrl(aluctrl)
	);
	
	integer i;
	initial begin
		$readmemb("aluop_test.txt",aluop_in);
		$readmemb("function_test.txt",fun_in);
		$readmemb("output_test.txt",aluctrl_in);
		
		#2
		
		for(i=0;i<8;i=i+1) begin
			aluop = aluop_in[i];
			fun = fun_in[i];
			aluctrl_cmp = aluctrl_in[i];
			$display("Op: %b, Fun: %b, Output: %b.",aluop,fun,aluctrl_cmp);
			
			#2
			$display("Ouput is -> %b",aluctrl);
			
			if(aluctrl == aluctrl_cmp) begin
				$display("Passed ALU testvector %d",i);
			end
	       	else begin
				$display("Failed ALU testvector %d",i);
			end
			
			
		end
	
	end
	
endmodule