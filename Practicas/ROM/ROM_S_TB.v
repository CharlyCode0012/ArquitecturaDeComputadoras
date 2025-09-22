`timescale 1ns/1ns

module ROM_S_TB();
    reg [7:0] addressTB;
    wire [7:0] out_dataTB;
    reg clkTB;

    ROM_S DUV(.address(addressTB), .out_data(out_dataTB), .clk(clkTB));

    initial begin 
        clkTB = 0;
    end

    always begin 
        #50 clkTB = ~clkTB; 
    end

    initial begin
        addressTB = 8'd9;
        @(posedge clkTB);
        addressTB = 8'd1;
        @(posedge clkTB);
        addressTB = 8'd3;
        @(posedge clkTB);
        addressTB = 8'd5;
        @(posedge clkTB);
        addressTB = 8'd7;
        @(posedge clkTB);
        @(posedge clkTB);
        $stop;
    end

endmodule