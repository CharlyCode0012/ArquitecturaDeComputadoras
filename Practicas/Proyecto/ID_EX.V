// ID_EX.v

module ID_EX(
    input         clk,
    input         reset,
    input         flush,

    input  [31:0] PC_add4_in,
    input  [31:0] RD1_in,
    input  [31:0] RD2_in,
    input  [31:0] SignImm_in,
    input  [4:0]  rs_in,
    input  [4:0]  rt_in,
    input  [4:0]  rd_in,
    input  [5:0]  funct_in,

    input         RegDst_in,
    input         Branch_in,
    input         MemRead_in,
    input         MemWrite_in,
    input         MemtoReg_in,
    input         ALUSrc_in,
    input         RegWrite_in,
    input  [1:0]  ALUOp_in,

    output reg [31:0] PC_add4_out,
    output reg [31:0] RD1_out,
    output reg [31:0] RD2_out,
    output reg [31:0] SignImm_out,
    output reg [4:0]  rs_out,
    output reg [4:0]  rt_out,
    output reg [4:0]  rd_out,
    output reg [5:0]  funct_out,

    output reg        RegDst_out,
    output reg        Branch_out,
    output reg        MemRead_out,
    output reg        MemWrite_out,
    output reg        MemtoReg_out,
    output reg        ALUSrc_out,
    output reg        RegWrite_out,
    output reg [1:0]  ALUOp_out
);
    always @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            PC_add4_out <= 32'd0;
            RD1_out      <= 32'd0;
            RD2_out      <= 32'd0;
            SignImm_out  <= 32'd0;
            rs_out       <= 5'd0;
            rt_out       <= 5'd0;
            rd_out       <= 5'd0;
            funct_out    <= 6'd0;

            RegDst_out   <= 1'b0;
            Branch_out   <= 1'b0;
            MemRead_out  <= 1'b0;
            MemWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            ALUSrc_out   <= 1'b0;
            RegWrite_out <= 1'b0;
            ALUOp_out    <= 2'b00;
        end else begin
            PC_add4_out <= PC_add4_in;
            RD1_out      <= RD1_in;
            RD2_out      <= RD2_in;
            SignImm_out  <= SignImm_in;
            rs_out       <= rs_in;
            rt_out       <= rt_in;
            rd_out       <= rd_in;
            funct_out    <= funct_in;

            RegDst_out   <= RegDst_in;
            Branch_out   <= Branch_in;
            MemRead_out  <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemtoReg_out <= MemtoReg_in;
            ALUSrc_out   <= ALUSrc_in;
            RegWrite_out <= RegWrite_in;
            ALUOp_out    <= ALUOp_in;
        end
    end
endmodule
