module mipscpu(input wire reset, input wire clock, input wire [31:0] instrword,input wire newinstr);
	
	
	//Instantiate datapath
	reg d_RegDst,d_MemRead,d_MemtoReg,d_MemWrite,d_ALUSrc,d_RegWrite;
	reg [3:0] d_ALUCtrl;
	
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
		.ALUOp1(ALUOp[0]),
		.ALUOp0(ALUOp[1]),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemToReg(MemToReg),
		.Branch(Branch)
	);
	
	//Instantiate ALU Control
	
	wire [3:0] ALUCtrl;
	
	alucontrol myALUControl(
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
    
    reg [1:0] state, nextState;
    integer i;
    always @(posedge clock or posedge reset or posedge newinstr) begin
			if(reset) begin
				state <= id;
				
	        	for (i=0; i<32; i=i+1) begin
	        			myDatapath.registerfile_instance.registerFile[i] = 32'b0;
      			end
      			for (i=0; i<128; i=i+1) begin
	        			myDatapath.memory_instance.memoryFile[i] = 32'b0;
      			end
				
			end
			else if(clock) begin
				state <= nextState;
			end
			else begin //newinstr
				state <= id;
			end
					
	end
    
    
	
	
endmodule