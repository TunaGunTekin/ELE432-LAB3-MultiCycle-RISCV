`timescale 1ns/1ps

module top (
    input  logic        clk,
    input  logic        reset,
    output logic [31:0] WriteData,
    output logic [31:0] DataAdr,
    output logic        MemWrite
);

    logic [31:0] Instr, ReadData;
    
    riscvsingle rv_core (
        .clk(clk),
        .reset(reset),
        .Adr(DataAdr),
        .MemWrite(MemWrite),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );
    
    memoryID memory_inst (
        .clk(clk),
        .we(MemWrite),
        .a(DataAdr),
        .wd(WriteData),
        .rd(ReadData)
    );

endmodule