`timescale 1ns/1ns

module Fetch_TB();
    reg clk_TB;
    reg reset_TB;
    reg PCSrc_TB;
    reg [31:0] BranchAddr_TB;

    wire [31:0] Instr_TB;
    wire [31:0] PC_current_TB;
    wire [31:0] PC_add4_TB;

    // Dispositivo bajo verificacion
    Fetch DUV(
        .clk(clk_TB),
        .reset(reset_TB),
        .PCSrc(PCSrc_TB),
        .BranchAddr(BranchAddr_TB),
        .Instr(Instr_TB),
        .PC_current(PC_current_TB),
        .PC_add4(PC_add4_TB)
    );

    // Reloj
    initial begin
        clk_TB = 0;
    end

    always begin
        #50 clk_TB = ~clk_TB;  // Periodo de 100 ns
    end

    initial begin
        // Inicializacion
        reset_TB      = 1;
        PCSrc_TB      = 0;
        BranchAddr_TB = 32'd0;

        // Esperamos un par de flancos de reloj
        #240;
        reset_TB = 0;

        // Dejamos que el PC avance unas cuantas instrucciones
        #1000;

        // Simulamos un salto a la instruccion 3 (direccion 12)
        PCSrc_TB      = 1;
        BranchAddr_TB = 32'd12;   // 3 * 4
        #100;
        PCSrc_TB      = 0;        // Volvemos a PC+4

        #1000;

        $stop;
    end

endmodule
