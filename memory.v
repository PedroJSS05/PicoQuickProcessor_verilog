/*
unidade de memoria que é compartilhada entre a memória de instruções e de dados, aqui acontece a
busca de novas instruções e o salvamento e carregamento de dados que vão ser usados usamos 64 palavras
de 32 bits cada, resultando em 256 bytes ou 2048 bits
*/

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

	reg [31:0] memoria [0:63]; // memoria de 256 palavras de 32 bits

	initial begin
		@(negedge rst); /*vai esperar o tb_rst ficar em 0 para rodar o comando desse bloco initial que injeta 
						  os dados do program.mem na memoria, pois quando o tb_ rst fica em alta esse initial
						  (sem o negedge) percebe e mantem os dados em 00000 ate que o tb_rst seja = 0.*/
		$readmemh("program.mem", memoria);
	end
	
	

/*
importante citar que dessa forma como está feita a memŕia as intruções precisam ser inciados usando
instancias no testbench, se quiser rodar em uma fpga ou algo do tipo, precisa usar o readmemh ou
readmemb para ler um arquivo de memoria, ou usar uma hiperfunction do quartus ou parecido, essa
última forma é para projetos mais avançados
*/


// controla a memoria de dados
integer i;
always@(posedge clk or posedge rst) begin
	if(rst)begin
		for(i = 0; i < 64; i = i + 1)begin
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

