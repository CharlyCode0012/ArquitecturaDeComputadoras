// CPU MIPS32 Pipeline

module MIPS32(
    input clk,
    input reset
);
    // IF STAGE
  
    wire [31:0] PC_current, PC_next, PC_add4;
    wire [31:0] Instr_IF;

    wire        branch_taken;
    wire [31:0] PCBranch_EXMEM;

    // PC
    PC pc0(
        .clk(clk),
        .reset(reset),
        .En(1'b1),
        .PC_in(PC_next),
        .PC_out(PC_current)
    );

    // PC + 4
    assign PC_add4 = PC_current + 32'd4;

    // Instruction Memory
    InstructionMemory imem0(
        .addr(PC_current),
        .instr(Instr_IF)
    );

    // Mux PCSrc (PC+4 vs PCBranch)
    Mux2 mux_pc_src(
        .data1(PC_add4),
        .data2(PCBranch_EXMEM),
        .sel(branch_taken),
        .result(PC_next)
    );

    // IF/ID pipeline reg
    wire [31:0] PC_add4_ID;
    wire [31:0] Instr_ID;

    IF_ID if_id0(
        .clk(clk),
        .reset(reset),
        .flush(branch_taken),   // limpiamos si branch tomado
        .PC_add4_in(PC_add4),
        .Instr_in(Instr_IF),
        .PC_add4_out(PC_add4_ID),
        .Instr_out(Instr_ID)
    );

    // ID STAGE

    wire [5:0] opcode_ID = Instr_ID[31:26];
    wire [4:0] rs_ID     = Instr_ID[25:21];
    wire [4:0] rt_ID     = Instr_ID[20:16];
    wire [4:0] rd_ID     = Instr_ID[15:11];
    wire [15:0] data16_ID = Instr_ID[15:0];
    wire [5:0] funct_ID  = Instr_ID[5:0];

    // Control principal
    wire RegDst_ID, Branch_ID, MemRead_ID, MemtoReg_ID;
    wire MemWrite_ID, ALUSrc_ID, RegWrite_ID;
    wire [1:0] ALUOp_ID;

    ControlUnit control0(
        .opcode(opcode_ID),
        .RegDst(RegDst_ID),
        .Branch(Branch_ID),
        .MemRead(MemRead_ID),
        .MemtoReg(MemtoReg_ID),
        .ALUOp(ALUOp_ID),
        .MemWrite(MemWrite_ID),
        .ALUSrc(ALUSrc_ID),
        .RegWrite(RegWrite_ID)
    );

    // Register File
    wire [31:0] RD1_ID, RD2_ID;
    wire [4:0]  WriteReg_WB;
    wire [31:0] WriteData_WB;
    wire        RegWrite_WB;

    RegisterFile rf0(
        .clk(clk),
        .RegWrite(RegWrite_WB),
        .rs(rs_ID),
        .rt(rt_ID),
        .rd(WriteReg_WB),
        .WD(WriteData_WB),
        .RD1(RD1_ID),
        .RD2(RD2_ID)
    );

    // Sign-extend
    wire [31:0] SignData_Extended;
    SignExtend se0(
        .data16(data16_ID),
        .data32(SignData_Extended)
    );

    // ID/EX pipeline reg
    wire [31:0] PC_add4_EX, RD1_EX, RD2_EX, SignImm_EX;
    wire [4:0]  rs_EX, rt_EX, rd_EX;
    wire [5:0]  funct_EX;
    wire        RegDst_EX, Branch_EX, MemRead_EX, MemWrite_EX;
    wire        MemtoReg_EX, ALUSrc_EX, RegWrite_EX;
    wire [1:0]  ALUOp_EX;

    ID_EX id_ex0(
        .clk(clk),
        .reset(reset),
        .flush(1'b0),             // sin unidad de riesgos
        .PC_add4_in(PC_add4_ID),
        .RD1_in(RD1_ID),
        .RD2_in(RD2_ID),
        .SignImm_in(SignData_Extended),
        .rs_in(rs_ID),
        .rt_in(rt_ID),
        .rd_in(rd_ID),
        .funct_in(funct_ID),
        .RegDst_in(RegDst_ID),
        .Branch_in(Branch_ID),
        .MemRead_in(MemRead_ID),
        .MemWrite_in(MemWrite_ID),
        .MemtoReg_in(MemtoReg_ID),
        .ALUSrc_in(ALUSrc_ID),
        .RegWrite_in(RegWrite_ID),
        .ALUOp_in(ALUOp_ID),

        .PC_add4_out(PC_add4_EX),
        .RD1_out(RD1_EX),
        .RD2_out(RD2_EX),
        .SignImm_out(SignImm_EX),
        .rs_out(rs_EX),
        .rt_out(rt_EX),
        .rd_out(rd_EX),
        .funct_out(funct_EX),
        .RegDst_out(RegDst_EX),
        .Branch_out(Branch_EX),
        .MemRead_out(MemRead_EX),
        .MemWrite_out(MemWrite_EX),
        .MemtoReg_out(MemtoReg_EX),
        .ALUSrc_out(ALUSrc_EX),
        .RegWrite_out(RegWrite_EX),
        .ALUOp_out(ALUOp_EX)
    );

    // EX STAGE

    // Mux RegDst (rt vs rd)
    wire [4:0] WriteReg_EX;
    Mux2 mux_RegDst(
        .data1(rt_EX),
        .data2(rd_EX),
        .sel(RegDst_EX),
        .result(WriteReg_EX)
    );

    // ShiftLeft2 para branch
    wire [31:0] SignImmShift_EX;
    ShiftLeft2 sl2_0(
        .in(SignImm_EX),
        .out(SignImmShift_EX)
    );

    // PCBranch = PC+4 + (SignImm << 2)
    wire [31:0] PCBranch_EX = PC_add4_EX + SignImmShift_EX;

    // ALUSrc mux
    wire [31:0] ALU_in2_EX;
    Mux2 mux_ALUSrc(
        .data1(RD2_EX),
        .data2(SignImm_EX),
        .sel(ALUSrc_EX),
        .result(ALU_in2_EX)
    );

    // ALUControl
    wire [3:0] ALUCtrl_EX;
    ALUControl alu_ctrl0(
        .ALUOp(ALUOp_EX),
        .funct(funct_EX),
        .ALUCtrl(ALUCtrl_EX)
    );

    // ALU
    wire [31:0] ALUResult_EX;
    wire        Zero_EX;
    ALU alu0(
        .A(RD1_EX),
        .B(ALU_in2_EX),
        .ALUCtrl(ALUCtrl_EX),
        .Result(ALUResult_EX),
        .Zero(Zero_EX)
    );

    // EX/MEM pipeline reg
    wire [31:0] ALUResult_EXMEM, RD2_EXMEM;
    wire [4:0]  WriteReg_EXMEM;
    wire        Zero_EXMEM;
    wire        Branch_EXMEM, MemRead_EXMEM, MemWrite_EXMEM;
    wire        MemtoReg_EXMEM, RegWrite_EXMEM;

    EX_MEM ex_mem0(
        .clk(clk),
        .reset(reset),
        .PCBranch_in(PCBranch_EX),
        .Zero_in(Zero_EX),
        .ALUResult_in(ALUResult_EX),
        .RD2_in(RD2_EX),
        .WriteReg_in(WriteReg_EX),
        .Branch_in(Branch_EX),
        .MemRead_in(MemRead_EX),
        .MemWrite_in(MemWrite_EX),
        .MemtoReg_in(MemtoReg_EX),
        .RegWrite_in(RegWrite_EX),

        .PCBranch_out(PCBranch_EXMEM),
        .Zero_out(Zero_EXMEM),
        .ALUResult_out(ALUResult_EXMEM),
        .RD2_out(RD2_EXMEM),
        .WriteReg_out(WriteReg_EXMEM),
        .Branch_out(Branch_EXMEM),
        .MemRead_out(MemRead_EXMEM),
        .MemWrite_out(MemWrite_EXMEM),
        .MemtoReg_out(MemtoReg_EXMEM),
        .RegWrite_out(RegWrite_EXMEM)
    );

    assign branch_taken = Branch_EXMEM & Zero_EXMEM;

    // MEM STAGE
    wire [31:0] ReadData_MEM;

    DataMemory dmem0(
        .clk(clk),
        .MemRead(MemRead_EXMEM),
        .MemWrite(MemWrite_EXMEM),
        .Address(ALUResult_EXMEM),
        .WriteData(RD2_EXMEM),
        .ReadData(ReadData_MEM)
    );

    // MEM/WB pipeline reg
    wire [31:0] ReadData_WB, ALUResult_WB;
    wire        MemtoReg_WB;

    MEM_WB mem_wb0(
        .clk(clk),
        .reset(reset),
        .ReadData_in(ReadData_MEM),
        .ALUResult_in(ALUResult_EXMEM),
        .WriteReg_in(WriteReg_EXMEM),
        .MemtoReg_in(MemtoReg_EXMEM),
        .RegWrite_in(RegWrite_EXMEM),

        .ReadData_out(ReadData_WB),
        .ALUResult_out(ALUResult_WB),
        .WriteReg_out(WriteReg_WB),
        .MemtoReg_out(MemtoReg_WB),
        .RegWrite_out(RegWrite_WB)
    );

    // WB STAGE

    // Mux MemtoReg (ALUResult vs ReadData)
    Mux2 mux_MemtoReg(
        .data1(ALUResult_WB),
        .data2(ReadData_WB),
        .sel(MemtoReg_WB),
        .result(WriteData_WB)
    );

endmodule
