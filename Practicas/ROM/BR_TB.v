`timescale 1ns/1ns
module BR_TB();
    reg [4:0]RR1_TB;
    reg [4:0]RR2_TB;
    reg [4:0]WR_TB;
    reg [31:0] WD_TB;
    reg RegW_TB;
    wire [31:0]RD1_TB;
    wire [31:0]RD2_TB;

    BankRegister DUV(.RR1(RR1_TB), .RR2(RR2_TB), .WR(WR_TB), .WD(WD_TB), 
                    .RegW(RegW_TB), .RD1(RD1_TB), .RD2(RD2_TB));

    initial begin
        RegW_TB = 0;
        RR1_TB = 5'd0;
        RR2_TB = 5'd8; 
        #100;
        RegW_TB = 1;
        WD_TB = 32'd200;
        WR_TB = 5'd0;
        #100;
        WD_TB = 32'd512;
        WR_TB = 5'd8;
        RR1_TB = 5'd11;
        #100;
        RR2_TB = 5'd31;
        WR_TB = 5'd11;
        WD_TB = 32'd16;
        #100;
        RegW_TB = 0;
        WR_TB = 5'd31;
        WD_TB = 32'd128;
        #100;
        RegW_TB = 1;
        #100;
        $stop;
    end

endmodule