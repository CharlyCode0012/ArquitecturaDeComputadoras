`timescale 1ns/1ns

module SRAM_S_TB();
    reg [7:0] addressTB;
    reg [7:0] in_dataTB;
    reg clkTB;
    reg EN_TB;
    wire [7:0] out_dataTB;

    SRAM_S DUV(.address(addressTB), .in_data(in_dataTB), .clk(clkTB), .EN(EN_TB), .out_data(out_dataTB));

    initial begin
        clkTB = 0;
    end

    always begin
        #50 clkTB = ~clkTB; 
    end

    initial begin
        addressTB = 0;
        in_dataTB = 115;
        EN_TB = 0;
        @(posedge clkTB);
        EN_TB = 1;
        @(posedge clkTB);
        EN_TB = 0;
       @(posedge clkTB);
        addressTB = 1;
        in_dataTB = 95;
       @(posedge clkTB);
        EN_TB = 1;
       @(posedge clkTB);
        addressTB = 2;
        in_dataTB = 80;
        EN_TB = 0;
       @(posedge clkTB);
        EN_TB = 1;
       @(posedge clkTB);
        addressTB = 3;
        in_dataTB = 95;
        EN_TB = 0;
       @(posedge clkTB);
        EN_TB = 1;
       @(posedge clkTB);
        addressTB = 4;
        in_dataTB = 80;
        EN_TB = 0;
       @(posedge clkTB);
        EN_TB = 1;
       @(posedge clkTB);
        $stop;
    end

endmodule