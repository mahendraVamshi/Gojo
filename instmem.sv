module instmem(
  input clk,         // Clock input
  input [31:0] addr, // Address input
  output reg [31:0] instruction // Instruction output
);

  // Define memory array with 1024 (2^10) 32-bit words
  reg [31:0] mem [1023:0];

  // Initialize memory contents with example instructions
  initial begin
    mem[0] = 32'h00200820; // Add $1, $0, $0
    mem[1] = 32'h8c0a0000; // LW $10, 0($8)
    mem[2] = 32'hac080000; // SW $8, 0($16)
    mem[3] = 32'h00441020; // Add $2, $2, $4
    mem[4] = 32'h00641822; // Sub $3, $3, $4
    mem[5] = 32'h00c43024; // And $6, $6, $4
    mem[6] = 32'h00a43825; // Or $7, $7, $4
    mem[7] = 32'h00044040; // Sll $8, $8, 1
    mem[8] = 32'h00044842; // Srl $9, $9, 1
    mem[9] = 32'h8c090004; // LW $9, 4($8)
    mem[10] = 32'hac080008; // SW $8, 8($16)
    mem[11] = 32'h20220001; // Addi $2, $2, 1
    mem[12] = 32'h244300ff; // Addiu $3, $2, -1
    mem[13] = 32'h30240003; // Andi $4, $1, 3
    mem[14] = 32'h3445ffff; // Ori $5, $2, -1
    mem[15] = 32'h3c060001; // Lui $6, 1
    mem[16] = 32'h08000001; // J 0x00000004
    mem[17] = 32'h10000001; // B 0x00000004
    mem[18] = 32'h14000001; // Bne $2, $0, 0x00000004
    mem[19] = 32'h18000001; // Beq $3, $0, 0x00000004
    mem[20] = 32'h23a50001; // Addi $5, $21, 1
    mem[21] = 32'h00351023; // Sub $2, $0, $21
    mem[22] = 32'h2b451001; // Slti $5, $21, 16
    mem[23] = 32'h37a50001; // Lui $5, 1
  end

  // Read instruction from memory on positive edge of clock
  always @(posedge clk) begin
    instruction <= mem[addr[9:2]];
  end

endmodule