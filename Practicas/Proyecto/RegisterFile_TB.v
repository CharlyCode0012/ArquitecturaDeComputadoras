// RegisterFile_TB.v

`timescale 1ns/1ns

module RegisterFile_TB();
    reg clk, RegWrite;
    reg [4:0] rs, rt, rd;
    reg [31:0] WD;
    wire [31:0] RD1, RD2;

    RegisterFile DUV(.clk(clk), .RegWrite(RegWrite), .rs(rs), .rt(rt),
                     .rd(rd), .WD(WD), .RD1(RD1), .RD2(RD2));

    initial begin
        clk = 0;
    end

    always begin
        #50 clk = ~clk;
    end


    initial begin
        RegWrite = 0; rs = 0; rt = 0; rd = 0; WD = 0;

        // Escribimos R9 = 10, R10 = 20
        #100 RegWrite = 1; rd = 5'd9;  WD = 32'd10;
        #100 rd = 5'd10; WD = 32'd20;
        #100 RegWrite = 0;

        // Leemos R9 y R10
        #100 rs = 5'd9; rt = 5'd10;
        #200 $stop;
    end
endmodule
