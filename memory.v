module memory(input wire [6:0] address, input wire [31:0] writeData, input wire trigWrite, input wire trigRead, output reg [31:0] readData);

	reg [31:0]memoryFile[127:0];
	

	always @ (posedge trigRead) begin
		if(trigWrite == 0) begin
			readData = memoryFile[address]; 
		end
	end

	always @ (posedge trigWrite) begin
		if(trigRead == 0) begin
			memoryFile[address] = writeData;
		end
	end
endmodule
