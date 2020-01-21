`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 20:28:59
// Design Name: 
// Module Name: alu
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

module mips(clk,reset);   
    input clk; //时钟信号    
    input reset; //复位信号
    wire [31:0] PC;
    wire [31:0] npc;
    wire [31:0] PCD;
    wire [31:0] PCE;
    wire [31:0] PCM;
    wire [31:0] PCW;
    
    wire [31:0] instrF;
    wire [31:0] instrD;
    wire gr_regwriteD;
    wire gr_regwriteM;
    wire gr_regwriteE;
    wire gr_regwriteW;
    
    
    wire [1:0] gr_Wreg_ctrlD;
	wire [1:0] gr_Wdata_ctrlD;
	wire [1:0] gr_Wdata_ctrlE;
	wire [1:0] gr_Wdata_ctrlM;
	wire [1:0] gr_Wdata_ctrlW;
	wire alu_B_ctrlD;
	wire alu_B_ctrlE;
	wire [1:0] branch_ctrlD;
	wire [5:0] alu_opD;
	wire [5:0] alu_opE;
	wire b_ctrlD;
	wire b_ctrlE;
	wire ext_opD;
	wire ext_opE;
	
	wire dm_weD;
	wire dm_weE;
	wire dm_weM;
	wire dm_weW;
    wire [31:0] adder_result;
    wire [31:0] adder_resultW;
    wire adder_over;
    wire PC_IFwrite;
    wire memreadE;
    wire memreadD;
    wire memreadM;
    wire rtvalid;
    wire stall;
    wire [4:0]WriteregD;
    wire [4:0]WriteregE;
    wire [4:0]WriteregM;
    wire [4:0]WriteregW;
    
    pc PC_register(npc, clk, reset, PC_IFwrite, PC);
    im_8k im(PC[12:2], instrF);
    
    //module IF_ID(input [31:0]instruction, input [31:0]npc, input clk, input en, input clr, output [31:0]instr, output[31:0] PC);
    IF_ID IF_ID1(instrF, npc, clk, PC_IFwrite, 1'b0, instrD, PCD);
    
    wire [31:0] sa;
    wire [5:0] op;
	wire [4:0] rsD; 
	wire [4:0] rtD;
	wire [4:0] rdD;
	wire [5:0] func;
	wire [15:0] imm_16;
	wire [31:0] imm_32D;
	wire [31:0] imm_32E;
	wire [31:0] imm_32M;
	wire [31:0] imm_32W;
	wire [25:0] instr_imm;
	wire ext_op;
	assign op = instrD[31:26];
	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign func = instrD[5:0];
	assign imm_16 = instrD[15:0];
	assign instr_imm = instrD[25:0];
	assign sa = {27'b000000000000000000000000000,instrD[10:6]};
	
	
	ext ext_32(imm_16, ext_opD, imm_32D);
    wire [4:0] gr_Rreg1;
	wire [4:0] gr_Rreg2;
	wire [31:0] gr_WdataW;
	wire [31:0] gr_Rdata1;
	wire [31:0] gr_Rdata2;
	wire [31:0] gr_Rdata1t;
	wire [31:0] gr_Rdata1s;
	wire [31:0] gr_Rdata2s;
	wire [31:0] gr_Rdata1D;
	wire [31:0] gr_Rdata2D;
    wire [31:0] gr_Rdata1E;
    wire [31:0] gr_Rdata2E;
    wire [31:0] gr_Rdata1M;
    wire [31:0] gr_Rdata2M;
    wire [31:0] gr_Rdata1W;
    wire [31:0] gr_Rdata2W;
    wire [31:0] alu_AE ;
    wire [31:0] alu_BE;
    wire [31:0] alu_result;
	wire [31:0] alu_resultE;
	wire [31:0] alu_resultM;
	wire [31:0] alu_resultW;
	
	wire lu_over;
	wire alu_zero;
    	
	wire [31:0] dm_addrE;
	wire [31:0] dm_addrM;
	wire [31:0] dm_addrW;
	wire [31:0] dm_WdataM;
	wire [31:0] dm_outM;
	wire [31:0] dm_outW;
	
	wire [1:0] forwardA;
	wire [1:0] forwardB;
	wire forwardA_beq;
	wire forwardB_beq;
	wire [1:0] forwardAE;
	wire [1:0] forwardBE;
	wire forwardMWritedataD;
	wire forwardMWritedataE;
	wire forwardMWritedataM;
	wire writedm;
	wire ALU_A_ctrl;
	wire br;
	wire [3:0]cmp_op;
	wire [3:0]cmp_opE;
	wire gr_Rdata1_ctrl;
	wire cmp0_ctrl;
	wire cmp_result;
	wire alu_out_ctrlD;
	wire alu_out_ctrlE;
	wire [1:0]lencodeD;
	wire [1:0]lencodeE;
	wire [1:0]lencodeM;
	wire [2:0]dextopD;
	wire [2:0]dextopE;
	wire [2:0]dextopM;
	wire [2:0]dextopW;
	wire [31:0] dm_data_ext;
	wire [3:0] be;
	
	wire hiloD;
	wire hiloE;
	wire busyE;
	wire [31:0]hiE;
	wire [31:0]loE;
	wire [31:0]hilo;
	wire [1:0]mdopD;
	wire [1:0]mdopE;
	wire mdweE;
	wire mdweD;
	wire startD;
	wire startE;
	wire multdivi;
	wire fhiloD;
	wire fhiloE;
	wire m_or_aluD;
	wire m_or_aluE;
	
    //module ctrl(input [31:0] instr, output multdivi, output hilo, output [1:0]mdop, output mdwe, output start, output fhilo, output m_or_alu, output [1:0]lencode, output[2:0]dextop, output alu_out_ctrl, output cmp0_ctrl, output rdata1_ctrl, output [1:0]PC_ctrl, output [1:0] Wreg_ctrl, output rtvalid,
            //output [3:0] cmp_op, output [1:0] Wdata_ctrl, output [5:0]ALU_op, output ALU_B_ctrl, output gr_regwrite, output dm_we, output b_ctrl, output ext_op, output memread, output writedm, output ALU_A_ctrl);
    ctrl Ctrl(instrD, multdivi, hiloD, mdopD, mdweD, startD, fhiloD, m_or_aluD, lencodeD, dextopD, alu_out_ctrlD, cmp0_ctrl, gr_Rdata1_ctrl, branch_ctrlD, gr_Wreg_ctrlD, rtvalid, cmp_op, gr_Wdata_ctrlD, alu_opD, alu_B_ctrlD, gr_regwriteD, dm_weD, b_ctrlD, ext_opD, memreadD, writedm, ALU_A_ctrl);
    
    //module hazard_unit(input rtvalid, input b_ctrl, input memreadE, input memreadM, input reg_writeE, input [4:0]RdE, input [4:0]RsD, input [4:0]RtD, input [4:0]RdM, output stall, output PC_IFWrite);
    hazard_unit hu(multdivi, busyE, writedm, rtvalid, b_ctrlD, memreadE, memreadM, gr_regwriteE, WriteregE, rsD, rtD, WriteregM, stall, PC_IFwrite);
    
    //module forwarding_unit(input rtvalid, input [4:0] RdM, input [4:0]RdE, input reg_writeM, input reg_writeE, input [4:0]RsD, input [4:0]RtD, output [1:0]forwardA, output [1:0]forwardB, output [1:0]forwardA_beq, output [1:0]forwardB_beq, output forwardMWritedata/*, output [1:0]forwardR1, output [1:0]forwardR2*/);
    forwarding_unit fu(writedm, rtvalid, WriteregM, WriteregE, gr_regwriteM, gr_regwriteE, rsD, rtD, forwardA, forwardB, forwardA_beq, forwardB_beq, forwardMWritedataD);
    
	assign gr_Rreg1 = rsD;
	assign gr_Rreg2 = rtD;
	mux_3 mux_Wreg(rdD, rtD, 5'b11111, gr_Wreg_ctrlD, WriteregD);
    gr GR(gr_Rreg1, gr_Rreg2, WriteregW, gr_WdataW, clk, gr_regwriteW, gr_Rdata1t, gr_Rdata2D);
    mux_2 mux_R1_(gr_Rdata1t, sa, gr_Rdata1_ctrl, gr_Rdata1);
    mux_2 mux_R1(gr_Rdata1, alu_resultM, forwardA_beq, gr_Rdata1s);
    
    mux_2 mux_R2(gr_Rdata2D, alu_resultM, forwardB_beq, gr_Rdata2);
    mux_2 mux_R2_(gr_Rdata2,  0, cmp0_ctrl, gr_Rdata2s);
    cmp cmp1(gr_Rdata1s, gr_Rdata2s, cmp_op, br);
    mux_2 mux_A(gr_Rdata1, 16, ALU_A_ctrl, gr_Rdata1D);
    adder Adder(PCD, 32'b00000000000000000000000000000100, 1'b0, adder_result, adder_over);
    wire [31:0] offset;
    wire [31:0] nadd_result;
    wire [31:0] instr_imm_32;
    wire [31:0] catenate_result;
    wire nadd_over;
    wire alu_over;
    shift_left shift_imm(imm_32D, 5'b00010, offset);
    adder nadd(PCD, offset, 0, nadd_result, nadd_over);
    ext ext_instr(instr_imm, ext_opD, instr_imm_32);
    wire [31:0] instr_imm_32_shift;
    shift_left shift_instr(instr_imm_32, 2, instr_imm_32_shift);
    catenate catenate_instr(adder_result, instr_imm_32_shift, catenate_result);
    wire [31:0] branch_result;
    mux_2 mux_branch(adder_result, nadd_result, br&b_ctrlD, branch_result);
    mux_3 mux_NPC(branch_result, catenate_result, gr_Rdata1s, branch_ctrlD, npc);
    
    
//    module ID_EX(input [31:0]imm_32D, input [31:0]PCD, input [31:0]Rdata1_D, input [31:0]Rdata2_D, input [4:0]WriteregD, input clk, input clr, 
//            output [31:0]imm_32E, output [31:0]PCE, output [31:0]Rdata1_E, output [31:0]Rdata2_E, output [4:0]WriteregE);
    ID_EX ID_EX1(imm_32D, PCD, gr_Rdata1D, gr_Rdata2D, WriteregD, clk, stall, 
                    imm_32E, PCE, gr_Rdata1E, gr_Rdata2E, WriteregE);
   
    //module ID_EX_control(input [2:0]cmp_opD, input forwardMWritedataD, input [1:0]forwardA, input[1:0] forwardB, input clk, input clr, input memreadD, input [1:0] Wdata_ctrl_D, input [5:0]ALU_op_D, input ALU_B_ctrl_D, input gr_regwrite_D, input dm_we_D, input ext_op_D,
    //        output [2:0]cmp_opE, output forwardMWritedataE, output [1:0]forwardAE, output [1:0]forwardBE, output memreadE, output [1:0] Wdata_ctrl_E, output [5:0]ALU_op_E, output ALU_B_ctrl_E, output gr_regwrite_E, output dm_we_E, output ext_op_E);      
    ID_EX_control ID_EX_c1(hiloD, mdopD, mdweD, startD, fhiloD, m_or_aluD, lencodeD, dextopD, alu_out_ctrlD, cmp_op, forwardMWritedataD, forwardA, forwardB, clk, stall, memreadD, gr_Wdata_ctrlD, alu_opD, alu_B_ctrlD, gr_regwriteD, dm_weD, ext_opD, 
                            hiloE, mdopE, mdweE, startE, fhiloE, m_or_aluE,lencodeE, dextopE, alu_out_ctrlE, cmp_opE, forwardMWritedataE, forwardAE, forwardBE, memreadE, gr_Wdata_ctrlE, alu_opE, alu_B_ctrlE, gr_regwriteE, dm_weE, ext_opE);
    wire [31:0] gr_Rdata1E_new;
    wire [31:0] gr_Rdata2E_new;
    wire [31:0] ALU_BE;
    wire [31:0] alu_resultEt;
    mux_3 mux_R1E(gr_Rdata1E, gr_WdataW, alu_resultM, forwardAE, gr_Rdata1E_new);
    mux_3 mux_R2E(gr_Rdata2E, gr_WdataW, alu_resultM, forwardBE, gr_Rdata2E_new);
    mux_2 mux_ALU_B(gr_Rdata2E_new, imm_32E, alu_B_ctrlE, alu_BE);
    multdiv md(clk, 0, gr_Rdata1E_new, gr_Rdata2E_new, hiloE, mdopE, startE, mdweE, busyE, hiE, loE);
    mux_2 mux_hilo(hiE, loE, fhiloE, hilo);
    assign alu_AE = gr_Rdata1E_new;
    alu ALU(alu_AE, alu_BE, alu_opE, alu_result, alu_over, alu_zero); 
    cmp cmp2(alu_AE, alu_BE, cmp_opE, cmp_result);
    mux_2 mux_ALUout(alu_result, {31'b000000000000000000000000000,cmp_result}, alu_out_ctrlE, alu_resultEt);
    //module EX_MEM(input [31:0]PCE, input [31:0]ALUout_E, input [31:0]Rdata2_E, input [4:0] Writereg_E, input clk, input en, 
    //        output [31:0]PCM, output [31:0]ALUout_M, output [31:0]Rdata2_M, output [4:0]Writereg_M);
    mux_2 mux_MorALU(alu_resultEt, hilo, m_or_aluE, alu_resultE);
    
    EX_MEM EX_MEM1(PCE, alu_resultE, gr_Rdata2E_new, WriteregE, clk, 1, 
                    PCM, alu_resultM, gr_Rdata2M, WriteregM);
    
    //module EX_MEM_control(input clk, input en, input memreadE, input [1:0] Wdata_ctrl_E, input gr_regwrite_E, input dm_we_E, 
    //        output [1:0] Wdata_ctrl_M, output gr_regwrite_M, output dm_we_M, output memreadM);
    EX_MEM_control EX_MEM_c1(lencodeE, dextopE, forwardMWritedataE, clk, 1, memreadE, gr_Wdata_ctrlE, gr_regwriteE, dm_weE, 
                            lencodeM, dextopM, forwardMWritedataM, gr_Wdata_ctrlM, gr_regwriteM, dm_weM, memreadM);
    
    assign dm_addrM = alu_resultM;
    mux_2 mux_dmWdata(gr_Rdata2M, gr_WdataW, forwardMWritedataM, dm_WdataM);
    trans transaddr(dm_addrM, lencodeM, be);
    dm_8k dm(dm_addrM[12:2], be, dm_WdataM, dm_weM, clk, dm_outM);
    
    //module MEM_WB(input [31:0]PCM, input [31:0]ALUout_M, input [31:0]DMout_M, input [4:0] Writereg_M, input clk, input en, 
    //        input [31:0]PCW, output [31:0]ALUout_W, output [31:0]DMout_W, output [4:0]Writereg_W);
    MEM_WB MEM_WB1(dm_addrM, PCM, alu_resultM, dm_outM, WriteregM, clk, 1, 
                    dm_addrW, PCW, alu_resultW, dm_outW, WriteregW);
    
    //module MEM_WB_control(input clk, input en, input [1:0] Wdata_ctrl_M, input gr_regwrite_M, output [1:0] Wdata_ctrl_W, output gr_regwrite_W);
    //
	MEM_WB_control MEM_WB_c1(clk, 1, dextopM, gr_Wdata_ctrlM, gr_regwriteM, dextopW, gr_Wdata_ctrlW, gr_regwriteW);
	data_ext de(dm_addrW, dm_outW, dextopW, dm_data_ext);
	adder add_4(PCW, 32'b00000000000000000000000000000100, 0, adder_resultW, adder_over);
    mux_3 mux_Wdata(alu_resultW, dm_data_ext, adder_resultW, gr_Wdata_ctrlW, gr_WdataW);
endmodule