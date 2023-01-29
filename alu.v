// ucsbece154a_alu.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


module ucsbece154a_alu (
    input        [31:0] a_i, b_i,
    input         [2:0] f_i,
    output reg   [31:0] y_o,
    output wire         zero_o
);

`include "ucsbece154a_defines.vh"

// (This design uses 3 adders)
always @ * begin
    case (f_i)
        ALUOp_and: y_o = a_i & b_i;
        ALUOp_or: y_o = a_i | b_i;
        ALUOp_add: y_o = a_i + b_i;
        ALUOp_sub: y_o = a_i - b_i;
        ALUOp_slt: y_o = {31'b0, ($signed(a_i)<$signed(b_i))};
        default: begin
            `ifdef SIM
            $warning("Unsupported ALUOp given: %h", f_i);
            `endif
            y_o = {32{1'bx}};
        end
    endcase
end

assign zero_o = (y_o == 32'b0);


endmodule
