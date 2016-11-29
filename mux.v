module twotoonemux(input1, input2, sel, outputval);

input wire [4:0] input1;			// Set up of input and outputs
input wire [4:0] input2;
input wire sel;							// Mux selector
output wire [4:0] outputval;

reg [4:0] intoutput;

always @(*)
begin

case (sel)								// case testing to select output
0 : intoutput = input1;					// 1st mux

1 : intoutput = input2;					// 2nd mux

default : intoutput = 0;

endcase

end

assign outputval = intoutput;			// 1 output value mux

endmodule
