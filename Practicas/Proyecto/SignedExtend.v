
// SignExtend.v

module SignExtend(
    input  [15:0] data16,
    output [31:0] data32
);
    assign data32 = {{16{data16[15]}}, data16};
endmodule
