module tb_picoquickprocessor;

//sinais de conexao
reg tb_clk;
reg tb_rst;
wire [31:0] tb_debug_pc ;
wire [31:0] tb_debug_inst ;
wire [31:0] tb_debug_alu_out ;

top dut(
//instanciando os fios do testbench as portas do top (dut)
    .clk(tb_clk),
    .rst(tb_rst),
    .debug_pc(tb_debug_pc),
    .debug_inst(tb_debug_inst),
    .debug_alu_out(tb_debug_alu_out)
);

integer i;
initial begin
    $dumpfile("top.vcd"); //nome do arquivo de ondas
    $dumpvars(0, dut); 
    for (i = 0; i < 64; i = i + 1) begin
        // isso adiciona memoria[i] ao VCD 
        $dumpvars(0, dut.mem_inst.memoria[i]);
    end
    for (i = 0; i < 16; i = i + 1) begin
        // isso adiciona registrador[i] ao VCD
        $dumpvars(0, dut.reg_inst.registrador[i]);
    end
end

initial begin
    $display("                                        --- FLASCO COMPANY ---");
    tb_clk = 0; //seta o valor do clock
    tb_rst = 1; //seta o valor do reset e ativa
    $monitor("Time: %t | Reset: %b | PC: %h, Instruction: %h | ALU Out: %h", 
    $time, 
    tb_rst, 
    tb_debug_pc, 
    tb_debug_inst, 
    tb_debug_alu_out);
    #20 //aguarda 2 ciclos
    tb_rst = 0; // desativa o reset

    #100;
    $finish;
end

// gera o clock para sempre
always #5 tb_clk = ~tb_clk;

endmodule