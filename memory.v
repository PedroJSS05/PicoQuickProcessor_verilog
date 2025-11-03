module memory(
	input clk,
	input rst,
	input [31:0] pc, // endereço da proxima instrucao
	input write_enable, // flag de controle da escrita
	output [31:0] inst, // instrucao buscada pelo pc
	input [31:0] read_data, // endereco usado no LOAD
	input [31:0] add_write, // endereco usado no STORE
	input [31:0] data_write, // dado a ser guardado no STORE
	output [31:0] data_out // dado buscado no LOAD
);

reg [31:0] memoria [0:255]; // memoria de 256 palavras de 32 bits




// controla a memoria de dados
integer i;
always@(posedge clk or posedge rst) begin
	if(rst)begin
		for(i = 0; i < 256; i = i + 1)begin
			memoria[i] = 0;
		end
	end
	else begin
		if(write_enable)begin
			memoria[add_write[9:2]] = data_write;
		end
	end

end



assign inst = memoria[pc[9:2]];

assign data_out = memoria[read_data[9:2]];

endmodule

