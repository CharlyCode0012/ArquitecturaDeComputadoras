// ControlUnit_TB.v

`timescale 1ns/1ns

module ControlUnit_TB();
    reg  [5:0] opcode;
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;

    ControlUnit DUV(
        .opcode(opcode),
        .RegDst(RegDst), .Branch(Branch),
        .MemRead(MemRead), .MemtoReg(MemtoReg),
        .ALUOp(ALUOp), .MemWrite(MemWrite),
        .ALUSrc(ALUSrc), .RegWrite(RegWrite)
    );

    initial begin
        opcode = 6'b000000; #10; // R-type
        opcode = 6'b100011; #10; // lw
        opcode = 6'b101011; #10; // sw
        opcode = 6'b000100; #10; // beq
        opcode = 6'b111111; #10; // NOP
        $stop;
    end
endmodule
