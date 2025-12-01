// 1.- Definicion del modulo: FETCH
//    PC + Memoria de instrucciones (ciclo de fetch)
module Fetch(clk, reset, PCSrc, BranchAddr, Instr, PC_current, PC_add4);
    input clk;
    input reset;

    // PCSrc = 0 -> PC+4
    // PCSrc = 1 -> BranchAddr (salto / branch / jump)
    input PCSrc;
    input [31:0] BranchAddr;

    output [31:0] Instr;      // Instruccion de 32 bits obtenida
    output [31:0] PC_current;  // PC actual
    output [31:0] PC_add4;    // PC + 4, para usar en la etapa de decode/execute

    // 2.- Componentes internos
    wire [31:0] PC_next;

    // Program Counter
    PC pc0(
        .clk(clk),
        .reset(reset),
        .En(1'b1),          // Siempre avanzamos
        .PC_in(PC_next),
        .PC_out(PC_current)
    );

    // Sumador PC + 4
    ADD add(
        .op1(PC_current),
        .op2(32'd4),
        .result(PC_add4)
    );

    // Multiplexor para siguiente PC
    MUX2 mux(
        .data1(PC_add4),
        .data2(BranchAddr),
        .sel(PCSrc),
        .result(PC_next)
    );

    // Memoria de instrucciones (ROM de bytes)
    InstructionMemory imem(
        .addr(PC_current),   // PC apunta al primer byte de la instruccion
        .instr(Instr)
    );

endmodule
