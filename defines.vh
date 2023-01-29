// ucsbece154a_defines.vh
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// ALU Op Codes
localparam    [2:0] ALUOp_and = 3'b000;
localparam    [2:0] ALUOp_or  = 3'b001;
localparam    [2:0] ALUOp_add = 3'b010;
localparam    [2:0] ALUOp_sub = 3'b110;
localparam    [2:0] ALUOp_slt = 3'b111;


// RegDst
localparam          RegDst_Itype = 1'b0;
localparam          RegDst_Rtype = 1'b1;


// ALU Src
localparam          ALUSrc_reg = 1'b0;
localparam          ALUSrc_imm = 1'b1;


// Instruction Op/Funct Codes
localparam    [5:0] instr_add_funct = 6'h20;
localparam    [5:0] instr_sub_funct = 6'h22;
localparam    [5:0] instr_and_funct = 6'h24;
localparam    [5:0] instr_or_funct = 6'h25;
localparam    [5:0] instr_slt_funct = 6'h2a;

localparam    [5:0] instr_Rtype_op = 6'h00;
localparam    [5:0] instr_j_op = 6'h02;
localparam    [5:0] instr_beq_op = 6'h04;
localparam    [5:0] instr_bne_op = 6'h05;
localparam    [5:0] instr_addi_op = 6'h08;
localparam    [5:0] instr_ori_op = 6'h0d;
localparam    [5:0] instr_lw_op = 6'h23;
localparam    [5:0] instr_sw_op = 6'h2b;
