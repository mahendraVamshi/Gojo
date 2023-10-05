module Control(
    input [6:0] opcode,
    output reg [3:0] alu_op,
    output reg reg_write_enable,
    output reg mem_write_enable,
    output reg mem_read_enable,mem2reg,
    output reg branch,
    output reg jump,
	 output reg alu_src
);

always @(*) begin
    case (opcode)
        // R-type instructions
        7'b0110011: begin // add, and, or, sll, slt, sra, srl, sub, xor
            alu_op = 4'b0010;
            reg_write_enable = 1'b1;
        end
        
        // I-type instructions
        7'b0010011: begin // addi, andi, ori,slli,srli,slai
				reg_write_enable = 1'b1;
				
        end
		  // load inst 
		  7'b0000011: begin
				reg_write_enable = 1'b1;
				mem_read_enable = 1'b1;
        end
        // S-type instructions
        7'b0100011: begin // sb, sh, sw
            mem_write_enable = 1'b0;
        end
        
        // B-type instructions
        7'b1100011: begin // beq, bne, blt, bge,bltu ,bgeu
            branch = 1'b0;
        end
        
        // U-type instructions
        7'b0010111: begin // auipc
            alu_op = 4'b0001;
            reg_write_enable = 1'b1;
        end
        
        7'b0110111: begin // lui
            alu_op = 4'b0001;
            reg_write_enable = 1'b1;
				mem2reg = 1'b1;
        end
        
        // J-type instructions
        7'b1101111: begin // jal
            jump = 1'b1;
            reg_write_enable = 1'b1;
        end
		  7'b1100111: begin 
				jump = 1'b1;
				reg_write_enable = 1'b1;
			end
    endcase
end

endmodule