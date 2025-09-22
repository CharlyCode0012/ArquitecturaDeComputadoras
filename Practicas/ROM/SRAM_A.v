//1.- Definicion de modulo
module SRAM_A (address, out_data, in_data, EN);
    input [7:0]address;
    input [7:0]in_data;
    input EN;
    output reg [7:0]out_data;

//2.-Componentes del modulo
    reg [7:0] RAM [0:10];

//3.- Cuerpo del modulo
    initial begin
        RAM[0] = 8'd90;
        RAM[1] = 8'd80;
        RAM[2] = 8'd70;
        RAM[3] = 8'd60;
        RAM[4] = 8'd50;
        RAM[5] = 8'd40;
        RAM[6] = 8'd30;
        RAM[7] = 8'd20;
        RAM[8] = 8'd10;
        RAM[9] = 8'd100;
        RAM[10] = 8'd101;
    end
    
    always @* begin
        if(EN)begin
            RAM[address] = in_data;
        end
        else begin
            out_data = RAM[address];    
        end

    end


endmodule
