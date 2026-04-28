`timescale 1ns/1ps

module datapath (input logic clk, reset,
                input logic [1:0] ImmSrc,
                input logic [1:0] ResultSrc,ALUSrcA, ALUSrcB,
                input logic AdrSrc, PCWrite,IRWrite,
                input logic RegWrite,
                input logic [2:0] ALUControl,
                input logic [31:0] ReadData,
                output logic [31:0] Adr,Instr,
                output logic Zero,
                output logic [31:0] WriteData);

logic [31:0] ALUResult, PC;
logic [31:0] ImmExt,OldPC;
logic [31:0] Data;
logic [31:0] Rd1,Rd2,Rd1_old;
logic [31:0] SrcA, SrcB;
logic [31:0] Result,ALUOut;

// next PC logic
flopenr #(32) pcreg(clk, reset,PCWrite,Result,PC);
mux2 #(32) pcmux(PC, Result, AdrSrc, Adr);
flopr #(32) datareg(clk, reset, ReadData, Data);
flopenr2 #(32) regA(clk, reset,IRWrite,PC,ReadData,OldPC,Instr);
// register file logic
regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, Rd1, Rd2);
flopr2 #(32) rfoutput(clk, reset, Rd1, Rd2, Rd1_old,WriteData);
extend ext(Instr[31:7], ImmSrc, ImmExt);
// ALU logic
mux3 #(32) srcamux(PC, OldPC, Rd1_old, ALUSrcA, SrcA);
mux3 #(32) srcbmux(WriteData, ImmExt, 32'b100, ALUSrcB, SrcB);
alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
flopr #(32) alures(clk, reset, ALUResult, ALUOut);
mux3 #(32) resultmux(ALUOut, Data, ALUResult, ResultSrc, Result);
endmodule