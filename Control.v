module ControlPath(

instrWord,
RegDest,
RegWrite,
ALUSrc,
ALUOp1,
ALUOp0,
MemRead,
MemWrite,
MemToReg,
Branch

);

//Input
input wire[31:0] instrWord; // input being seen by module is 32 bits



//Output

output reg RegDest;    
output reg RegWrite; 
output reg ALUSrc;
output reg ALUOp1;
output reg ALUOp0;
output reg MemRead;
output reg MemWrite;
output reg MemToReg;
output reg Branch;



always @ (instrWord)




begin
    // Rformat
	if(instrWord[31:26] == 6'b000000 )begin   // opcode for r format
	

	RegDest = 1;
	RegWrite = 1;
	ALUSrc = 0;
	ALUOp1 = 1;
	ALUOp0 = 0;
	MemRead = 0;
	MemWrite = 0;
	MemToReg = 0;
	Branch = 0;
	
	
	end
	

	
	//lw
	else if(instrWord[31:26] == 6'b100011 )begin //opcode for lw
	
	
	RegDest = 0;
	ALUSrc = 1;
	MemToReg = 1;	
	RegWrite = 1;
	MemRead = 1;
	MemWrite = 0;
	Branch = 0;	
	ALUOp1 = 0;
	ALUOp0 = 0;
	
		



	
	
	end
	
	//sw
	else if(instrWord[31:26] == 6'b101011)begin // opcode for sw
	
	RegDest = 0;    // x
	ALUSrc = 1;
	MemToReg = 0;	//x
	RegWrite = 0;
	MemRead = 0;
	MemWrite = 1;
	Branch = 0;	
	ALUOp1 = 0;
	ALUOp0 = 0;
	
	end
	
	else if(instrWord[31:26] !== 6'b000000 | 6'b100011 | 6'b101011) begin // instructions that will give dontcares
	
	RegDest = 0;    
	ALUSrc = 0;
	MemToReg = 0;	
	RegWrite = 0;        //no ops dont write to reg
	MemRead = 0;
	MemWrite = 0;        //no ops dont write to mem
	Branch = 0;	
	ALUOp1 = 0;
	ALUOp0 = 0;
	
	
	end
	


	
	
	
	end
	
	endmodule
	

	
	

