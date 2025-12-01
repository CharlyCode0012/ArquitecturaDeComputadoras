// Mux2.v
module Mux2 (
    input  [31:0] data1,
    input  [31:0] data2,
    input  sel,
    output [31:0] result
);
    assign result = (sel) ? data2 : data1;
endmodule
