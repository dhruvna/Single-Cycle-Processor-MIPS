// ucsbece154a_mips.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Uncomment BranchZero and ZeroExtImm
module ucsbece154a_mips (
    input               clk, reset,
    output wire  [31:0] pc_o,
    input        [31:0] instr_i,
    output wire         MemWrite_o,
    output wire  [31:0] aluout_o, writedata_o,
    input        [31:0] readdata_i
);

wire MemToReg, Branch, ALUSrc, RegDst, RegWrite, Jump;
wire BranchZero, ZeroExtImm;
wire [2:0] ALUControl;

ucsbece154a_controller c (
    .op_i(instr_i[31:26]), .funct_i(instr_i[5:0]),
    .RegWrite_o(RegWrite), .RegDst_o(RegDst),
    .ALUSrc_o(ALUSrc),
    .Branch_o(Branch), .MemWrite_o(MemWrite_o),
    .MemToReg_o(MemToReg),
    .ALUControl_o(ALUControl),
    .Jump_o(Jump),
    .BranchZero_o(BranchZero),
    .ZeroExtImm_o(ZeroExtImm)
);
ucsbece154a_datapath dp (
    .clk(clk), .reset(reset),
    .RegWrite_i(RegWrite),
    .RegDst_i(RegDst),
    .ALUSrc_i(ALUSrc),
    .Branch_i(Branch),
    .MemToReg_i(MemToReg),
    .ALUControl_i(ALUControl),
    .Jump_i(Jump),
    .BranchZero_i(BranchZero),
    .ZeroExtImm_i(ZeroExtImm),
    .pc_o(pc_o),
    .instr_i(instr_i),
    .aluout_o(aluout_o),
    .writedata_o(writedata_o),
    .readdata_i(readdata_i)
);
endmodule
