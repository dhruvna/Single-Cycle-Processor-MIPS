// ucsbece154a_dmem.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited

module ucsbece154a_dmem (
    input               clk, we_i,
    input        [31:0] a_i, // address in bytes
    input        [31:0] wd_i, // write data
    output wire  [31:0] rd_o // read data
);
    reg [31:0] RAM [63:0]; // Creates an array of 64 words of 32 bit size
    assign rd_o = RAM[a_i[7:2]]; // Initialize Read Data to being the WORD address
    always @ (posedge clk) // on rising edge
    begin
        if (we_i) // if write enable is high
            RAM[a_i[7:2]] <= wd_i; // /write data to the WORD address 
    end 

endmodule

