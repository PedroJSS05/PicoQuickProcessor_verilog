module registradores(
	input clk,
	input rst,
	input [3:0] add_reg1, // endereco para ler primeiro reg
	input [3:0] add_reg2, // endereco para ler segundo reg
	input [3:0] add_reg_write, // endereco para escrever no reg
	input [31:0] data_reg_write, // dado a ser escrito no reg
	input enable_write, // flag de controle da escrita
	output [31:0] reg_out1, // saida do primeiro reg lido
	output [31:0] reg_out2 // saida do segundo reg lido
);

reg [31:0] registrador [15:0];

integer i;
always@(posedge clk or posedge rst)begin
	if (rst)begin
			for(i = 0; i < 16; i = i + 1)begin
				registrador[i] = 0;
		end
	end
	else begin
		if(enable_write) begin
			registrador[add_reg_write] = data_reg_write;
		end
	end
end

assign reg_out1 = registrador[add_reg1];
assign reg_out2 = registrador[add_reg2];


endmodule
