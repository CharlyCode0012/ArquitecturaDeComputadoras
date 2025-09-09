`timescale 1ns/1ns

module _preALU_TB();
    reg [3:0]A_TB;
    reg [3:0]B_TB;
    reg sel_TB;
    wire [3:0]C_TB;

    _preALU DUV (.A(A_TB), .B(B_TB), .sel(sel_TB), .C(C_TB));
    initial begin
        A_TB = 4'd9;
        B_TB = 4'd7;
        sel_TB = 0;
        #100
        sel_TB = 1;
        #100
        A_TB = 4'd5;
        B_TB = 4'd2;
        #100
        sel_TB = 0;
        #100
        A_TB = 4'd3;
        B_TB = 4'd6;
        #100
        A_TB = 4'd15;
        B_TB = 4'd7;
        sel_TB = 0;
        #100
        $stop;
    end
endmodule