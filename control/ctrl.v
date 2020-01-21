`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 14:46:11
// Design Name: 
// Module Name: adder
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

module ctrl(input [31:0] instr, output multdivi, output hilo, output [1:0]mdop, output mdwe, output start, output fhilo, output m_or_alu, output [1:0]lencode, output[2:0]dextop, output alu_out_ctrl, output cmp0_ctrl, output rdata1_ctrl, output [1:0]PC_ctrl, output [1:0] Wreg_ctrl, output rtvalid,
            output [3:0] cmp_op, output [1:0] Wdata_ctrl, output [5:0]ALU_op, output ALU_B_ctrl, output gr_regwrite, output dm_we, output b_ctrl, output ext_op, output memread, output writedm, output ALU_A_ctrl);
    wire [5:0]op;
    wire special;
    wire [4:0]cmpcode;
    assign special = (instr[31:26] == 6'b000000);    
    assign op = (special==1)?instr[5:0]:instr[31:26];
    assign cmpcode = instr[20:16];
    //1 sign-ext, 0 unsign-ext
    assign ext_op = (op==6'b101001&&~special)||(op==6'b101000&&~special)||(op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b001001&&~special)||(op==6'b001110&&~special)||(op==6'b001100&&~special)||(op==6'b001000&&~special)||(op==6'b100001&&special)||(op==6 'b100011&&special)||(op==6'b100011&&~special)||(op==6'b101011&&~special)||(op==6'b000100&&~special)||(op==6'b001111&&~special)||(op==6'b000011&&~special)||(op==6'b000010&&~special)||(op==6'b001000&&special)||(op==6'b000001&&~special)||(op==6'b000110&&~special)||(op==6'b000111&&~special)||(op==6'b000110&&~special)||(6'b000101&&~special);
    
    //00 b, 01 h, 10 w
    assign lencode[0] = (op==6'b101001&&~special)||(op==6'b100101&&~special)||(op==6'b100001&&~special);
    assign lencode[1] = (op==6'b100011&&~special)||(op==6'b101011&&~special);
    
    assign dextop[0] = (op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special);
    assign dextop[1] = (op==6'b100101&&~special)||(op==6'b100001&&~special);
    assign dextop[2] = (op==6'b100001&&~special)||(op==6'b100000&&~special);
        
    //0 alu, 1 cmp
    assign alu_out_ctrl = (op==6'b101010&&special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b101011&&special);
    
    assign cmp0_ctrl = (op==6'b000001&&~special)||(op==6'b000111&&~special)||(op==6'b000110&&~special);
    
    //0 rs, 1 sa
    assign rdata1_ctrl = (op==6'b000000&&special)||(op==6'b000011&&special)||(op==6'b000010&&special);
    
    //00 pc+4 or b, 01 catenate, 10 rs
    assign PC_ctrl[0] = ((op == 6'b000011)&&(~special))||((op==6'b000010)&&~special);
    assign PC_ctrl[1]  = ((op == 6'b001000)&&special)||(op==6'b001001&&special);
    
    //00 rd, 01 rt, 10 11111
    assign Wreg_ctrl[0] = (op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b001000&&~special)||(op==6'b001001&&~special)||(op==6'b001100&&~special)||(op==6'b110100&&~special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b001110&&~special)||((op == 6'b001101)&&(~special)) || ((op==6'b001111)&&(~special)) || ((op==6'b100011)&&(~special));
    assign Wreg_ctrl[1] = (op == 6'b000011)&&(~special);
    
    //00 alu, 01 dm_out 10 adder_result
    assign Wdata_ctrl[0] = (op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||((op == 6'b100011)&&(~special));
    assign Wdata_ctrl[1] = ((op == 6'b000011)&&(~special))||(op==6'b001001&&special);
    
    assign ALU_op[0] = (op==6'b000011&&special)||(op==6'b000111&&special)||(op==6'b100101&&special)||(op==6'b100111&&special)||(op==6'b100001&&special)||(op==6'b100011&&special)||(op==6'b001101&&~special);
    assign ALU_op[1] = (op==6'b000011&&special)||(op==6'b000010&&special)||(op==6'b001110&&~special)||(op==6'b100110&&special)||(op==6'b100010&&special)||(op==6'b000110&&special)||(op==6'b000111&&special)||(op==6'b100111&&special)||(op==6'b100011&&special);
    assign ALU_op[2] = (op==6'b001110&&~special)||(op==6'b001100&&~special)||(op==6'b100110&&special)||(op==6'b100101&&special)||(op==6'b100111&&special)||(op==6'b100100&&special)||(op==6'b001101&&~special);
    assign ALU_op[3] = 1'b0;
    assign ALU_op[4] = 1'b0;
    assign ALU_op[5] = (op==6'b101001&&~special)||(op==6'b101000&&~special)||(op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b001110&&~special)||(op==6'b001100&&~special)||(op==6'b001001&&~special)||(op==6'b001000&&~special)||(op==6'b100110&&special)||(op==6'b100010&&special)||(op==6'b100101&&special)||(op==6'b100111&&special)||(op==6'b100100&&special)||(op==6'b100001&&special)||(op==6'b100011&&special)||(op==6'b001101&&~special)||(op==6'b100011&&~special)||(op==6'b101011&&~special)||(op==6'b100000&&special);
    
    //0 rt, 1 imm
    assign ALU_B_ctrl =  (op==6'b101001&&~special)||(op==6'b101000&&~special)||(op==6'b101001&&~special)||(op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b001110&&~special)||(op==6'b001100&&~special)||(op==6'b001001&&~special)||(op==6'b001000&&~special)||((op==6'b101011)&&(~special)) || ((op==6'b001101)&&(~special)) || ((op==6'b100011)&&(~special))||(op==6'b001111&&~special);
    assign gr_regwrite = (op==6'b010010&&special)||(op==6'b010000&special)||(op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b101010&&special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b101011&&special)||(op==6'b001000&&~special)||(op==6'b001001&&~special)||(op==6'b100100&&special)||(op==6'b001100&&~special)||(op==6'b100111&&special)||(op==6'b100101&&special)||(op==6'b000000&&special)||(op==6'b000100&&special)||(op==6'b000011&&special)||(op==6'b000111&&special)||(op==6'b000010&&special)||(op==6'b000110&&special)||(op==6'b100010&&special)||(op==6'b100110&&special)||(op==6'b001110&&~special)||(op==6'b100000&&special)||(op==6'b001001&&special)||(op== 6'b100001&&special)||(op==6'b100011&&special)||(op==6'b001101&&~special)||(op==6'b100011&&~special)||(op==6'b001111&&~special)||(op==6'b000011&&~special);
    assign dm_we = (op==6'b101001&&~special)||(op==6'b101000&&~special)||(op == 6'b101011)&&(~special);
    assign b_ctrl = (op==6'b001001&&special)||(op==6'b001000&&special)||(op==6'b000100)&&(~special)||(op==6'b000001&&~special)||(op==6'b000111&&~special)||(op==6'b000101&&~special)||(op==6'b000110&&~special);
    assign memread = (op==6'b100101&&~special)||(op==6'b100001&&~special)||(op==6'b100100&&~special)||(op==6'b100000&&~special)||(op==6'b100011)&&(~special)||(op==6'b100000&&~special);
    assign rtvalid = (op==6'b011010&&special)||(op==6'b011011&&special)||(op==6'b011000&&special)||(op==6'b011001&&special)||(op==6'b101000&&~special)||(op==6'b101001&&~special)||(op==6'b101010&&special)||(op==6'b101011&&special)||(op==6'b100110&&special)||(op==6'b100010&&special)||(op==6'b000110&&special)||(op==6'b000111&&special)||(op==6'b100101&&special)||(op==6'b000100&&special)||(op==6'b000101&&~special)||(op==6'b100111&&special)||(op==6'b100000&&special)||(op==6'b100100&&special)||((op==6'b100001)&&special)||((op==6'b100011)&&special)||((op==6'b101011)&&(~special))||((op==6'b000100)&&(~special))||(op==6'b001000&&special);
    assign writedm = (op==6'b101001&&~special)||(op==6'b101000&&~special)||(op==6'b101011&&(~special));
    
    //00 rs, 01 16(left-shift16)
    assign ALU_A_ctrl = (op==6'b001111&&~special);
    
    //0000ne, 0001e, 0011ge, 0010gt, 0101le,0100lt, 1000ne, 1001e, 1011ge, 1010gt, 1101le,1100lt
    assign cmp_op[0] = (op==6'b000100&&~special)||(op==6'b000001&&cmpcode==5'b00001&&~special)||(op==6'b000110&&~special);
    assign cmp_op[1] = (op==6'b000001&&cmpcode==5'b00001&&~special)||(op==6'b000111&&~special);
    assign cmp_op[2] = (op==6'b000110&&~special)||(op==6'b000001&&cmpcode==5'b00000&&~special)||(op==6'b101010&&special)||(op==6'b001010&&~special)||(op==6'b001011&&~special)||(op==6'b101011&&special);
    assign cmp_op[3] = (op==6'b001011&&~special)||(op==6'b101011&&special);
    
    assign hilo = (op==6'b010001&&special);
    assign mdop[0] = (op==6'b011000&&special)||(op==6'b011010&&special);
    assign mdop[1] = (op==6'b011010&&special)||(op==6'b011011&&special);
    
    assign start = (op==6'b011010&&special)||(op==6'b011011&&special)||(op==6'b011000&&special)||(op==6'b011001&&special);
    
    assign mdwe = (op==6'b010001&&special)||(op==6'b010011&&special);
    assign fhilo = (op==6'b010010&&special);
    assign m_or_alu = (op==6'b010010&&special)||(op==6'b010000&special);
    
    assign multdivi = (op==6'b010010&&special)||(op==6'b010000&special)||(op==6'b010001&&special)||(op==6'b010011&&special)||(op==6'b011010&&special)||(op==6'b011011&&special)||(op==6'b011000&&special)||(op==6'b011001&&special);
endmodule

module forwarding_unit(input writedm, input rtvalid, input [4:0] RdM, input [4:0]RdE, input reg_writeM, input reg_writeE, input [4:0]RsD, input [4:0]RtD, output [1:0]forwardA, output [1:0]forwardB, output forwardA_beq, output forwardB_beq, output forwardMWritedata/*, output [1:0]forwardR1, output [1:0]forwardR2*/);
    assign forwardA[0] = (reg_writeM == 1 && ~(RdM==0) && ~(reg_writeE==1&&~(RdE==0)&&(RdE==RsD)) && RdM==RsD);
    assign forwardA[1] = (reg_writeE==1 && ~(RdE == 0) && (RdE==RsD));
    assign forwardB[0] = (reg_writeM == 1 && ~(RdM==0) && ~(reg_writeE&&~(RdE==0)&&(RdE==RtD)&&rtvalid&&~writedm) && ((RdM==RtD)&&rtvalid));
    assign forwardB[1] = (reg_writeE==1 && ~(RdE == 0) && (RdE==RtD)&&rtvalid&&~writedm);
    assign forwardA_beq = forwardA[0];
    assign forwardB_beq = forwardB[0];
    assign forwardMWritedata = writedm&&(reg_writeE==1&&~(RdE==0)&&(RdE==RtD));
//    assign fowardR1 = (reg_writeM==1 && ~(RdE == 0) &&  (RdE==RsD))?(2'b10):((reg_writeM == 1 && ~(RdM==0) && ~(reg_writeE&&~(RdE==0)&&(RdE==RsD)) && RdM==RsD)?(2'b01):2'b00);
//    assign fowardR2 = (reg_writeM==1 && ~(RdE == 0) && (RdE==RtD))?(2'b10):((reg_writeM == 1 && ~(RdM==0) && ~(reg_writeE&&~(RdE==0)&&(RdE==RtD)) && RdM==RtD)?(2'b01):2'b00);
endmodule

module hazard_unit(input multdivi, input busy, input writedm, input rtvalid, input beq_ctrl, input memreadE, input memreadM, input reg_writeE, input [4:0]RdE, input [4:0]RsD, input [4:0]RtD, input [4:0]RdM, output stall, output PC_IFWrite);
    assign stall = (memreadE==1&&(RdE==RsD||(RdE==RtD&&rtvalid&&(~writedm))))||((beq_ctrl==1)&&(memreadM==1)&&(RdM==RsD||(RdM==RtD&&rtvalid)))||((beq_ctrl==1)&&(reg_writeE==1 && ~(RdE == 0) && (RdE==RsD||(RdE==RtD&&rtvalid))))||(multdivi&&busy);
    assign PC_IFWrite = ~stall;
endmodule