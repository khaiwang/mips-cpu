`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/12 16:01:18
// Design Name: 
// Module Name: registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID(input [31:0]instruction, input [31:0]npc, input clk, input en, input clr, output [31:0]instr, output[31:0] PC);
    reg [31:0]instr_reg;
    reg [31:0]PC_reg;
    assign instr = instr_reg;
    assign PC = PC_reg;
    always@(posedge clk)
    begin
        if(en) 
        begin 
            if(~clr)
            begin
                instr_reg <= instruction;
                PC_reg <= npc;
            end
            else
            begin
                instr_reg <= 32'b00000000000000000000000000000000;
                PC_reg <= 32'h00003000;
            end
        end
    end
    initial
    begin
        instr_reg <= 32'b00000000000000000000000000000000;
        PC_reg <= 32'h00003000;
    end
endmodule

module ID_EX(input [31:0]imm_32D, input [31:0]PCD, input [31:0]Rdata1_D, input [31:0]Rdata2_D, input [4:0]WriteregD, input clk, input clr, 
            output [31:0]imm_32E, output [31:0]PCE, output [31:0]Rdata1_E, output [31:0]Rdata2_E, output [4:0]WriteregE);
    reg [31:0] Rdata1_reg;
    reg [31:0] Rdata2_reg;
    reg [4:0] Writereg;
    reg [31:0] PC;
    reg [31:0] imm_32;
    
    assign Rdata1_E = Rdata1_reg;
    assign Rdata2_E = Rdata2_reg;
    assign WriteregE = Writereg;
    assign PCE = PC;
    assign imm_32E = imm_32;
    
    always@(posedge clk)
    begin
        if(clr==0)
        begin
            Rdata1_reg = Rdata1_D;
            Rdata2_reg = Rdata2_D;
            Writereg = WriteregD;
            PC = PCD;
            imm_32 = imm_32D;
        end
        else
        begin
            Rdata1_reg = 32'b00000000000000000000000000000000;
            Rdata2_reg = 32'b00000000000000000000000000000000;
            Writereg = 5'b00000;
            PC = 32'h00003000;
            imm_32 = 32'b00000000000000000000000000000000;
        end
    end
    initial
    begin
        Rdata1_reg = 32'b00000000000000000000000000000000;
        Rdata2_reg = 32'b00000000000000000000000000000000;
        Writereg = 5'b00000;
        PC = 32'h00003000;
        imm_32 = 32'b00000000000000000000000000000000;
    end
endmodule

module ID_EX_control(input hiloD, input [1:0] mdopD, input mdweD, input startD, input fhiloD, input m_or_aluD, input[1:0] lencodeD, input [2:0]dextopD, input alu_out_ctrlD, input [3:0]cmp_opD, input forwardMWritedataD, input [1:0]forwardAD, input [1:0]forwardBD, input clk, input clr, input memreadD, input [1:0] Wdata_ctrl_D, input [5:0]ALU_op_D, input ALU_B_ctrl_D, input gr_regwrite_D, input dm_we_D, input ext_op_D,
                        output hiloE, output [1:0] mdopE, output mdweE, output startE, output fhiloE, output m_or_aluE, output [1:0]lencodeE, output [2:0]dextopE, output alu_out_ctrlE, output [3:0]cmp_opE, output forwardMWritedataE, output [1:0]forwardAE, output [1:0]forwardBE, output memreadE, output [1:0] Wdata_ctrl_E, output [5:0]ALU_op_E, output ALU_B_ctrl_E, output gr_regwrite_E, output dm_we_E, output ext_op_E);
    reg ALU_B_ctrl;
    reg gr_regwrite;
    reg [5:0] ALU_op;
    reg [1:0] Wdata_ctrl;
    reg ext_op; 
    reg dm_we;
    reg memread;
    reg [1:0] forwardA;
    reg [1:0] forwardB;
    reg forwardMWritedata;
    reg [3:0]cmp_op;
    reg alu_out_ctrl;
    reg [1:0]lencode;
    reg [2:0]dextop;
    reg hilo; 
    reg [1:0] mdop; 
    reg mdwe; 
    reg start; 
    reg fhilo; 
    reg m_or_alu; 
    
    assign forwardMWritedataE = forwardMWritedata;
    assign memreadE = memread;
    assign ALU_B_ctrl_E = ALU_B_ctrl;
    assign gr_regwrite_E = gr_regwrite;
    assign ALU_op_E = ALU_op;
    assign Wdata_ctrl_E = Wdata_ctrl;
    assign ext_op_E = ext_op; 
    assign dm_we_E = dm_we;
    assign forwardAE = forwardA;
    assign forwardBE = forwardB;
    assign cmp_opE = cmp_op;
    assign alu_out_ctrlE = alu_out_ctrl;
    assign lencodeE = lencode;
    assign dextopE = dextop;
    assign hiloE = hilo; 
    assign mdopE = mdop; 
    assign mdweE = mdwe; 
    assign startE = start; 
    assign fhiloE = fhilo; 
    assign m_or_aluE = m_or_alu; 
    
    always@(posedge clk)
    begin
        if(clr==0)
        begin
            ALU_B_ctrl = ALU_B_ctrl_D;
            lencode = lencodeD;
            dextop = dextopD;
            gr_regwrite = gr_regwrite_D;
            ALU_op = ALU_op_D;
            Wdata_ctrl = Wdata_ctrl_D;
            ext_op = ext_op_D; 
            dm_we = dm_we_D;
            cmp_op = cmp_opD;
            memread = memreadD;
            forwardA = forwardAD;
            forwardB = forwardBD;
            forwardMWritedata = forwardMWritedataD;
            alu_out_ctrl = alu_out_ctrlD;
            hilo = hiloD; 
            mdop = mdopD; 
            mdwe = mdweD; 
            start = startD; 
            fhilo = fhiloD; 
            m_or_alu = m_or_aluD; 
        end
        else
        begin
            ALU_B_ctrl = 1'b0;
            gr_regwrite = 1'b0;
            ALU_op = 6'b000000;
            Wdata_ctrl = 2'b00;
            ext_op = 1'b0; 
            dm_we = 1'b0;
            memread = 1'b0;
            forwardA = 2'b00;
            forwardB = 2'b00;
            forwardMWritedata = 1'b0;
            cmp_op = 4'b0000;
            lencode = 2'b00;
            dextop = 3'b000;
            hilo = 1'b0; 
            mdop = 2'b00; 
            mdwe = 1'b0; 
            start = 1'b0; 
            fhilo = 1'b0; 
            m_or_alu = 1'b0; 
        end
    end
    initial
    begin
        hilo = 1'b0; 
        mdop = 2'b00; 
        mdwe = 1'b0; 
        start = 1'b0; 
        fhilo = 1'b0; 
        m_or_alu = 1'b0; 
        ALU_B_ctrl <= 1'b0;
        gr_regwrite <= 1'b0;
        ALU_op <= 6'b000000;
        Wdata_ctrl <= 2'b00;
        ext_op <= 1'b0; 
        dm_we <= 1'b0;
        lencode = 2'b00;
        dextop = 3'b000;
        memread <= 1'b0;
        forwardA <= 2'b00;
        forwardB <= 2'b00;
        cmp_op <= 4'b0000;
        forwardMWritedata <= 1'b0;
    end
endmodule

module EX_MEM(input [31:0] PCE, input [31:0]ALUout_E, input [31:0]Rdata2_E, input [4:0] Writereg_E, input clk, input en, 
            output [31:0] PCM, output [31:0]ALUout_M, output [31:0]Rdata2_M, output [4:0]Writereg_M);
    reg [31:0] ALUout;
    reg [31:0] Rdata2;
    reg [4:0] Writereg;
    reg [31:0] PC;
    
    assign ALUout_M = ALUout;
    assign Rdata2_M = Rdata2;
    assign Writereg_M = Writereg;
    assign PCM = PC;
    
    always@(posedge clk)
    begin
        if(en)
        begin
            ALUout <= ALUout_E;
            Rdata2 <= Rdata2_E;
            Writereg <= Writereg_E;
            PC <= PCE; 
        end
    end
    initial
    begin
        ALUout <= 32'h00000000;
        Rdata2 <= 32'h00000000;
        Writereg <= 5'b00000;
        PC <= 32'h00003000;
    end
endmodule

module EX_MEM_control(input [1:0]lencodeE, input [2:0]dextopE, input forwardMWritedataE, input clk, input en, input memreadE, input [1:0] Wdata_ctrl_E, input gr_regwrite_E, input dm_we_E, 
    output [1:0]lencodeM, output [2:0]dextopM, output forwardMWritedataM, output [1:0] Wdata_ctrl_M, output gr_regwrite_M, output dm_we_M, output memreadM);
    reg gr_regwrite;
    reg [1:0] Wdata_ctrl;
    reg memread;
    reg dm_we;
    reg forwardMWritedata;
    reg [1:0]lencode;
    reg [2:0]dextop;
    
    assign lencodeM = lencode;
    assign dextopM = dextop;    
    assign forwardMWritedataM = forwardMWritedata;
    assign gr_regwrite_M = gr_regwrite;
    assign Wdata_ctrl_M = Wdata_ctrl; 
    assign dm_we_M = dm_we;
    assign memreadM = memread;
    always@(posedge clk)
    begin
        if(en)
        begin
            lencode = lencodeE;
            dextop = dextopE;
            gr_regwrite <= gr_regwrite_E;
            Wdata_ctrl <= Wdata_ctrl_E;
            dm_we <= dm_we_E;
            memread <= memreadE;
            forwardMWritedata <= forwardMWritedataE;
        end
    end
    initial
    begin
        lencode = 2'b00;
        dextop = 3'b000;
        gr_regwrite <= 1'b0;
        Wdata_ctrl <= 2'b00;
        dm_we <= 1'b0;
        memread <= 1'b0;
        forwardMWritedata <= 1'b0;
    end
endmodule

module MEM_WB(input [31:0]dm_addrM, input [31:0]PCM, input [31:0]ALUout_M, input [31:0]DMout_M, input [4:0] Writereg_M, input clk, input en, 
            output [31:0]dm_addrW, output [31:0]PCW, output [31:0]ALUout_W, output [31:0]DMout_W, output [4:0]Writereg_W);
    reg [31:0] ALUout;
    reg [31:0] DMout;
    reg [4:0] Writereg;
    reg [31:0] PC;
    reg [31:0] dm_addr;
    assign PCW = PC;
    assign ALUout_W = ALUout;
    assign DMout_W = DMout;
    assign Writereg_W = Writereg;
    assign dm_addrW = dm_addr;
    
    always@(posedge clk)
    begin
        if(en)
        begin
            PC <= PCM;
            dm_addr = dm_addrM;
            ALUout <= ALUout_M;
            DMout <= DMout_M;
            Writereg <= Writereg_M;
        end
    end
    initial
    begin
         dm_addr = 32'h00000000;
         PC <= 32'h00003000;
         ALUout <= 32'h00000000;
         DMout <= 32'h00000000;
         Writereg <= 5'b00000;
    end
endmodule

module MEM_WB_control(input clk, input en, input [2:0]dextopM, input [1:0] Wdata_ctrl_M, input gr_regwrite_M, output [2:0]dextopW, output [1:0] Wdata_ctrl_W, output gr_regwrite_W);
    reg gr_regwrite;
    reg memread;
    reg [1:0] Wdata_ctrl;
    reg [2:0] dextop;
    
    assign dextopW = dextop;
    assign gr_regwrite_W = gr_regwrite;
    assign Wdata_ctrl_W = Wdata_ctrl; 
    
    always@(posedge clk)
    begin
        if(en)
        begin
            dextop = dextopM;
            gr_regwrite = gr_regwrite_M;
            Wdata_ctrl = Wdata_ctrl_M;
        end
    end
    initial
    begin
        dextop = 3'b000;
        gr_regwrite = 1'b0;
        Wdata_ctrl = 1'b0;
    end
endmodule