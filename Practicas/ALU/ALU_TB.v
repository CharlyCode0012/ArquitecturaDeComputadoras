`timescale 1ns/1ns

module ALU_TB();
    reg [3:0]A_TB;
    reg [3:0]B_TB;
    reg [3:0]sel_TB;
    wire [3:0]C_TB;

    ALU DUV(.A(A_TB), .B(B_TB), .sel(sel_TB), .C(C_TB));

    initial begin
        A_TB = 4'b0101;
        B_TB = 4'b0010;
        sel_TB = 4'b0000;
        #100
        sel_TB = 4'b0001;
        #100
        sel_TB = 4'b0010;
        #100
        sel_TB = 4'b0011;
        #100
        sel_TB = 4'b0100;
        #100
        sel_TB = 4'b0101;
        #100
        sel_TB = 4'b0110;
        #100
        sel_TB = 4'b0111;
        #100
        sel_TB = 4'b1000;
        #100
        sel_TB = 4'b1001;
        #100
        $stop;

    end
endmodule