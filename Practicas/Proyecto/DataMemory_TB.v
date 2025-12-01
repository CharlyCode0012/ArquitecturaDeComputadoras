// DataMemory_TB.v

`timescale 1ns/1ns

module DataMemory_TB();
    reg clk, MemRead, MemWrite;
    reg [31:0] Address, WriteData;
    wire [31:0] ReadData;

    DataMemory DUV(.clk(clk), .MemRead(MemRead), .MemWrite(MemWrite),
                   .Address(Address), .WriteData(WriteData),
                   .ReadData(ReadData));

    initial begin
        clk = 0;
    end

    always begin
        #50 clk = ~clk;
    end

    initial begin
        MemRead = 0; MemWrite = 0; Address = 0; WriteData = 0;

        // Escribimos en direccion 0
        #100 MemWrite = 1; Address = 32'd0; WriteData = 32'hDEADBEEF;
        #100 MemWrite = 0;

        // Leemos direccion 0
        #100 MemRead = 1; Address = 32'd0;
        #100 MemRead = 0;

        $stop;
    end
endmodule
