`timescale 1ns/1ns

module SRAM_A_TB();
    reg [7:0] addressTB;
    reg [7:0] input_dataTB;
    reg EN_TB;
    wire [7:0] out_dataTB;

    SRAM_A DUV(.address(addressTB), .input_data(input_dataTB), .EN(EN_TB), .out_data(out_dataTB));

    initial begin
        addressTB = 0;
        input_dataTB = 115;
        EN_TB = 0;
        #100;
        EN_TB = 1;
        #100;
        addressTB = 1;
        input_dataTB = 95;
        EN_TB = 0;
        #100;
        EN_TB = 1;
        #100;
        addressTB = 2;
        input_dataTB = 80;
        EN_TB = 0;
        #100;
        EN_TB = 1;
        #100;
        addressTB = 3;
        input_dataTB = 95;
        EN_TB = 0;
        #100;
        EN_TB = 1;
        #100;
        addressTB = 4;
        input_dataTB = 80;
        EN_TB = 0;
        #100;
        EN_TB = 1;
        #100;
        $stop;
    end
    
endmodule