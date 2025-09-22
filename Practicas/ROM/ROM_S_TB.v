`timescale 1ns/1ns

module ROM_S_TB();
    reg [7:0] addressTB;
    wire [7:0] out_dataTB;
    reg clkTB;

    ROM_S DUV(.address(addressTB), .out_data(out_dataTB), .clk(clkTB));

    initial clkTB = 0;
    always #5 clkTB = ~clkTB;

    initial begin
        addressTB = 9;
        @(posedge clkTB);
        addressTB = 1;
        @(posedge clkTB);
        addressTB = 3;
        @(posedge clkTB);
        addressTB = 5;
        @(posedge clkTB);
        addressTB = 7;
        @(posedge clkTB);
        $stop;
    end

endmodule