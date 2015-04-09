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
						 output	[127:0]	Plaintext,
						 output				Ready);					 
					 
	logic [0:1407] keyschedule;
	enum logic [6:0] {WAIT, FINISH, INV_ADDROUND1, INV_ADDROUND2, INV_ADDROUND3, INV_ADDROUND4, INV_ADDROUND5, INV_ADDROUND6, INV_ADDROUND7, INV_ADDROUND8, INV_ADDROUND9, INV_ADDROUND10, INV_ADDROUND11,
							INV_SHIFTROWS1, INV_SHIFTROWS2, INV_SHIFTROWS3, INV_SHIFTROWS4, INV_SHIFTROWS5, INV_SHIFTROWS6, INV_SHIFTROWS7, INV_SHIFTROWS8, INV_SHIFTROWS9, INV_SHIFTROWS10,
							INV_SUBBYTES1, INV_SUBBYTES2, INV_SUBBYTES3, INV_SUBBYTES4, INV_SUBBYTES5, INV_SUBBYTES6, INV_SUBBYTES7, INV_SUBBYTES8, INV_SUBBYTES9, INV_SUBBYTES10,
							INV_MIXCOLUMNS1_1, INV_MIXCOLUMNS1_2, INV_MIXCOLUMNS1_3, INV_MIXCOLUMNS1_4, INV_MIXCOLUMNS2_1, INV_MIXCOLUMNS2_2, INV_MIXCOLUMNS2_3, INV_MIXCOLUMNS2_4, 
							INV_MIXCOLUMNS3_1, INV_MIXCOLUMNS3_2, INV_MIXCOLUMNS3_3, INV_MIXCOLUMNS3_4, INV_MIXCOLUMNS4_1, INV_MIXCOLUMNS4_2, INV_MIXCOLUMNS4_3, INV_MIXCOLUMNS4_4,
							INV_MIXCOLUMNS5_1, INV_MIXCOLUMNS5_2, INV_MIXCOLUMNS5_3, INV_MIXCOLUMNS5_4, INV_MIXCOLUMNS6_1, INV_MIXCOLUMNS6_2, INV_MIXCOLUMNS6_3, INV_MIXCOLUMNS6_4,
							INV_MIXCOLUMNS7_1, INV_MIXCOLUMNS7_2, INV_MIXCOLUMNS7_3, INV_MIXCOLUMNS7_4, INV_MIXCOLUMNS8_1, INV_MIXCOLUMNS8_2, INV_MIXCOLUMNS8_3, INV_MIXCOLUMNS8_4,
							INV_MIXCOLUMNS9_1, INV_MIXCOLUMNS9_2, INV_MIXCOLUMNS9_3, INV_MIXCOLUMNS9_4} state, next_state;
	
					 
	KeyExpansion keyexpansion_0(
	.*, .Cipherkey,
	.KeySchedule(keyschedule));
	
	
	
	InvShiftRows(
					 				 
	always_ff @ (posedge clk, negedge reset_n) 
	begin
		if (reset_n == 1'b0)
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
				next_state = INV_MIXCOLUMNS1_2;
			end
			
			INV_MIXCOLUMNS1_2: begin
				next_state = INV_MIXCOLUMNS1_3;
			end
			
			INV_MIXCOLUMNS1_3: begin
				next_state = INV_MIXCOLUMNS1_4;
			end
			
			INV_MIXCOLUMNS1_4: begin
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
				next_state = INV_MIXCOLUMNS2_2;
			end
			
			INV_MIXCOLUMNS2_2: begin
				next_state = INV_MIXCOLUMNS2_3;
			end
			
			INV_MIXCOLUMNS2_3: begin
				next_state = INV_MIXCOLUMNS2_4;
			end
			
			INV_MIXCOLUMNS2_4: begin
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
				next_state = INV_MIXCOLUMNS3_2;
			end
			
			INV_MIXCOLUMNS3_2: begin
				next_state = INV_MIXCOLUMNS3_3;
			end
			
			INV_MIXCOLUMNS3_3: begin
				next_state = INV_MIXCOLUMNS3_4;
			end
			
			INV_MIXCOLUMNS3_4: begin
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
				next_state = INV_MIXCOLUMNS4_2;
			end
			
			INV_MIXCOLUMNS4_2: begin
				next_state = INV_MIXCOLUMNS4_3;
			end
			
			INV_MIXCOLUMNS4_3: begin
				next_state = INV_MIXCOLUMNS4_4;
			end
			
			INV_MIXCOLUMNS4_4: begin
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
				next_state = INV_MIXCOLUMNS5_2;
			end
			
			INV_MIXCOLUMNS5_2: begin
				next_state = INV_MIXCOLUMNS5_3;
			end
			
			INV_MIXCOLUMNS5_3: begin
				next_state = INV_MIXCOLUMNS5_4;
			end
			
			INV_MIXCOLUMNS5_4: begin
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
				next_state = INV_MIXCOLUMNS6_2;
			end
			
			INV_MIXCOLUMNS6_2: begin
				next_state = INV_MIXCOLUMNS6_3;
			end
			
			INV_MIXCOLUMNS6_3: begin
				next_state = INV_MIXCOLUMNS6_4;
			end
			
			INV_MIXCOLUMNS6_4: begin
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
				next_state = INV_MIXCOLUMNS7_2;
			end
			
			INV_MIXCOLUMNS7_2: begin
				next_state = INV_MIXCOLUMNS7_3;
			end
			
			INV_MIXCOLUMNS7_3: begin
				next_state = INV_MIXCOLUMNS7_4;
			end
			
			INV_MIXCOLUMNS7_4: begin
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
				next_state = INV_MIXCOLUMNS8_2;
			end
			
			INV_MIXCOLUMNS8_2: begin
				next_state = INV_MIXCOLUMNS8_3;
			end
			
			INV_MIXCOLUMNS8_3: begin
				next_state = INV_MIXCOLUMNS8_4;
			end
			
			INV_MIXCOLUMNS8_4: begin
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
				next_state = INV_MIXCOLUMNS9_2;
			end
			
			INV_MIXCOLUMNS9_2: begin
				next_state = INV_MIXCOLUMNS9_3;
			end
			
			INV_MIXCOLUMNS9_3: begin
				next_state = INV_MIXCOLUMNS9_4;
			end
			
			INV_MIXCOLUMNS9_4: begin
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
	
	always_comb begin
		Ready = 1'b0;
		unique case (state)
			FINISH: begin
				Ready = 1'b1;
			end
		endcase
endmodule
