`timescale 1ns/1ns

module StoreSum_TB();
    //reg [4:0]AR1_TB, AR2_TB, AW_TB;

    //StoreSum DUV(.AR1(AR1_TB), .AR2(AR2_TB), .AW(AW_TB));

    //reg [14:0] instr;
    reg [14:0] instr;

    initial $readmemb("instrucciones.txt", instr);

    StoreSum DUV(.AR1(instr[14:10]), .AR2(instr[9:5]), .AW(instr[4:0]));



    initial begin
        //instr = 14'b00001_00011_10101;
        #100;
        $stop;  
    end

endmodule