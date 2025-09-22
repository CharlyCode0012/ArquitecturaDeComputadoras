//1.- Definicion de modulo
module SRAM_S (address, out_data, in_data, clk, EN);
    input [7:0]address;
    input [7:0]in_data;
    input clk;
    input EN;
    output reg [7:0]out_data;

//2.-Componentes del modulo
    reg [7:0] RAM_S [0:10];

//3.- Cuerpo del modulo
    initial begin
        RAM_S[0] = 8'd90;
        RAM_S[1] = 8'd80;
        RAM_S[2] = 8'd70;
        RAM_S[3] = 8'd60;
        RAM_S[4] = 8'd50;
        RAM_S[5] = 8'd40;
        RAM_S[6] = 8'd30;
        RAM_S[7] = 8'd20;
        RAM_S[8] = 8'd10;
        RAM_S[9] = 8'd100;
        RAM_S[10] = 8'd101;
    end
    
    always @(posedge clk) begin
        if(EN)begin
            RAM_S[address] = in_data;
        end
        else
            out_data = RAM_S[address];    
        
    end


endmodule
