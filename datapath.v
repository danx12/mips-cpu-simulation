

module datapath(instruction,RegDst,MemRead,MemtoReg,ALUCtrl,MemWrite,ALUSrc,RegWrite);
	
	//Inputs
	input wire [31:0] instruction;
	input wire RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	input wire [3:0] ALUCtrl;
	
	wire [4:0] writeRegisterMux;
	wire [31:0] readData1, readData2;
	wire [31:0] signExtendOutput;
	wire [31:0] aluOp2MuxOutput;
	wire [31:0] aluOutput;
	wire [31:0] readFromMemory;
	wire [31:0] writeDataToReg;
	
	assign writeRegisterMux = RegDst ? instruction[20:16] : instruction[15:11];
	
	registerfile  registerfile_instance (
		.readReg1(instruction[25:21]),
		.readReg2(instruction[20:16]),
		.writeReg(writeRegisterMux),
		.writeData(writeDataToReg),
		.regWrite(RegWrite),
		.readData1(readData1),
		.readData2(readData2)
	);
	
	signextend  signextend_instance (
		.inputVal(instruction[15:0]),
		.outputVal(signExtendOutput)
	);
	
	twotoonemux  twotoonemux_alu_op_2 (
		.input1(readData2),
		.input2(signExtendOutput),
		.sel(ALUSrc),
		.outputval(aluOp2MuxOutput)
	);
	
	alu  alu_instance (
		.op1(readData1),
		.op2(aluOp2MuxOutput),
		.ctrl(ALUCtrl),
		.result(aluOutput)
	);
	
	memory memory_instance(
		.address(aluOutput),
		.writeData(readData2), 
		.trigWrite(MemWrite), 
		.trigRead(MemRead), 
		.readData(readFromMemory)
	);
	
	twotoonemux  twotoonemux_memory_output (
		.input1(aluOutput),
		.input2(readFromMemory),
		.sel(MemtoReg),
		.outputval(writeDataToReg)
	);
	
	
	
	
	
	
	
endmodule
	

module alu(input wire [31:0] op1,input wire [31:0] op2,input wire [3:0] ctrl,output reg [31:0] result);
	
	
	//assigned a localparam for each function the ALU is to perform.
	localparam [3:0] 
	opAnd = 4'b0000,
	opOr = 4'b0001,
	opAdd = 4'b0010,
	opSubs = 4'b0110,
	opSlt = 4'b0111,
	opNor = 4'b1100;
		
	//Assign result to the corresponding operation as dictated by ctrl.
	always @ (*) begin
		case(ctrl)

			opAnd: begin
				result = op1 & op2;
			end

			opOr: begin
				result = op1 | op2;
			end

			opAdd: begin
				result = op1 + op2;
			end

			opSubs: begin
				result = op1 - op2;
			end

			opSlt: begin
				result = op1 < op2;
			end

			opNor: begin
				result = op1 ~| op2;
			end

		endcase


	end

endmodule


module twotoonemux(input wire [31:0] input1,input wire [31:0] input2,input wire sel,output wire [31:0] outputval);
	
	//Simply select input 1 (sel ==0) or input 2 (sel ~=0 or sel==1).
	assign outputval = sel == 0 ? input1 : input2;

endmodule



module registerfile(input wire [4:0] readReg1, input wire [4:0] readReg2, input wire [4:0] writeReg, input wire [31:0] writeData, input wire regWrite, output reg [31:0] readData1, output reg [31:0] readData2);

	//Create an array of 32 register files each 4 bytes long.
	reg [31:0] registerFile [31:0];

	//At any time readData1 and readData2 can be assigned. No need to wait for any signal.
	always @ (*) begin
		readData1 = registerFile[readReg1];
		readData2 = registerFile[readReg2];
	end

	//Only save data to the register file on the positive-edge of the regWrite signal.
	always @ (posedge regWrite) begin
		registerFile[writeReg] = writeData;

	end
endmodule




module signextend(input wire [15:0] inputVal,output wire [31:0] outputVal);

	//Simply concatenate 16 times the last digit of inputVal with inputVal.
	assign outputVal = {{16{inputVal[15]}},inputVal};

endmodule
