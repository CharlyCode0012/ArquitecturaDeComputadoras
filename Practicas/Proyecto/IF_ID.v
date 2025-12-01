// IF_ID.v

module IF_ID(
    input         clk,
    input         reset,
    input         flush,
    input  [31:0] PC_add4_in,
    input  [31:0] Instr_in,
    output reg [31:0] PC_add4_out,
    output reg [31:0] Instr_out
);
    always @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            PC_add4_out <= 32'd0;
            Instr_out    <= 32'd0;
        end else begin
            PC_add4_out <= PC_add4_in;
            Instr_out    <= Instr_in;
        end
    end
endmodule
