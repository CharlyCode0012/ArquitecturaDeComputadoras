`timescale 1ns/1ns

module MIPS32_TB;

    reg clk;
    reg reset;

    // Instancia del procesador
    MIPS32 DUV (
        .clk   (clk),
        .reset (reset)
    );

    // Clock 10ns de período
    initial begin
        clk = 0;
    end

    always begin
        #50 clk = ~clk;
    end

    // Reset y duración de la simulación
    initial begin
        reset = 1;
        #20;          // un ratito en reset
        reset = 0;    // sueltas el procesador

        #2000;        // deja correr N ns (ajusta a lo que necesites)
        $finish;
    end

    // Monitoreo: PC, instrucción actual y R30
    initial begin
        $display("   t    PC          Instr_IF                      R30");
        $monitor("%4t  %h  %b  %h",
                 $time,
                 DUV.PC_current,       // PC actual
                 DUV.Instr_IF,         // instrucción que sale de InstructionMemory
                 DUV.rf0.RF[30]      // registro 30 del banco
        );
    end

endmodule
