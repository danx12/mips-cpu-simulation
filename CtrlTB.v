module testbench;
	
//Input
output reg[31:0] instrWord; // since the Instruction being seen from the input is the full 32 bit instruction you will send a 32 bit instruction to the input



//Output

input wire RegDest;    
input wire RegWrite; 
input wire ALUSrc;
input wire ALUOp1;
input wire ALUOp0;
input wire MemRead;
input wire MemWrite;
input wire MemToReg;
input wire Branch;

 


	ControlPath controlpath(

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


	

	
	initial
	begin
		// R format
 		#10
 		instrWord = 32'b00000001010101010101010101010101;
		#10
		$display("Rformat");
	    $display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
		// lw
  		#10
 		instrWord = 32'b10001110101010101010101010101010;
		#10
		$display("lw");
		$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
 		//sw
		#10
 		instrWord = 32'b10101100000000000000000000000000;
		#10
		$display("sw");	
		$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
		
		//no ops
		#10
 		instrWord = 32'b11111111111111111111111111111111;
		#10
	$display("no op");
	$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
		
		// no ops
 		#10
 		instrWord = 32'b10010100000000000000000000000000;
		
		#10
	$display("no op");
	$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
		
		// no ops
 		#10
 		instrWord = 32'b11010100000000000000000000000000;
		#10
	$display("no op");
	$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
	

		// Rformat
		#10
 		instrWord = 32'b00000001010101010101010101010101;
		#10
		$display("Rformat");
	    $display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);

		//lw
  		#10
 		instrWord = 32'b10001110101010101010101010101010;
		#10
		$display("lw");
		$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
 		
		//sw
		#10
 		instrWord = 32'b10101100000000000000000000000000;
		#10
		$display("sw");	
		$display("RegDest = %d , \nALUSrc = %d, \nMemToReg = %d, \nRegWrite = %d, \nMemRead = %d,  \nMemWrite = %d, \nBranch  = %d , \nALUOp1 = %d, \nALUOp0 = %d", RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
				
		
		$finish;
 		
 		end
 	endmodule
