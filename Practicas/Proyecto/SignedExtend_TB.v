// SignExtend_TB.v
`timescale 1ns/1ns

module SignExtend_TB();
    reg  [15:0] imm16;
    wire [31:0] imm32;

    SignExtend DUV(.imm16(imm16), .imm32(imm32));

    initial begin
        imm16 = 16'h0001; #10;
        imm16 = 16'h8000; #10; // bit 15 = 1 -> negativo
        $stop;
    end
endmodule
