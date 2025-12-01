// 1.- Definicion del modulo: Memoria de instrucciones
//    Big endian, 8 bits por linea, 32 bits por instruccion

module InstructionMemory(addr, instr);
    input  [31:0] addr;      // Direccion de byte (PC)
    output [31:0] instr;     // Instruccion de 32 bits

    // 2.- Componentes internos (ROM de bytes)
    reg [7:0] MEM [0:255];   // rango/8 = total_instrucciones

    // 3.- Inicializacion de contenido desde archivo
    //    Cada linea del archivo tiene 8 bits (1 byte)
    initial begin
        $readmemb("instructions.txt", MEM);
    end

    // 4.- Implementacion del modulo
    // Big endian: el byte en addr es el MSB de la instruccion
    wire [31:0] a0 = addr;
    wire [31:0] a1 = addr + 32'd1;
    wire [31:0] a2 = addr + 32'd2;
    wire [31:0] a3 = addr + 32'd3;

    assign instr = { MEM[a0], MEM[a1], MEM[a2], MEM[a3] };

endmodule
