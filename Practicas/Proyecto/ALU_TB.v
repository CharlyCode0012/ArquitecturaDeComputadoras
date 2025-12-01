// ALU_TB.v
`timescale 1ns/1ns

module ALU_TB();
    reg [31:0] A, B;
    reg [3:0] ALUCtrl;
    wire [31:0] Result;
    wire Zero;

    ALU DUV(.A(A), .B(B), .ALUCtrl(ALUCtrl), .Result(Result), .Zero(Zero));

    initial begin
        A = 32'd10; B = 32'd20;

        ALUCtrl = 4'b0010; #10; // ADD
        ALUCtrl = 4'b0110; #10; // SUB
        ALUCtrl = 4'b0000; #10; // AND
        ALUCtrl = 4'b0001; #10; // OR
        ALUCtrl = 4'b0111; #10; // SLT
        $stop;
    end
endmodule
