// DataMemory.v

module DataMemory(
    input         clk,
    input         MemRead,
    input         MemWrite,
    input  [31:0] Address,
    input  [31:0] WriteData,
    output reg [31:0] ReadData
);
    reg [31:0] MEM [0:255];

    initial begin
        $readmemb("data_memory.txt", MEM);
    end

    always @* begin
        if (MemRead)
            ReadData = MEM[Address[9:2]];
        else
            ReadData = 32'd0;
    end

    always @(posedge clk) begin
        if (MemWrite)
            MEM[Address[9:2]] <= WriteData;
    end
endmodule
