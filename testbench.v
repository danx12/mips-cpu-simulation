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
		
//-------------initialization--------------
		reset = 1;
		#5
		reset = 0;
	
		myCPU.myDatapath.registerfile_instance.registerFile[0]=0;
		myCPU.myDatapath.registerfile_instance.registerFile[1]=0;
//		myCPU.myDatapath.registerfile_instance.registerFile[31]=0; //guarantee a zero in reg 31
		myCPU.myDatapath.memory_instance.memoryFile[0]=10; //variable a = 10
		myCPU.myDatapath.memory_instance.memoryFile[1]=22; //variable b = 22
		myCPU.myDatapath.memory_instance.memoryFile[2]=6; //variable c = 6
		
		
//------------Load words--------------	
		//lw  lw $1, 1($0);	
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd1;
		imm = 16'd0;
		instrword = {op,rs,rt,imm};
		newinstr=0;
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		
		//lw  lw $1,2($0);		 
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd2;
		imm = 16'd1;
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		 
		//lw  lw $1, 3($0);
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd3;
		imm = 16'd2;
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;

		$display("%s%d", "Value at register one: ", myCPU.myDatapath.registerfile_instance.registerFile[1]);
		$display("%s%d", "Value at register two: ", myCPU.myDatapath.registerfile_instance.registerFile[2]);
		$display("%s%d", "Value at register three: ", myCPU.myDatapath.registerfile_instance.registerFile[3]);

//--------------Add & subtract-------------------

		op = 6'd00; //Register Arithmetic logical operation
		rd= 5'd4;
		rs = 5'd1;
		rt = 5'd2;
		shift = 0;
		fun = 6'd32; //add operand
		instrword = {op,rs,rt,rd,shift,fun};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		$display("%s%d", "Value at register four: ", myCPU.myDatapath.registerfile_instance.registerFile[4]);

		op = 6'd00;
		rd= 5'd5;
		rs = 5'd4;
		rt = 5'd3;
		shift = 0;
		fun = 6'd34; //subtract operand
		instrword = {op,rs,rt,rd,shift,fun};
		#1 newinstr=1;
		#1 newinstr=0;
		#100;
		$display("%s%d", "Value at register five: ", myCPU.myDatapath.registerfile_instance.registerFile[5]);

		$finish;
	end


	always begin
		#3 clock=~clock;
	end

endmodule
