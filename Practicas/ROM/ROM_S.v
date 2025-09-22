//1.- Definicion de modulo
module ROM_S (address, out_data, clk);
    input [7:0]address;
    input clk;
    output reg [7:0]out_data;

//2.-Componentes del modulo
    reg [7:0] ROM_S [0:10];

//3.- Cuerpo del modulo
    initial begin
        ROM_S[0] = 8'd90;
        ROM_S[1] = 8'd80;
        ROM_S[2] = 8'd70;
        ROM_S[3] = 8'd60;
        ROM_S[4] = 8'd50;
        ROM_S[5] = 8'd40;
        ROM_S[6] = 8'd30;
        ROM_S[7] = 8'd20;
        ROM_S[8] = 8'd10;
        ROM_S[9] = 8'd100;
        ROM_S[10] = 8'd101;
    end
    
    always @(posedge clk) begin
        out_data = ROM_S[address];    
    end


endmodule
