// ShiftLeft2_TB.v
`timescale 1ns/1ns

module ShiftLeft2_TB();
    reg  [31:0] in;
    wire [31:0] out;

    ShiftLeft2 DUV(.in(in), .out(out));

    initial begin
        in = 32'd1;  #10;
        in = 32'd4;  #10;
        in = 32'd10; #10;
        $stop;
    end
endmodule
