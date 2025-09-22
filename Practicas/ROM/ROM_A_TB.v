`timescale 1ns/1ns

module ROM_A_TB();
    reg [7:0]addressTB;
    wire [7:0]out_dataTB;

    ROM DUV (.address(addressTB), .out_data(out_dataTB));
    

    initial begin
        addressTB = 8'd9;
        #100;
        addressTB = 8'd1;
        #100;
        addressTB = 8'd3;
        #100;
        addressTB = 8'd5;
        #100;
        addressTB = 8'd7;
        #100;
        $stop;
    end

endmodule