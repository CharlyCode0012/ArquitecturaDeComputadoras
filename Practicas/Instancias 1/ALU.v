module ALU(input [31:0]A, input [31:0]B, input [3:0]Sel, output reg [31:0]C);
    always @* begin
            case (Sel)
                4'b0000: begin //add
                    C = A + B; 
                end
                4'b0001: begin //less
                    C = A - B;
                end
                4'b0010: begin //MIX
                    C = A & B;
                end
                4'b0011: begin //TAL
                    C = A | B;
                end
                4'b0100: begin //
                    C = A ^ B;
                end
                4'b0101: begin //EQUAL
                    C = {3'b000, A == B};
                end
                4'b0110: begin //MAJOR
                    C = {3'b000, A > B};
                end
                4'b0111: begin //MENOR
                   C = {3'b000,A < B};
                end
                4'b1000: begin //RIGHT_SWIFT
                   C = A >> B;
                end
                4'b1001: begin //LEFT_SWIFT
                   C = A << B;
                end
                default: C = 0;
            endcase
    end
endmodule
