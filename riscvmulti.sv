`timescale 1ns/1ps

module riscvsingle(input logic clk, reset,
                    output logic [31:0] Adr,
                    output logic MemWrite,
                    output logic [31:0] WriteData,
                    input logic [31:0] ReadData);

logic AdrSrc, RegWrite, IRWrite,PCWrite, Zero;
logic [31:0] Instr;
logic [1:0] ResultSrc, ImmSrc,ALUSrcA, ALUSrcB;
logic [2:0] ALUControl;
controller c(clk, reset, Instr[6:0], Instr[14:12], Instr[30], Zero, ImmSrc, ALUSrcA, ALUSrcB, ResultSrc,AdrSrc, ALUControl, IRWrite, PCWrite, RegWrite, MemWrite);
datapath dp(clk, reset, ImmSrc, ResultSrc, ALUSrcA, ALUSrcB, AdrSrc, PCWrite, IRWrite, RegWrite, ALUControl,ReadData, Adr,Instr, Zero, WriteData);


endmodule
