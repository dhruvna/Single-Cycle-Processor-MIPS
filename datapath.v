// ucsbece154a_datapath.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement datapath
module ucsbece154a_datapath (
    input               clk, reset,
    input               RegWrite_i,
    input               RegDst_i,
    input               ALUSrc_i,
    input               Branch_i,
    input               MemToReg_i,
    input         [2:0] ALUControl_i,
    input               Jump_i,
    input               BranchZero_i, // to be used with BNE: helps us determine pcsrc
    input               ZeroExtImm_i, // to be used with ORI: I-type, sign extends immediate
    output reg   [31:0] pc_o,
    input        [31:0] instr_i,
    output wire  [31:0] aluout_o, writedata_o,
    input        [31:0] readdata_i
);

`include "ucsbece154a_defines.vh"

wire pc_src, alu_zero;
wire [4:0] write_reg;

wire[31:0] pc_next, pc_branch, pc_jump;
wire[31:0] result, rd1, rd2, alusrc_b, imm_ext;

assign pc_src = Branch_i && (alu_zero != BranchZero_i); //uses branchzero to determine the value of pcsrc, branchzero comes into play with bne
assign imm_ext = ZeroExtImm_i ? {16'b0,instr_i[15:0]} : {{16{instr_i[15]}},instr_i[15:0]}; // if ZeroExtImm_i is 1, last 15 bits of instruction are zero extended. otherwise sign extended (used with ori)

assign pc_jump = {pc_o[31:28], instr_i[25:0], 2'b0}; // jump address is calculated by concatenating the upper 4 bits of pc with the lower 26 bits of the instruction
assign pc_branch = (pc_o + 4) + (imm_ext << 2); // branch address is calculated by adding 4 to the pc and shifting the immediate left by 2
assign pc_next = Jump_i ? pc_jump : (pc_src ? pc_branch : (pc_o + 4)); //if Jump is high, pc_next is pc_jump, else if pc_src is high, pc_next is pc_branch, else pc_next is pc + 4
assign result = MemToReg_i ? readdata_i : aluout_o; // if MemToReg_i is high, result is readdata_i, else result is aluout_o

always @(posedge clk) begin //pc_o is updated on the rising edge
    if (reset) pc_o <= 0;
    else pc_o <= pc_next;
end

ucsbece154a_rf rf (
    .clk(clk), 
    .a1_i(instr_i[25:21]), .a2_i(instr_i[20:16]), .a3_i(write_reg),  
    .rd1_o(rd1), .rd2_o(rd2),
    .we3_i(RegWrite_i),
    .wd3_i(result)
);

ucsbece154a_alu alu (
    .a_i(rd1), .b_i(alusrc_b),
    .f_i(ALUControl_i), 
    .y_o(aluout_o),
    .zero_o(alu_zero)
);

assign writedata_o = rd2; 
assign write_reg = RegDst_i ? instr_i[15:11] : instr_i[20:16]; // if RegDst_i is high, write_reg is instr_i[15:11], else write_reg is instr_i[20:16]
assign alusrc_b = ALUSrc_i ? imm_ext: rd2; // if ALUSrc_i is high, alusrc_b is imm_ext, else alusrc_b is rd2

endmodule
