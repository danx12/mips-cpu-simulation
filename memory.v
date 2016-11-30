module memory(input wire [6:0] readMem, input wire [6:0] writeMem, input wire [31:0] writeData, input wire trigWrite, input wire trigRead, output reg [31:0] readData);

	reg [127:0] memoryFile [31:0];

	always @ (posedge trigRead) begin
		if(trigWrite == 0) begin
			readData = memoryFile[readMem]; 
		end
	end

	always @ (posedge trigWrite) begin
		if(trigRead == 0) begin
			memoryFile[writeMem] = writeData;
		end
	end
endmodule
