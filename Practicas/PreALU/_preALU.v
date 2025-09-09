
module _preALU(input [3:0]A, input [3:0]B, input sel, output reg [3:0]C);

    always @* begin

        case (sel)
        1'b0: begin
            C = A + B;
        end
        1'b1:begin
            C = A & B;
        end
        default: begin
        
        end
        endcase

    end

endmodule