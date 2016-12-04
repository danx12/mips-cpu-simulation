module mipscpu(input wire reset, input wire clock, input wire [31:0] instrword,input wire newinstr);
	
	
	//Instantiate datapath
	reg d_RegDst = 0;
	reg d_MemRead=0;
	reg d_MemtoReg=0;
	reg d_MemWrite=0;
	reg d_ALUSrc=0;
	reg d_RegWrite=0;
	reg [3:0] d_ALUCtrl = 0;
	
	datapath myDatapath(
		.instruction(instrword),
		.RegDst(d_RegDst),
		.MemRead(d_MemRead),
		.MemtoReg(d_MemtoReg),
		.ALUCtrl(d_ALUCtrl),
		.MemWrite(d_MemWrite),
		.ALUSrc(d_ALUSrc),
		.RegWrite(d_RegWrite)
	);
	
	//Instantiate controlpath
	wire RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch;
	wire [1:0] ALUOp;
	
	ControlPath myControlPath(
		.instrWord(instrword),
		.RegDest(RegDst),
		.RegWrite(RegWrite),
		.ALUSrc(ALUSrc),
		.ALUOp1(ALUOp[1]),//switched ALUOp[0] to ALUOp[1]
		.ALUOp0(ALUOp[0]),//switched ALUOp[1] to ALUOp[0]
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemToReg(MemToReg),
		.Branch(Branch)
	);
	
	//Instantiate ALU Control
	wire [3:0] ALUCtrl;
	
	alucontrol_v2 myALUControl(
		.aluop(ALUOp),
		.fun(instrword[5:0]),
		.aluctrl(ALUCtrl)
	);
	
	
	
	//Define labels for the values of the different states.
	localparam [1:0]
	id  = 2'b00,
	ex    = 2'b01,
	mem = 2'b10,
	wb = 2'b11;
    
    
    //FSM
    reg [1:0] state = id;
    //reg [1:0] nextState=ex;
    integer i;
   	always @(posedge clock or posedge reset or posedge newinstr) begin
		if(reset) begin
	         for (i=0; i<32; i=i+1) begin
	          myDatapath.registerfile_instance.registerFile[i] = 32'b0; //Go into the cpu's register file and clear all data
	     	 end
	   	 
		 for (i=0; i<128; i=i+1) begin
	          myDatapath.memory_instance.memoryFile[i] = 32'b0; //Go into memory and clear all data
	      	 end
	
		end
		
		else if(clock) begin 
			 case(state)
		          id: begin //Do nothing. Allow this clock cycle to decode and set the signals in the control path
			    state=ex;
			   end
			 
			  ex: begin
			   d_RegDst = RegDst;
			   d_ALUCtrl=ALUCtrl;
			   d_ALUSrc=ALUSrc;
			   d_MemtoReg=MemToReg; 
			   //d_Branch=Branch; //not implemented
			   state=mem;
		 	  end
		
			  mem: begin
			  //From previous
			  d_RegDst = RegDst;
			  d_ALUCtrl=ALUCtrl;
			  d_ALUSrc=ALUSrc;
			  d_MemtoReg=MemToReg; 
			  
			  
			  //Edge-sensitive
			  d_MemRead=MemRead;
			  #1 d_MemRead=0; //reset signal back to zero
			  d_MemWrite=MemWrite; //R/W autonmous protection in the memory module 
			  #1 d_MemWrite = 0;
			  state=wb;
			  
			  end
			
			  wb: begin
			  	//From previous
			  d_RegDst = RegDst;
			  d_ALUCtrl=ALUCtrl;
			  d_ALUSrc=ALUSrc;
			  d_MemtoReg=MemToReg; 
			  	
			  	//Edge sensitive
		   	   d_RegWrite=RegWrite;
			  #1 d_RegWrite=0;//reset signal back to zero
			  
			  end
		  endcase
	end
	
	else begin //newinstr
	state=id;
	d_RegDst <= RegDst;
	d_ALUCtrl <= ALUCtrl;
  	d_ALUSrc <= ALUSrc;
  	d_MemtoReg <= MemToReg; 
	 
	end			
    end
    
    
	
	
endmodule
