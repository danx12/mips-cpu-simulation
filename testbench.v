module cpu_testbench();
  
 	reg reset;
 	reg clock;
 	reg newinstr;
 	reg [31:0] instrword;
 	
 	reg [5:0] op,fun;
	reg [4:0] rs,rt,rd,shift;
	reg [15:0] imm;
	
	
 	mipscpu myCPU(reset, clock, instrword, newinstr);
 	
	//Set up wave form viewer
	initial begin
		clock = 0;
		$dumpfile("outputSignals.vcd");
		$dumpvars;
	end

	initial begin
		
//-------------initialization--------------
		//Clear all memory and register contents & init to zero
		reset = 1;
		#2 reset = 0;
		
		//Set memory values
		myCPU.myDatapath.memory_instance.memoryFile[0]=10; //variable a = 10
		myCPU.myDatapath.memory_instance.memoryFile[1]=22; //variable b = 22
		myCPU.myDatapath.memory_instance.memoryFile[2]=6; //variable c = 6
		
//------------Load words from mem to reg--------------	
		
	//lw $1, 1($0);	
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd1;
		imm = 16'd0;
		instrword = {op,rs,rt,imm};
		newinstr=0;
		#1 newinstr=1;
		#1 newinstr=0;
		#30;
		
	//lw $2,2($0);		 
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd2;
		imm = 16'd1;
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#30;
		 
	//lw $3, 3($0);
		op = 6'd35;
		rs = 5'd0;
		rt = 5'd3;
		imm = 16'd2;
		instrword = {op,rs,rt,imm};
		#1 newinstr=1;
		#1 newinstr=0;
		#30;


//--------------Add & subtract-------------------

	//add $4, $1, $2;
		op = 6'd00; //Register Arithmetic logical operation
		rd= 5'd4;
		rs = 5'd1;
		rt = 5'd2;
		shift = 0;
		fun = 6'd32; //add operand
		instrword = {op,rs,rt,rd,shift,fun};
		#1 newinstr=1;
		#1 newinstr=0;
		#30;

	//sub $5, $4, $3;
		op = 6'd00;
		rd= 5'd5;
		rs = 5'd4;
		rt = 5'd3;
		shift = 0;
		fun = 6'd34; //subtract operand
		instrword = {op,rs,rt,rd,shift,fun};
		#1 newinstr=1;
		#1 newinstr=0;
		#30;

//-----------Store Word--------------

	//sw $5, 3($0);	
		op = 6'd43;
		rs = 5'd0;
		rt = 5'd5;
		imm = 16'd3;
		instrword = {op,rs,rt,imm};
		newinstr=0;
		#1 newinstr=1;
		#1 newinstr=0;
		#30;



//----------Print values in registers
		$display("d = a+b-c");
		$display("a = %d", myCPU.myDatapath.memory_instance.memoryFile[0]);
		$display("b = %d", myCPU.myDatapath.memory_instance.memoryFile[1]);
		$display("c = %d", myCPU.myDatapath.memory_instance.memoryFile[2]);
		$display("d = %d", myCPU.myDatapath.memory_instance.memoryFile[3]);
		
	

		$finish;


	end


	always begin
		#3 clock=~clock;
	end

endmodule
