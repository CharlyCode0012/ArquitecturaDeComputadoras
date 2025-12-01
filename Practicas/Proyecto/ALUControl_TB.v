// ALUControl_TB.v
`timescale 1ns/1ns

module ALUControl_TB();
    reg [1:0] ALUOp;
    reg [5:0] funct;
    wire [3:0] ALUCtrl;

    ALUControl DUV(.ALUOp(ALUOp), .funct(funct), .ALUCtrl(ALUCtrl));

    initial begin
        // lw/sw
        ALUOp = 2'b00; funct = 6'bxxxxxx; #10;
        // beq
        ALUOp = 2'b01; funct = 6'bxxxxxx; #10;
        // R-type
        ALUOp = 2'b10; funct = 6'b100000; #10; // ADD
        funct = 6'b100010; #10;                 // SUB
        funct = 6'b100100; #10;                 // AND
        funct = 6'b100101; #10;                 // OR
        funct = 6'b100111; #10;                 // NOR
        funct = 6'b101010; #10;                 // SLT
        $stop;
    end
endmodule
