// 1.- Definicion del modulo: Program Counter

module PC(clk, reset, En, PC_in, PC_out);
    input clk;
    input reset;
    input En;                 // Habilita escribir el siguiente PC
    input [31:0] PC_in;       // Siguiente valor de PC
    output reg [31:0] PC_out; // PC actual

    // 3.- Cuerpo del modulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_out <= 32'd0;      // Comenzamos en direccion 0
        end else if (En) begin
            PC_out <= PC_in;      // Actualizamos PC
        end
        // Si En = 0, mantiene el valor actual (stall)
    end

endmodule
