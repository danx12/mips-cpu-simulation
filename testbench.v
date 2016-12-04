module cpu_testbench();
  
 	reg reset;
 	reg clock;
 	reg newinstr;
 	reg [31:0] instrword;
 	
 	reg [5:0] op,fun;
	reg [4:0] rs,rt,rd,shift;
	reg [15:0] imm;
	
	
 	mipscpu myCPU(reset, clock, instrword, newinstr);
 	
	initial begin
		clock = 0;
		$dumpfile("outputSignals.vcd");
		$dumpvars;
	end

	initial begin
		
		reset = 1;
		#5
		reset = 0;
	
		myCPU.myDatapath.registerfile_instance.registerFile[0]=0;
		myCPU.myDatapath.registerfile_instance.registerFile[1]=0;
		myCPU.myDatapath.registerfile_instance.registerFile[31]=0; //guarantee a zero in reg 31
		myCPU.myDatapath.memory_instance.memoryFile[0]=10; //variable a = 10
		myCPU.myDatapath.memory_instance.memoryFile[1]=22; //variable b = 22
		myCPU.myDatapath.memory_instance.memoryFile[2]=6; //variable a = 6
		
		
		
		op = 6'd35; //lw
		rs = 5'd0;
		rt = 5'd1;
		imm = 16'd0;
		
		// instrword = 32'b10001111111000010000000000000000;// lw $1, 0($0)
		instrword = {op,rs,rt,imm};
		newinstr=0;
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		
		 
		op = 6'd35; //lw
		rs = 5'd0;
		rt = 5'd2;
		imm = 16'd1;
		// instrword = 32'b10001111111000100000000000000001;// lw $2, 1($0)
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		 
		op = 6'd35; //lw
		rs = 5'd0;
		rt = 5'd3;
		imm = 16'd2;
		// instrword = 32'b10001111111000110000000000000010;// lw $2, 2($0)
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		
		
		$display("%s%d", "Value at register one: ", myCPU.myDatapath.registerfile_instance.registerFile[1]);
		$display("%s%d", "Value at register two: ", myCPU.myDatapath.registerfile_instance.registerFile[2]);
		$display("%s%d", "Value at register three: ", myCPU.myDatapath.registerfile_instance.registerFile[3]);
		
		#100
		$finish;
	end


	always begin
		#3 clock=~clock;
	end

endmodule
