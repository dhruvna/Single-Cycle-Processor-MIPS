// ucsbece154a_rf.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement Register File
module ucsbece154a_rf (
    input               clk,
    input         [4:0] a1_i, a2_i, a3_i,
    output wire  [31:0] rd1_o, rd2_o,
    input               we3_i,
    input        [31:0] wd3_i
);

reg [31:0] registers[31:0]; // Array of 32 registers of 32 bits each

always @ * begin
    registers[0] = 32'b0; // Register 0 is always 0
end

always @ (posedge clk) begin // on rising edge
    if(we3_i && a3_i !=0) //  If write enable 3 is high
        registers[a3_i] <= wd3_i; // Writes the value of wd3 to register a3  
end
assign rd1_o = (a1_i != 0) ? registers[a1_i] : 0; //Assign Read Data RD1 to the value of address input A1
assign rd2_o = (a2_i != 0) ? registers[a2_i] : 0; //Assign Read Data RD2 to the value of address input A2

`ifdef SIM
// **FILL DEBUG SIGNALS HERE**
wire [31:0] zero = registers[0];
wire [31:0] at = registers[1];
wire [31:0] v0 = registers[2];
wire [31:0] v1 = registers[3];
wire [31:0] a0 = registers[4];
wire [31:0] a1 = registers[5];
wire [31:0] a2 = registers[6];
wire [31:0] a3 = registers[7];
wire [31:0] t0 = registers[8];
wire [31:0] t1 = registers[9];
wire [31:0] t2 = registers[10];
wire [31:0] t3 = registers[11];
wire [31:0] t4 = registers[12];
wire [31:0] t5 = registers[13];
wire [31:0] t6 = registers[14];
wire [31:0] t7 = registers[15];
wire [31:0] s0 = registers[16];
wire [31:0] s1 = registers[17];
wire [31:0] s2 = registers[18];
wire [31:0] s3 = registers[19];
wire [31:0] s4 = registers[20];
wire [31:0] s5 = registers[21];
wire [31:0] s6 = registers[22];
wire [31:0] s7 = registers[23];
wire [31:0] t8 = registers[24];
wire [31:0] t9 = registers[25];
wire [31:0] k0 = registers[26];
wire [31:0] k1 = registers[27];
wire [31:0] gp = registers[28];
wire [31:0] sp = registers[29];
wire [31:0] fp = registers[30];
wire [31:0] ra = registers[31];
`endif

endmodule
