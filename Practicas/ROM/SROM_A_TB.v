`timescale 1ns/1ns

module SROM_A_TB();
    reg [7:0]addressTB;
    wire [7:0]out_dataTB;

    ROM DUV (.address(addressTB), .out_data(out_dataTB));
    

    initial begin
        addressTB = 9;
        #100;
        addressTB = 1;
        #100;
        addressTB = 3;
        #100;
        addressTB = 5;
        #100;
        addressTB = 7;
        #100;
        $stop;
    end

endmodule