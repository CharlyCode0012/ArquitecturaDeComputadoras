`timescale 1ns/1ns
module ALU_BR_TB();
    reg [23:0]instr[0:10];
    integer i;

    reg [4:0] AR1_TB, AR2_TB, AW_TB;
    reg [7:0] ALU_SelTB;
    reg EN_WTB;

    initial $readmemb("instruccionesALU.txt", instr);

    ALU_BR DUV(.AR1(AR1_TB), .AR2(AR2_TB), .AW(AW_TB), 
            .ALU_Sel(ALU_SelTB), .EN_W(EN_WTB));

    initial begin
        AR1_TB = 0; 
        AR2_TB = 0;
        AW_TB = 0;
        ALU_SelTB = 0;
        EN_WTB = 0;

        for(i = 0; i < 11; i = i + 1) begin
            AR1_TB = instr[i][23:19];
            AR2_TB = instr[i][18:14];
            AW_TB = instr[i][13:9];
            ALU_SelTB = instr[i][8:1];
            EN_WTB = instr[i][0];

            #10;
        end

        #100;
        $stop;
    end
endmodule   