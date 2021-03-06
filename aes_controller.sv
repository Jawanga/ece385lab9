/*---------------------------------------------------------------------------
  --      aes_controller.sv                                                --
  --      Christine Chen                                                   --
  --      10/29/2013                                                       --
  --                                                                       --
  --      For use with ECE 298 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/
// AES controller module

module aes_controller(
				input			 		clk,
				input					reset_n,
				input	[127:0]			msg_en,
				input	[127:0]			key,
				output logic [127:0]			msg_de,
				input					io_ready,
				output logic					aes_ready
			    );

enum logic [1:0] {WAIT, COMPUTE, READY} state, next_state;
logic start_aes;
logic aes_done;

invAES invaes0(.clk, .Reset(reset_n), .Run(start_aes), .Cipherkey(key), .Ciphertext(msg_en), .Plaintext(msg_de), .Ready(aes_done));
			  
always_ff @ (posedge clk, negedge reset_n) begin
	if (reset_n == 1'b0) begin
		state <= WAIT;
	end else begin
		state <= next_state;
	end
end

always_comb begin
	next_state = state;
	case (state)
		WAIT: begin
			if (io_ready)
				next_state = COMPUTE;
		end
		
		COMPUTE: begin
			if (aes_done)
				next_state = READY;
		end
		
		READY: begin
		end
	endcase
end

always_comb begin
	aes_ready = 1'b0;
	start_aes = 1'b0;
	case (state)
		WAIT: begin
			aes_ready = 1'b0;
			start_aes = 1'b0;
		end
		
		COMPUTE: begin
			aes_ready = 1'b0;
			start_aes = 1'b1;
		end
		
		READY: begin
			aes_ready = 1'b1;
			start_aes = 1'b0;
		end
	endcase
end
			  
endmodule