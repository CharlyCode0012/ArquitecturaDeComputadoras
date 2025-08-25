`timescale 1ns/1ns

module _and_TB();

reg A_tb, B_tb;
wire S_tb, AS_tb; 

HA DUV(.A(A_tb), .B(B_tb), .S(S_tb), .AS(AS_tb));
//INITIAL ES PARA COMENZAR A VALIDAR DIFERENTES

initial 

begin

    A_tb=0;
    B_tb=0;
    #100;
    A_tb=1;
    B_tb=0;
    #100;
    A_tb=0;
    B_tb=1;
    #100;
    A_tb=1;
    B_tb=1;
    #100;
    $stop;
   
end

endmodule
//wire palabra reservada para cable
//bench banca(pa sentarse_testbench)
//EL QUE QUE ESTE AL LADO DELPUNTO ES CON QUIEN SE VA A CONECTAR