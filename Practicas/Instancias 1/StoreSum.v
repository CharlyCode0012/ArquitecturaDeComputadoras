
//1.- Definicion del modulo
module StoreSum (AR1, AR2, AW);
    input [4:0]AR1;
    input [4:0]AR2;
    input [4:0]AW;

    //2.- Componentes internos del modulo
    wire [31:0] DataR1_C;
    wire [31:0] DataR2_C;
    wire [31:0] Result_C;

    ADD add(.A(DataR1_C), .B(DataR2_C), .C(Result_C));

    BankRegister BR(.RR1(AR1), .RR2(AR2), .WR(AW), .WD(Result_C), 
                    .RegW(1), .RD1(DataR1_C), .RD2(DataR2_C));
    
    //3.- Cuerpo del modulo

    //4-. Implementacion

endmodule


//instruccion es la suma total de todos los bits.
/**
    AR1 -> 5
    AR2 -> 5
    AW  -> 5
    5 + 5 + 5 = 15.
    
    Por ende podemos tener un registro de 15 bits [14:0]
    por lo que cada 5 bits representa algo.

**/