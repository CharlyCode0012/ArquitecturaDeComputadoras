module ALU(input [31:0]A, input [31:0]B, input [7:0]Sel, output reg [31:0]C);
    always @* begin
            case (Sel)
                8'b0000: begin
                    C = A + B; 
                end
                8'b0001: begin
                    C = A - B;
                end
                8'b0010: begin
                    C = A & B;
                end
                8'b0011: begin
                    C = A | B;
                end
                8'b0100: begin
                    C = A ^ B;
                end
                8'b0101: begin
                    C = {7'b000, A == B};
                end
                8'b0110: begin
                    C = {7'b000, A > B};
                end
                8'b0111: begin
                   C = {7'b000,A < B};
                end
                8'b1000: begin
                   C = A >> B;
                end
                8'b1001: begin
                   C = A << B;
                end
                default: C = 0;
            endcase
    end
endmodule
