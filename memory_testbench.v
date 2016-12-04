module memory_testbench;
	
	reg [6:0] address;
	reg[31:0] writeData;
	wire[31:0] readData;
	reg trigWrite,trigRead;
	
	memory myMemory(
		.address(address),
		.writeData(writeData),
		.trigWrite(trigWrite), 
		.trigRead(trigRead), 
		.readData(readData)
	);
	
	initial begin
		
		//Write some stuff
		address = 0;
		writeData = 32'hABCDABCD;
		trigRead = 0;
		trigWrite = 1;
		#5
		trigWrite= 0;
		$display("Data in location 0: %h",myMemory.memoryFile[0]);
		
		address = 1;
		writeData = 32'hAAAAAAAA;
		trigRead = 0;
		trigWrite = 1;
		#5
		trigWrite= 0;
		
		$display("Data in location 1: %h",myMemory.memoryFile[1]);
		
		
		//Read some stuff
		myMemory.memoryFile[2] = 32'hBBBBCCCC;
		myMemory.memoryFile[3] = 32'hBCBCBCBC;
		myMemory.memoryFile[0] = 32'hCCCCCCCC;
		
		address = 2;
		trigWrite = 0;
		trigRead = 1;
		#2
		trigRead = 0;
		
		$display("Data in location 2: %h",myMemory.memoryFile[2]);
		
		address = 3;
		trigWrite = 0;
		trigRead = 1;
		#2
		trigRead = 0;
		
		$display("Data in location 3: %h",myMemory.memoryFile[3]);
		
		address = 0;
		trigWrite = 0;
		trigRead = 1;
		#2
		trigRead = 0;
		
		$display("Data in location 0: %h",myMemory.memoryFile[0]);

	
	end
	
endmodule


