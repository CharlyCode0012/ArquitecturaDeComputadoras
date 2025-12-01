//=====================
// EX_MEM.v
//=====================
module EX_MEM(
    input         clk,
    input         reset,

    input  [31:0] PCBranch_in,
    input         Zero_in,
    input  [31:0] ALUResult_in,
    input  [31:0] RD2_in,
    input  [4:0]  WriteReg_in,

    input         Branch_in,
    input         MemRead_in,
    input         MemWrite_in,
    input         MemtoReg_in,
    input         RegWrite_in,

    output reg [31:0] PCBranch_out,
    output reg        Zero_out,
    output reg [31:0] ALUResult_out,
    output reg [31:0] RD2_out,
    output reg [4:0]  WriteReg_out,

    output reg        Branch_out,
    output reg        MemRead_out,
    output reg        MemWrite_out,
    output reg        MemtoReg_out,
    output reg        RegWrite_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PCBranch_out <= 32'd0;
            Zero_out     <= 1'b0;
            ALUResult_out<= 32'd0;
            RD2_out      <= 32'd0;
            WriteReg_out <= 5'd0;
            Branch_out   <= 1'b0;
            MemRead_out  <= 1'b0;
            MemWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            RegWrite_out <= 1'b0;
        end else begin
            PCBranch_out <= PCBranch_in;
            Zero_out     <= Zero_in;
            ALUResult_out<= ALUResult_in;
            RD2_out      <= RD2_in;
            WriteReg_out <= WriteReg_in;
            Branch_out   <= Branch_in;
            MemRead_out  <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
        end
    end
endmodule
