module alucontrol_v2(aluOp0,aluOp1,fun,aluctrl);
	
	input wire aluOp0,aluOp1;
	input wire [5:0] fun;
	output reg [3:0] aluctrl;

	//Evaluate when any input changes.	
	always @ (aluOp0 or aluOp1 or fun) begin
		casex({aluOp1,aluOp0,fun})  //For casex a ? represents a don't care. Simply set aluctrl to the case that matches.
			8'b00??????: begin
				aluctrl = 4'b0010;
			end
			8'b01??????: begin
				aluctrl = 4'b0110;
			end
			8'b10100000: begin
				aluctrl = 4'b0010;
			end
			8'b10100010: begin
				aluctrl = 4'b0110;
			end
			8'b10100100: begin
				aluctrl = 4'b0000;
			end
			8'b10100101: begin
				aluctrl = 4'b0001;
			end
			8'b10101010: begin
				aluctrl = 4'b0111;
			end
			default: begin
				//In case that its not possible to match
				//printout an error and set the aluctrl
				//to an invalid value.
				$display("Error in ALU Control.");
				aluctrl = 4'b1111;
			end
		endcase
		
	end
	
endmodule
