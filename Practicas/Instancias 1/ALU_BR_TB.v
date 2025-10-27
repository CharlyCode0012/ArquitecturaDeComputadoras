`timescale 1ns/1ns
module ALU_BR_TB();
    reg [19:0]instr_TB[0:10];
    integer i;

    reg [4:0] AR1_TB, AR2_TB, AW_TB;
    reg [3:0] ALU_SelTB;
    reg EN_WTB;

    initial $readmemb("instr_TBuccionesALU.txt", instr_TB);

    ALU_BR DUV(.instr[19:15](AR1_TB), .instr[14:10](AR2_TB), .instr[9:5](AW_TB), 
            .instr[4:1](ALU_SelTB), .instr[0](EN_WTB));

    initial begin
        #100
        AR1_TB = 0; 
        AR2_TB = 0;
        AW_TB = 0;
        ALU_SelTB = 0;
        EN_WTB = 0;

        for(i = 0; i < 11; i = i + 1) begin
            AR1_TB = instr_TB[i][19:15];
            AR2_TB = instr_TB[i][14:10];
            AW_TB = instr_TB[i][9:5];
            ALU_SelTB = instr_TB[i][4:1];
            EN_WTB = instr_TB[i][0];

            #10;
        end

        #100;
        $stop;
    end
endmodule   