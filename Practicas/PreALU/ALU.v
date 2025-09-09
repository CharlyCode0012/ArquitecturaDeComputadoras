
module _preALU(input [3:0]A, input [3:0]B, input [2:0]sel, output reg [3:0]C);

    always @* begin

        case (sel)
        3'd0: begin
            C = A + B;
        end
        3'd1:begin
            C = A & B;
        end
        default: begin
        
        end
        endcase

    end

endmodule