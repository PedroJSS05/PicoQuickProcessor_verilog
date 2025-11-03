module control(
	input rst,
	input clk,
	input [7:0] opcode, // entrada que define as flags
	output reg write_enable_memory, // habilita escrita na memoria
	output reg write_enable_reg, // habilita escrita no registrador
	output reg [1:0] control_op, // controla entrada na escrita do reg
	output reg finaliza_execucao, // finaliza esxecucao total
	output reg jump_enable // habilita o jump

);

always@(*) begin
	if (rst)begin
       		write_enable_memory <= 0;
        	write_enable_reg <= 0;
        	control_op <= 2'b00;
        	finaliza_execucao <= 0;
        	jump_enable <= 0;
	end
	case(opcode)
		8'h00 : begin // registrador guarda o signextend
			write_enable_memory <= 0; 
			write_enable_reg <= 1; // habilita escrita no reg
			control_op <= 2'b01; // escolhe para entrada do reg1 o sign extend
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h01 : begin // copia o valor do reg2 para o reg1
			write_enable_memory <= 0;
			write_enable_reg <= 1; // habilita escrita no reg
			control_op <= 2'b10; // escolhe para entrada do reg1 o valor do reg2
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h02 : begin // LOAD
			write_enable_memory = 0;
			write_enable_reg = 1; // habilita escrita no reg
			control_op = 2'b11; // escolhe para entrada do reg1 o valor buscado na memoria
			finaliza_execucao = 0;
			jump_enable = 0;
		end
		8'h03 : begin // STORE
			write_enable_memory <= 1; // habilita escrita na memoria
			write_enable_reg <= 0;
			control_op <= 2'b00; // dont care
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h05 : begin // jump
			write_enable_memory <= 0;//dont care
			write_enable_reg <= 0;//dont care
			control_op <= 2'b00;// dont care
			finaliza_execucao <= 0;
			jump_enable <= 1;
		end
		8'h09 : begin // soma
			write_enable_memory <= 0;
			write_enable_reg <= 1; // guarda o resultado no reg1
			control_op <= 2'b00; // entrada do reg e o alu out
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h0A : begin // subtracao
			write_enable_memory <= 0;
			write_enable_reg <= 1; // guarda o resultado no reg1
			control_op <= 2'b00; // entrada do reg e o alu out
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h0B : begin // and
			write_enable_memory <= 0;
			write_enable_reg <= 1; // guarda o resultado no reg1
			control_op <= 2'b00; // entrada do reg e o alu out
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h0C : begin // or
			write_enable_memory <= 0;
			write_enable_reg <= 1; // guarda o resultado no reg1
			control_op <= 2'b00; // entrada do reg e o alu out
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
		8'h0F : begin // termina a execucao
			write_enable_memory = 0;
			write_enable_reg = 0;
			control_op = 2'b00;
			finaliza_execucao = 1; // flag que e tratada para acabar a execucao
			jump_enable = 0;
		end
		default : begin // instruÃ§ao invalida
			write_enable_memory <= 0;
			write_enable_reg <= 0;
			control_op <= 2'b00;
			finaliza_execucao <= 0;
			jump_enable <= 0;
		end
	endcase
end

endmodule

