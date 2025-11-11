/*
unidade lógica e aritmética, aqui acontece as operações matemáticas e lógicas usadas em algumas
instruções envolvendo registradores
*/


module ula(
	input clk,
	input [7:0] opcode,
	input [31:0] A,
	input [31:0] B,
	output reg [31:0] out
	
);
always@(*) begin
	case(opcode)
		8'h09 : out = A + B;
		8'h0A : out = A - B;
		8'h0B : out = A & B;
		8'h0C : out = A | B;
		default: out = 0;
	endcase
end
 
endmodule
