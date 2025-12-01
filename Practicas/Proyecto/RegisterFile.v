// RegisterFile.v

module RegisterFile(
    input        clk,
    input        RegWrite,
    input  [4:0] rs,
    input  [4:0] rt,
    input  [4:0] rd,
    input  [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
);
    reg [31:0] RF [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i+1)
            RF[i] = 32'd0;
    end

    assign RD1 = (rs != 0) ? RF[rs] : 32'd0;
    assign RD2 = (rt != 0) ? RF[rt] : 32'd0;

    always @(posedge clk) begin
        if (RegWrite && (rd != 0))
            RF[rd] <= WD;
    end
endmodule
