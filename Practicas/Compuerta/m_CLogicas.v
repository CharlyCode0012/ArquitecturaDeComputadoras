`include "_and.v"

module m_CLogicas(input A, input B, output o_yes_A, o_yes_B, o_not_A, o_not_B, o_and, o_nand, o_or, o_nor, o_xor, o_xnor);

assign o_yes_A = A;
assign o_yes_B = B;
assign o_not_A = ~A;
assign o_not_B = ~B;
assign o_and = (A & B);
assign o_nand = ~(A & B);
assign o_or = (A | B);
assign o_nor = ~(A | B);
assign o_xor = (A ^ B);
assign o_xnor = ~(A ^ B);

endmodule

