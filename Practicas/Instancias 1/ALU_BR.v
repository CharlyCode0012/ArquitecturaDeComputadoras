//1.- DEFINICION DE MODULO
module  ALU_BR(AR1, AR2, AW, ALU_Sel, EN_W);
    input [4:0]AR1;
    input [4:0]AR2;
    input [4:0]AW;
    input [8:0] ALU_Sel;
    input EN_W;
    
    wire [31:0]DataR1_C;
    wire [31:0]DataR2_C;
    wire [31:0]Result_C;

    //2.- Componentes del modulo

    ALU alu(.A(DataR1_C), .B(DataR2_C), .Sel(ALU_Sel), .C(Result_C));

    BankRegister BankR(.RR1(AR1), .RR2(AR2), .WR(AW), .WD(Result_C), 
                       .RegW(EN_W), .RD1(DataR1_C), .RD2(DataR2_C));

    //3.- Cuerpo del modulo (inicializacion de contenido)

    //4.- Implementacion del modulo   
endmodule

/*
    
    5 + 5 + 5 + 8 + 1 = 21 bits 

    AR1 | AR2 | WR | ALU_Sel | EN_W
*/
