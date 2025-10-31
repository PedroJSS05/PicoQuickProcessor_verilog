module ula(
	input clk,
	input [7:0] opcode,
	input [31:0] A,
	input [31:0] B,
	output reg [31:0] out
	
);
always@(posedge clk) begin
	case(opcode)
		8'h09 : assign out = A + B;
		8'h0A : assign out = A - B;
		8'h0B : assign out = A & B;
		8'h0C : assign out = A | B;
		default: out = 0;
	endcase
end
 
endmodule