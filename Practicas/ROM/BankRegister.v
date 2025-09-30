module BankRegister(RR1, RR2, WR, WD, RegW, RD1, RD2);
    input [4:0]RR1;
    input [4:0]RR2;
    input [4:0]WR;
    input [31:0]WD;
    input RegW;
    output reg[31:0]RD1;
    output reg[31:0]RD2;

    reg [31:0] BR [0:31];

    initial begin
        $readmemb("datos.txt", BR);
    end


    always @*begin
        if(RegW)begin
            BR[WR] <= WD; 
        end
        RD1 <= BR[RR1];
        RD2 <= BR[RR2];
    end

endmodule