/*---------------------------------------------------------------------------
  --      AES.sv                                                           --
  --      Joe Meng                                                         --
  --      Fall 2013                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

// AES module interface with all ports, commented for Week 1
// module  AES ( input  [127:0]  Ciphertext,
//                               Cipherkey,
//               input           Clk, 
//                               Reset,
//		 	  				     Run,
//               output [127:0]  Plaintext,
//               output          Ready  );

// Partial interface for Week 1
// Splitting the signals into 32-bit ones for compatibility with ModelSim
	module  invAES (input				clk, Reset, Run,
						 input	[127:0]	Ciphertext,
						 input 	[127:0]  Cipherkey,
						 output	logic [127:0]	Plaintext,
						 output	logic 			Ready);					 
					 
	logic [0:1407] keyschedule;
	enum logic [6:0] {WAIT, FINISH, 
							INV_ADDROUND1, INV_ADDROUND2,
							INV_ADDROUND3, INV_ADDROUND4, 
							INV_ADDROUND5, INV_ADDROUND6, 
							INV_ADDROUND7, INV_ADDROUND8, 
							INV_ADDROUND9, INV_ADDROUND10, INV_ADDROUND11,
							INV_SHIFTROWS1, INV_SHIFTROWS2, INV_SHIFTROWS3, INV_SHIFTROWS4, INV_SHIFTROWS5, INV_SHIFTROWS6, INV_SHIFTROWS7, INV_SHIFTROWS8, INV_SHIFTROWS9, INV_SHIFTROWS10,
							INV_SUBBYTES1, INV_SUBBYTES2, INV_SUBBYTES3, INV_SUBBYTES4, INV_SUBBYTES5, INV_SUBBYTES6, INV_SUBBYTES7, INV_SUBBYTES8, INV_SUBBYTES9, INV_SUBBYTES10,
							INV_MIXCOLUMNS1_1, INV_MIXCOLUMNS1_2, INV_MIXCOLUMNS1_3, INV_MIXCOLUMNS1_4, INV_MIXCOLUMNS2_1, INV_MIXCOLUMNS2_2, INV_MIXCOLUMNS2_3, INV_MIXCOLUMNS2_4, 
							INV_MIXCOLUMNS3_1, INV_MIXCOLUMNS3_2, INV_MIXCOLUMNS3_3, INV_MIXCOLUMNS3_4, INV_MIXCOLUMNS4_1, INV_MIXCOLUMNS4_2, INV_MIXCOLUMNS4_3, INV_MIXCOLUMNS4_4,
							INV_MIXCOLUMNS5_1, INV_MIXCOLUMNS5_2, INV_MIXCOLUMNS5_3, INV_MIXCOLUMNS5_4, INV_MIXCOLUMNS6_1, INV_MIXCOLUMNS6_2, INV_MIXCOLUMNS6_3, INV_MIXCOLUMNS6_4,
							INV_MIXCOLUMNS7_1, INV_MIXCOLUMNS7_2, INV_MIXCOLUMNS7_3, INV_MIXCOLUMNS7_4, INV_MIXCOLUMNS8_1, INV_MIXCOLUMNS8_2, INV_MIXCOLUMNS8_3, INV_MIXCOLUMNS8_4,
							INV_MIXCOLUMNS9_1, INV_MIXCOLUMNS9_2, INV_MIXCOLUMNS9_3, INV_MIXCOLUMNS9_4,		
							
							INV_MIXCOLUMNS1_1_1, 
							INV_MIXCOLUMNS1_2_1, 
							INV_MIXCOLUMNS1_3_1, 
							INV_MIXCOLUMNS1_4_1, 
							INV_MIXCOLUMNS2_1_1, 
							INV_MIXCOLUMNS2_2_1, 
							INV_MIXCOLUMNS2_3_1, 
							INV_MIXCOLUMNS2_4_1, 
							INV_MIXCOLUMNS3_1_1, 
							INV_MIXCOLUMNS3_2_1, 
							INV_MIXCOLUMNS3_3_1, 
							INV_MIXCOLUMNS3_4_1, 
							INV_MIXCOLUMNS4_1_1, 
							INV_MIXCOLUMNS4_2_1, 
							INV_MIXCOLUMNS4_3_1, 
							INV_MIXCOLUMNS4_4_1,
							INV_MIXCOLUMNS5_1_1, 
							INV_MIXCOLUMNS5_2_1, 
							INV_MIXCOLUMNS5_3_1, 
							INV_MIXCOLUMNS5_4_1, 
							INV_MIXCOLUMNS6_1_1, 
							INV_MIXCOLUMNS6_2_1, 
							INV_MIXCOLUMNS6_3_1, 
							INV_MIXCOLUMNS6_4_1,
							INV_MIXCOLUMNS7_1_1, 
							INV_MIXCOLUMNS7_2_1, 
							INV_MIXCOLUMNS7_3_1, 
							INV_MIXCOLUMNS7_4_1, 
							INV_MIXCOLUMNS8_1_1, 
							INV_MIXCOLUMNS8_2_1, 
							INV_MIXCOLUMNS8_3_1, 
							INV_MIXCOLUMNS8_4_1,
							INV_MIXCOLUMNS9_1_1, 
							INV_MIXCOLUMNS9_2_1, 
							INV_MIXCOLUMNS9_3_1, 
							INV_MIXCOLUMNS9_4_1
							
							
							} state, next_state;
	


	
	KeyExpansion keyexpansion_0(
		.*, .Cipherkey,
		.KeySchedule(keyschedule));
	
	logic [0:127] add_in, add_out, shift_in, shift_out, mix_out, sub_in, sub_out;
	logic [0:127] addkey;
	logic [0:31] mixin;
	logic [0:31] mixout;
	
					 				 
	always_ff @ (posedge clk, negedge Reset) 
	begin
		if (Reset == 1'b0)
			state <= WAIT;
		else
			state <= next_state;
	end
	
	always_comb
	begin
		next_state = state;
		case (state)
			WAIT: begin
					if (Run)
						next_state = INV_ADDROUND1;
			end
			
			INV_ADDROUND1: begin
				next_state = INV_SHIFTROWS1;
			end
			
			INV_SHIFTROWS1: begin						//First loop
				next_state = INV_SUBBYTES1;
			end
			
			INV_SUBBYTES1: begin
				next_state = INV_ADDROUND2;
			end
			
			INV_ADDROUND2: begin
				next_state = INV_MIXCOLUMNS1_1;
			end
			
			INV_MIXCOLUMNS1_1: begin
				next_state = INV_MIXCOLUMNS1_1_1;
			end
			
			INV_MIXCOLUMNS1_1_1: begin
				next_state = INV_MIXCOLUMNS1_2;
			end
			
			INV_MIXCOLUMNS1_2: begin
				next_state = INV_MIXCOLUMNS1_2_1;
			end
			
			INV_MIXCOLUMNS1_2_1: begin
				next_state = INV_MIXCOLUMNS1_3;
			end
			
			INV_MIXCOLUMNS1_3: begin
				next_state = INV_MIXCOLUMNS1_3_1;
			end
			
			INV_MIXCOLUMNS1_3_1: begin
				next_state = INV_MIXCOLUMNS1_4;
			end
			
			INV_MIXCOLUMNS1_4: begin
				next_state = INV_MIXCOLUMNS1_4_1;
			end
			
			INV_MIXCOLUMNS1_4_1: begin
				next_state = INV_SHIFTROWS2;
			end
			
			INV_SHIFTROWS2: begin						//Second loop
				next_state = INV_SUBBYTES2;
			end
			
			INV_SUBBYTES2: begin
				next_state = INV_ADDROUND3;
			end
			
			INV_ADDROUND3: begin
				next_state = INV_MIXCOLUMNS2_1;
			end
			
			INV_MIXCOLUMNS2_1: begin
				next_state = INV_MIXCOLUMNS2_1_1;
			end
			
			INV_MIXCOLUMNS2_1_1: begin
				next_state = INV_MIXCOLUMNS2_2;
			end
			
			INV_MIXCOLUMNS2_2: begin
				next_state = INV_MIXCOLUMNS2_2_1;
			end
			
			INV_MIXCOLUMNS2_2_1: begin
				next_state = INV_MIXCOLUMNS2_3;
			end
			
			INV_MIXCOLUMNS2_3: begin
				next_state = INV_MIXCOLUMNS2_3_1;
			end
			
			INV_MIXCOLUMNS2_3_1: begin
				next_state = INV_MIXCOLUMNS2_4;
			end
			
			INV_MIXCOLUMNS2_4: begin
				next_state = INV_MIXCOLUMNS2_4_1;
			end
			
			INV_MIXCOLUMNS2_4_1: begin
				next_state = INV_SHIFTROWS3;
			end
			
			INV_SHIFTROWS3: begin						//Third loop
				next_state = INV_SUBBYTES3;
			end
			
			INV_SUBBYTES3: begin
				next_state = INV_ADDROUND4;
			end
			
			INV_ADDROUND4: begin
				next_state = INV_MIXCOLUMNS3_1;
			end
			
			INV_MIXCOLUMNS3_1: begin
				next_state = INV_MIXCOLUMNS3_1_1;
			end
			
			INV_MIXCOLUMNS3_1_1: begin
				next_state = INV_MIXCOLUMNS3_2;
			end
			
			INV_MIXCOLUMNS3_2: begin
				next_state = INV_MIXCOLUMNS3_2_1;
			end
			
			INV_MIXCOLUMNS3_2_1: begin
				next_state = INV_MIXCOLUMNS3_3;
			end
			
			INV_MIXCOLUMNS3_3: begin
				next_state = INV_MIXCOLUMNS3_3_1;
			end
			
			INV_MIXCOLUMNS3_3_1: begin
				next_state = INV_MIXCOLUMNS3_4;
			end
			
			INV_MIXCOLUMNS3_4: begin
				next_state = INV_MIXCOLUMNS3_4_1;
			end
			
			INV_MIXCOLUMNS3_4_1: begin
				next_state = INV_SHIFTROWS4;
			end
			
			INV_SHIFTROWS4: begin						//Fourth loop
				next_state = INV_SUBBYTES4;
			end
			
			INV_SUBBYTES4: begin
				next_state = INV_ADDROUND5;
			end
			
			INV_ADDROUND5: begin
				next_state = INV_MIXCOLUMNS4_1;
			end
			
			INV_MIXCOLUMNS4_1: begin
				next_state = INV_MIXCOLUMNS4_1_1;
			end
			
			INV_MIXCOLUMNS4_1_1: begin
				next_state = INV_MIXCOLUMNS4_2;
			end
			
			INV_MIXCOLUMNS4_2: begin
				next_state = INV_MIXCOLUMNS4_2_1;
			end
			
			INV_MIXCOLUMNS4_2_1: begin
				next_state = INV_MIXCOLUMNS4_3;
			end
			
			INV_MIXCOLUMNS4_3: begin
				next_state = INV_MIXCOLUMNS4_3_1;
			end
			
			INV_MIXCOLUMNS4_3_1: begin
				next_state = INV_MIXCOLUMNS4_4;
			end
			
			INV_MIXCOLUMNS4_4: begin
				next_state = INV_MIXCOLUMNS4_4_1;
			end
			
			INV_MIXCOLUMNS4_4_1: begin
				next_state = INV_SHIFTROWS5;
			end
			
			INV_SHIFTROWS5: begin						//Fifth loop
				next_state = INV_SUBBYTES5;
			end
			
			INV_SUBBYTES5: begin
				next_state = INV_ADDROUND6;
			end
			
			INV_ADDROUND6: begin
				next_state = INV_MIXCOLUMNS5_1;
			end
			
			INV_MIXCOLUMNS5_1: begin
				next_state = INV_MIXCOLUMNS5_1_1;
			end
			
			INV_MIXCOLUMNS5_1_1: begin
				next_state = INV_MIXCOLUMNS5_2;
			end
			
			INV_MIXCOLUMNS5_2: begin
				next_state = INV_MIXCOLUMNS5_2_1;
			end
			
			INV_MIXCOLUMNS5_2_1: begin
				next_state = INV_MIXCOLUMNS5_3;
			end
			
			INV_MIXCOLUMNS5_3: begin
				next_state = INV_MIXCOLUMNS5_3_1;
			end
			
			INV_MIXCOLUMNS5_3_1: begin
				next_state = INV_MIXCOLUMNS5_4;
			end
			
			INV_MIXCOLUMNS5_4: begin
				next_state = INV_MIXCOLUMNS5_4_1;
			end
			
			INV_MIXCOLUMNS5_4_1: begin
				next_state = INV_SHIFTROWS6;
			end
			
			INV_SHIFTROWS6: begin						//Sixth loop
				next_state = INV_SUBBYTES6;
			end
			
			INV_SUBBYTES6: begin
				next_state = INV_ADDROUND7;
			end
			
			INV_ADDROUND7: begin
				next_state = INV_MIXCOLUMNS6_1;
			end
			
			INV_MIXCOLUMNS6_1: begin
				next_state = INV_MIXCOLUMNS6_1_1;
			end
			
			INV_MIXCOLUMNS6_1_1: begin
				next_state = INV_MIXCOLUMNS6_2;
			end
			
			INV_MIXCOLUMNS6_2: begin
				next_state = INV_MIXCOLUMNS6_2_1;
			end
			
			INV_MIXCOLUMNS6_2_1: begin
				next_state = INV_MIXCOLUMNS6_3;
			end
			
			INV_MIXCOLUMNS6_3: begin
				next_state = INV_MIXCOLUMNS6_3_1;
			end
			
			INV_MIXCOLUMNS6_3_1: begin
				next_state = INV_MIXCOLUMNS6_4;
			end
			
			INV_MIXCOLUMNS6_4: begin
				next_state = INV_MIXCOLUMNS6_4_1;
			end
			
			INV_MIXCOLUMNS6_4_1: begin
				next_state = INV_SHIFTROWS7;
			end
			
			INV_SHIFTROWS7: begin						//Seventh loop
				next_state = INV_SUBBYTES7;
			end
			
			INV_SUBBYTES7: begin
				next_state = INV_ADDROUND8;
			end
			
			INV_ADDROUND8: begin
				next_state = INV_MIXCOLUMNS7_1;
			end
			
			INV_MIXCOLUMNS7_1: begin
				next_state = INV_MIXCOLUMNS7_1_1;
			end
			
			INV_MIXCOLUMNS7_1_1: begin
				next_state = INV_MIXCOLUMNS7_2;
			end
			
			INV_MIXCOLUMNS7_2: begin
				next_state = INV_MIXCOLUMNS7_2_1;
			end
			
			INV_MIXCOLUMNS7_2_1: begin
				next_state = INV_MIXCOLUMNS7_3;
			end
			
			INV_MIXCOLUMNS7_3: begin
				next_state = INV_MIXCOLUMNS7_3_1;
			end
			
			INV_MIXCOLUMNS7_3_1: begin
				next_state = INV_MIXCOLUMNS7_4;
			end
			
			INV_MIXCOLUMNS7_4: begin
				next_state = INV_MIXCOLUMNS7_4_1;
			end
			
			INV_MIXCOLUMNS7_4_1: begin
				next_state = INV_SHIFTROWS8;
			end
			
			INV_SHIFTROWS8: begin						//Eighth loop
				next_state = INV_SUBBYTES8;
			end
			
			INV_SUBBYTES8: begin
				next_state = INV_ADDROUND9;
			end
			
			INV_ADDROUND9: begin
				next_state = INV_MIXCOLUMNS8_1;
			end
			
			INV_MIXCOLUMNS8_1: begin
				next_state = INV_MIXCOLUMNS8_1_1;
			end
			
			INV_MIXCOLUMNS8_1_1: begin
				next_state = INV_MIXCOLUMNS8_2;
			end
			
			INV_MIXCOLUMNS8_2: begin
				next_state = INV_MIXCOLUMNS8_2_1;
			end
			
			INV_MIXCOLUMNS8_2_1: begin
				next_state = INV_MIXCOLUMNS8_3;
			end
			
			INV_MIXCOLUMNS8_3: begin
				next_state = INV_MIXCOLUMNS8_3_1;
			end
			
			INV_MIXCOLUMNS8_3_1: begin
				next_state = INV_MIXCOLUMNS8_4;
			end
			
			INV_MIXCOLUMNS8_4: begin
				next_state = INV_MIXCOLUMNS8_4_1;
			end
			
			INV_MIXCOLUMNS8_4_1: begin
				next_state = INV_SHIFTROWS9;
			end
			
			INV_SHIFTROWS9: begin						//Ninth loop
				next_state = INV_SUBBYTES9;
			end
			
			INV_SUBBYTES9: begin
				next_state = INV_ADDROUND10;
			end
			
			INV_ADDROUND10: begin
				next_state = INV_MIXCOLUMNS9_1;
			end
			
			INV_MIXCOLUMNS9_1: begin
				next_state = INV_MIXCOLUMNS9_1_1;
			end
			
			INV_MIXCOLUMNS9_1_1: begin
				next_state = INV_MIXCOLUMNS9_2;
			end
			
			INV_MIXCOLUMNS9_2: begin
				next_state = INV_MIXCOLUMNS9_2_1;
			end
			
			INV_MIXCOLUMNS9_2_1: begin
				next_state = INV_MIXCOLUMNS9_3;
			end
			
			INV_MIXCOLUMNS9_3: begin
				next_state = INV_MIXCOLUMNS9_3_1;
			end
			
			INV_MIXCOLUMNS9_3_1: begin
				next_state = INV_MIXCOLUMNS9_4;
			end
			
			INV_MIXCOLUMNS9_4: begin
				next_state = INV_MIXCOLUMNS9_4_1;
			end
			
			INV_MIXCOLUMNS9_4_1: begin
				next_state = INV_SHIFTROWS10;
			end
			
			INV_SHIFTROWS10: begin
				next_state = INV_SUBBYTES10;
			end
			
			INV_SUBBYTES10: begin
				next_state = INV_ADDROUND11;
			end
			
			INV_ADDROUND11: begin
				next_state = FINISH;
			end
			
			FINISH: ;
			
		endcase
	end
	
	/*
	always_comb begin
		Ready = 1'b0;
		unique case (state)
			FINISH: begin
				Ready = 1'b1;
			end 
		endcase
	end
	*/
	
	//??????? always something??????
	//instantiation shizz???
	AddRoundKey adding(.in(add_in), .key(addkey), .out(add_out));
	InvShiftRows shifting(.in(shift_in), .out(shift_out));
	InvSubBytes subbing1(.clk, .in(sub_in[0:7]), .out(sub_out[0:7]));
	InvSubBytes subbing2(.clk, .in(sub_in[8:15]), .out(sub_out[8:15]));
	InvSubBytes subbing3(.clk, .in(sub_in[16:23]), .out(sub_out[16:23]));
	InvSubBytes subbing4(.clk, .in(sub_in[24:31]), .out(sub_out[24:31]));
	InvSubBytes subbing5(.clk, .in(sub_in[32:39]), .out(sub_out[32:39]));
	InvSubBytes subbing6(.clk, .in(sub_in[40:47]), .out(sub_out[40:47]));
	InvSubBytes subbing7(.clk, .in(sub_in[48:55]), .out(sub_out[48:55]));
	InvSubBytes subbing8(.clk, .in(sub_in[56:63]), .out(sub_out[56:63]));
	InvSubBytes subbing9(.clk, .in(sub_in[64:71]), .out(sub_out[64:71]));
	InvSubBytes subbing10(.clk, .in(sub_in[72:79]), .out(sub_out[72:79]));
	InvSubBytes subbing11(.clk, .in(sub_in[80:87]), .out(sub_out[80:87]));
	InvSubBytes subbing12(.clk, .in(sub_in[88:95]), .out(sub_out[88:95]));
	InvSubBytes subbing13(.clk, .in(sub_in[96:103]), .out(sub_out[96:103]));
	InvSubBytes subbing14(.clk, .in(sub_in[104:111]), .out(sub_out[104:111]));
	InvSubBytes subbing15(.clk, .in(sub_in[112:119]), .out(sub_out[112:119]));
	InvSubBytes subbing16(.clk, .in(sub_in[120:127]), .out(sub_out[120:127]));
	InvMixColumns mixing(.in(mixin), .out(mixout));
	
	always_latch begin
		Ready = 1'b0;
		add_in = add_in;
		addkey = addkey;
		mix_out = mix_out;
		mixin = mixin;
		shift_in = shift_in;
		sub_in = sub_in;
		case (state)
			INV_ADDROUND1: begin
				add_in = Ciphertext;
				addkey = keyschedule[0:127];
			end
			INV_ADDROUND2: begin
				add_in = sub_out;
				addkey = keyschedule[128:255];
			end
			INV_ADDROUND3: begin
				add_in = sub_out;
				addkey = keyschedule[256:383];
			end
			INV_ADDROUND4: begin
				add_in = sub_out;
				addkey = keyschedule[384:511];
			end
			INV_ADDROUND5: begin
				add_in = sub_out;
				addkey = keyschedule[512:639];
			end
			INV_ADDROUND6: begin
				add_in = sub_out;
				addkey = keyschedule[640:767];
			end
			INV_ADDROUND7: begin
				add_in = sub_out;
				addkey = keyschedule[768:895];
			end
			INV_ADDROUND8: begin
				add_in = sub_out;
				addkey = keyschedule[896:1023];
			end
			INV_ADDROUND9: begin
				add_in = sub_out;
				addkey = keyschedule[1024:1151];
			end
			INV_ADDROUND10: begin
				add_in = sub_out;
				addkey = keyschedule[1152:1279];
			end
			INV_ADDROUND11: begin
				add_in = sub_out;
				addkey = keyschedule[1280:1407];
			end
			
			INV_SHIFTROWS1: begin
				shift_in = add_out;
			end
			INV_SHIFTROWS2: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS3: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS4: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS5: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS6: begin
				shift_in = mix_out;
			end
			
			INV_SHIFTROWS7: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS8: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS9: begin
				shift_in = mix_out;
			end
			INV_SHIFTROWS10: begin
				shift_in = mix_out;
			end
			
			INV_SUBBYTES1: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES2: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES3: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES4: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES5: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES6: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES7: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES8: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES9: begin
				sub_in = shift_out;
			end
			INV_SUBBYTES10: begin
				sub_in = shift_out;
			end
			
			INV_MIXCOLUMNS1_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS1_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS1_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS1_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS1_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS1_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS1_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS1_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS2_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS2_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS2_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS2_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS2_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS2_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS2_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS2_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS3_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS3_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS3_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS3_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS3_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS3_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS3_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS3_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS4_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS4_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS4_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS4_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS4_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS4_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS4_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS4_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS5_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS5_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS5_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS5_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS5_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS5_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS5_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS5_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS6_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS6_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS6_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS6_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS6_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS6_3_1: begin
				mix_out[64:95] = mixout;
			end
	
			INV_MIXCOLUMNS6_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS6_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS7_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS7_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS7_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS7_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS7_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS7_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS7_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS7_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			INV_MIXCOLUMNS8_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS8_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS8_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS8_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS8_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS8_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS8_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS8_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			//
			
			INV_MIXCOLUMNS9_1: begin
				mixin = {add_out[0:7], add_out[32:39], add_out[64:71], add_out[96:103]};
			end
			INV_MIXCOLUMNS9_1_1: begin
				mix_out[0:31] = mixout;
			end
			
			INV_MIXCOLUMNS9_2: begin
				mixin = {add_out[8:15], add_out[40:47], add_out[72:79], add_out[104:111]};
			end
			INV_MIXCOLUMNS9_2_1: begin
				mix_out[32:63] = mixout;
			end
			
			INV_MIXCOLUMNS9_3: begin
				mixin = {add_out[16:23], add_out[48:55], add_out[80:87], add_out[112:119]};
			end
			INV_MIXCOLUMNS9_3_1: begin
				mix_out[64:95] = mixout;
			end
		
			INV_MIXCOLUMNS9_4: begin
				mixin = {add_out[24:31], add_out[56:63], add_out[88:95], add_out[120:127]};
			end
			INV_MIXCOLUMNS9_4_1: begin
				mix_out[96:127] = mixout;
			end
			
			FINISH: begin
				Ready = 1'b1;
			end
			
		endcase
	end
	
	assign Plaintext = add_out;
	
endmodule
