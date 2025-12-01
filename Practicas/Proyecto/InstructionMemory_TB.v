// InstructionMemory_TB.v
`timescale 1ns/1ns

module InstructionMemory_TB();
    reg  [31:0] addr;
    wire [31:0] instr;

    InstructionMemory DUV(.addr(addr), .instr(instr));

    initial begin
        
        addr = 32'd0;   #50;
        addr = 32'd4;   #50;
        addr = 32'd8;   #50;
        addr = 32'd12;  #50;
        $stop;
    end
endmodule
