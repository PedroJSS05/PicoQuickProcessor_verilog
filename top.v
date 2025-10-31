module top(
	input clk,
	input rst
);

// fios do banco de registradores
wire [31:0] reg_out1, reg_out2;
reg [31:0] data_reg_write;

// fetch da instruçao
wire [31:0] inst;
reg [31:0] pc;


// puramente para teste, apagar assim que for botar para rodar
/*
initial begin
	pc = 0;
end
*/

// FORMATO DA INSTRUÇAO

// inst[31:24] opcode
// inst[23:20] reg1
// inst[19:16] reg2
// inst[15: 0] imediate 

// fios da memoria de dados
wire [31:0] data_load;
wire [31:0] data_store;


// fios da ULA
wire [31:0] in_A, in_B;
wire [31:0] alu_out;

// fios da control unit
wire write_enable; // habilita escrita na memoria
wire finaliza_execucao; // finaliza execuçao do programa
wire enable_reg_write; // habilita escrita nos registradores
wire [1:0] reg_write_control; // controla entrada de escrita do registrador
wire jump_enable; // habilita o jump

// fio do extender
wire [31:0] extend;

assign extend = {{16{inst[15]}}, inst[15:0]};

always@(*)begin
	case(reg_write_control)
		2'b00 : data_reg_write = alu_out;
		2'b01 : data_reg_write = extend;
		2'b10 : data_reg_write = reg_out2;
		2'b11 : data_reg_write = data_load;
		default : data_reg_write = 0;
	endcase
end

registradores reg_inst(
	.clk(clk),
	.rst(rst),
	.add_reg1(inst[23:20]),
	.add_reg2(inst[19:16]),
	.reg_out1(reg_out1),
	.reg_out2(reg_out2),
	.add_reg_write(inst[23:20]),
	.data_reg_write(data_reg_write),
	.enable_write(enable_reg_write)
);

memory mem_inst(
	.clk(clk),
	.rst(rst),
	.pc(pc), // endereco da instrucao a ser buscada na memoria
	.inst(inst), // instrucao buscada na memoria
	.read_data(reg_out2), // endereço de busca na memoria LOAD
	.data_out(data_load), // dado buscado na memoria
	.add_write(reg_out1), // endereco a ser escrito na memoria STORE
	.data_write(reg_out2), // dado a ser escrito na memoria
	.write_enable(write_enable)
 );
 




 
ula ula_inst(
	.clk(clk),
	.opcode(inst[31:24]),
	.A(reg_out1),
	.B(reg_out2),
	.out(alu_out)
);


control control_inst(
	.rst(rst),
	.clk(clk),
	.opcode(inst[31:24]), // entrada que define as flags
	.write_enable_memory(write_enable), // habilita escrita na memoria
	.write_enable_reg(enable_reg_write), // habilita escrita no registrador
	.control_op(reg_write_control), // controla entrada na escrita do reg
	.finaliza_execucao(finaliza_execucao), // finaliza esxecucao total
	.jump_enable(jump_enable) // habilita o jump
);


// atualiza contador do pc
always@(posedge clk or posedge rst) begin
	/*if (finaliza_execucao)begin
		pc = 0;
	end*/
	pc = pc + 4;
end

endmodule