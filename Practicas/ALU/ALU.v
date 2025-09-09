module ALU(input [3:0]A, input [3:0]B, input [3:0]sel, output reg [3:0]C);
    always @* begin
            case (sel)
                4'b0000: begin
                    C = A + B; 
                end
                4'b0001: begin
                    C = A - B;
                end
                4'b0010: begin
                    C = A & B;
                end
                4'b0011: begin
                    C = A | B;
                end
                4'b0100: begin
                    C = A ^ B;
                end
                4'b0101: begin
                    C = {3'b000, A == B};
                end
                4'b0110: begin
                    C = {3'b000, A > B};
                end
                4'b0111: begin
                   C = {3'b000,A < B};
                end
                4'b1000: begin
                   C = A >> B;
                end
                4'b1001: begin
                   C = A << B;
                end
                default: C = 4'b0000;
            endcase
    end
endmodule
