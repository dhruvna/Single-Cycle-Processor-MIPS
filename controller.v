// ucsbece154a_controller.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement controller
//  • Replace all `z` values with the correct value in "Large case statement"
//  • Implement BranchZero_o and ZeroExtImm_o
module ucsbece154a_controller (
    input         [5:0] op_i, funct_i,
    output reg          RegWrite_o, RegDst_o,
    output reg          ALUSrc_o,
    output reg          Branch_o, MemWrite_o,
    output reg          MemToReg_o,
    output reg    [2:0] ALUControl_o,
    output reg          Jump_o,
    output reg          BranchZero_o,
    output reg          ZeroExtImm_o
);

`include "ucsbece154a_defines.vh"

always @ * begin
    // Default values
   {
        RegWrite_o,
        RegDst_o,
        ALUSrc_o,
        Branch_o,
        MemWrite_o,
        MemToReg_o,
        ALUControl_o,
        Jump_o,
        BranchZero_o,
        ZeroExtImm_o
    } = {12{1'bx}};

    // Large case statement
    case (op_i)
        instr_Rtype_op: begin
            RegWrite_o = 1'b1;
            RegDst_o = RegDst_Rtype;
            ALUSrc_o = ALUSrc_reg;
            Branch_o = 1'b0;
            MemWrite_o = 1'b0;
            MemToReg_o = 1'b0;
            Jump_o = 1'b0;
            case (funct_i)
                instr_add_funct: ALUControl_o = ALUOp_add;
                instr_sub_funct: ALUControl_o = ALUOp_sub;
                instr_and_funct: ALUControl_o = ALUOp_and;
                instr_or_funct: ALUControl_o = ALUOp_or;
                instr_slt_funct: ALUControl_o = ALUOp_slt;
                default:
                    `ifdef SIM
                    $warning("Unsupported funct given: %h", funct_i);
                    `else
                    ;
                    `endif
            endcase
        end
        instr_j_op: begin
            RegWrite_o = 1'b0;
            Branch_o = 1'bx;
            MemWrite_o = 1'b0;
            Jump_o = 1'b1;
        end
        instr_beq_op: begin
            RegWrite_o = 1'b0;
            ALUSrc_o = ALUSrc_reg;
            Branch_o = 1'b1;
            MemWrite_o = 1'b0;
            ALUControl_o = ALUOp_sub;
            Jump_o = 1'b0;
        end
        instr_bne_op: begin
            RegWrite_o = 1'b0;
            ALUSrc_o = ALUSrc_reg;
            Branch_o = 1'b1;
            MemWrite_o = 1'b0;
            ALUControl_o = ALUOp_sub;
            Jump_o = 1'b0;
            BranchZero_o = 1'b1;
        end
        instr_addi_op: begin
            RegWrite_o = 1'b1;
            RegDst_o = RegDst_Itype;
            ALUSrc_o = ALUSrc_imm;
            Branch_o = 1'b0;
            MemWrite_o = 1'b0;
            MemToReg_o = 1'b0;
            ALUControl_o = ALUOp_add;
            Jump_o = 1'b0;
        end
        instr_ori_op: begin
            RegWrite_o = 1'b1;
            RegDst_o = RegDst_Itype;
            ALUSrc_o = ALUSrc_imm;
            Branch_o = 1'b0;
            MemWrite_o = 1'b0;
            MemToReg_o = 1'b0;
            ALUControl_o = ALUOp_or;
            Jump_o = 1'b0;
            ZeroExtImm_o = 1'b1;
        end
        instr_lw_op: begin
            RegWrite_o = 1'b1;
            RegDst_o = RegDst_Itype;
            ALUSrc_o = ALUSrc_imm;
            Branch_o = 1'b0;
            MemWrite_o = 1'b0;
            MemToReg_o = 1'b1;
            ALUControl_o = ALUOp_add;
            Jump_o = 1'b0;
        end
        instr_sw_op: begin
            RegWrite_o = 1'b0;
            ALUSrc_o = ALUSrc_imm;
            Branch_o = 1'b0;
            MemWrite_o = 1'b1;
            ALUControl_o = ALUOp_add;
            Jump_o = 1'b0;
        end
        default:
            `ifdef SIM
            $warning("Unsupported op given: %h", op_i);
            `else
            ;
            `endif
    endcase
end

endmodule
