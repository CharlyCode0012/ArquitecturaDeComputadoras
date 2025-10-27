//1.- DEFINICION DE MODULO
module  ALU_BR(AR1, AR2, AW, ALU_Sel, EN_W);
    //input [4:0]AR1;
    //input [4:0]AR2;
    //input [4:0]AW;
    //input [3:0] ALU_Sel;
    //input EN_W
    input [19:0]instr;
    
    wire [31:0]DataR1_C;
    wire [31:0]DataR2_C;
    wire [31:0]Result_C;

    //2.- Componentes del modulo

    ALU alu(.A(DataR1_C), .B(DataR2_C), .Sel(instr[4:1]), .C(Result_C));

    BankRegister BankR(.RR1(instr[19:15]), .RR2(instr[14:10]), .WR(instr[9:5]), .WD(Result_C), 
                       .RegW(instr[0]), .RD1(DataR1_C), .RD2(DataR2_C));

    //3.- Cuerpo del modulo (inicializacion de contenido)

    //4.- Implementacion del modulo   
endmodule

/*
    
    5 + 5 + 5 + 8 + 1 = 21 bits 

    AR1 | AR2 | WR | ALU_Sel | EN_W
*/
