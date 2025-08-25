module HA(input A, B, output S, AS);

assign AS= A & B;

assign S =  A ^ B;


endmodule
