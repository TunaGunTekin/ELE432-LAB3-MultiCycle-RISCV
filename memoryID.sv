`timescale 1ns/1ps

module memoryID(
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] a,
    input  logic [31:0] wd,
    output logic [31:0] rd
);

    logic [31:0] RAM[63:0]; 
    
    initial begin
        $readmemh("riscvtest.txt", RAM); 
    end
    
    assign rd = RAM[a[31:2]]; 
 
    // Yazma işlemi (Senkron)
    always_ff @(posedge clk) begin
        if (we) begin
            RAM[a[31:2]] <= wd;
        end
    end
endmodule