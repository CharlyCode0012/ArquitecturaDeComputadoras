// MEM_WB.v

module MEM_WB(
    input         clk,
    input         reset,

    input  [31:0] ReadData_in,
    input  [31:0] ALUResult_in,
    input  [4:0]  WriteReg_in,
    input         MemtoReg_in,
    input         RegWrite_in,

    output reg [31:0] ReadData_out,
    output reg [31:0] ALUResult_out,
    output reg [4:0]  WriteReg_out,
    output reg        MemtoReg_out,
    output reg        RegWrite_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ReadData_out  <= 32'd0;
            ALUResult_out <= 32'd0;
            WriteReg_out  <= 5'd0;
            MemtoReg_out  <= 1'b0;
            RegWrite_out  <= 1'b0;
        end else begin
            ReadData_out  <= ReadData_in;
            ALUResult_out <= ALUResult_in;
            WriteReg_out  <= WriteReg_in;
            MemtoReg_out  <= MemtoReg_in;
            RegWrite_out  <= RegWrite_in;
        end
    end
endmodule
