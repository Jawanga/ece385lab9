module AddRoundKey ( input		[0:127] in,
					 input		[0:127] key,
					output logic [0:127] out );
	/*
	assign out[0:7] = in[0:7] ^ key[0:7];
	assign out[8:15] = in[8:15] ^ key[32:39];
	assign out[16:23] = in[16:23] ^ key[64:71];
	assign out[24:31] = in[24:31] ^ key[96:103];
	
	assign out[32:39] = in[32:39] ^ key[8:15];
	assign out[40:47] = in[40:47] ^ key[40:47];
	assign out[48:55] = in[48:55] ^ key[72:79];
	assign out[56:63] = in[56:63] ^ key[104:111];
	
	assign out[64:71] = in[64:71] ^ key[16:23];
	assign out[72:79] = in[72:79] ^ key[48:55];
	assign out[80:87] = in[80:87] ^ key[80:87];
	assign out[88:95] = in[88:95] ^ key[112:119];
	
	assign out[96:103] = in[96:103] ^ key[24:31];
	assign out[104:111] = in[104:111] ^ key[56:63];
	assign out[112:119] = in[112:119] ^ key[88:95];
	assign out[120:127] = in[120:127] ^ key[120:127];
	*/
	
	assign out[0:7] = in[0:7] ^ key[24:31];
	assign out[8:15] = in[8:15] ^ key[56:63];
	assign out[16:23] = in[16:23] ^ key[88:95];
	assign out[24:31] = in[24:31] ^ key[120:127];
	
	assign out[32:39] = in[32:39] ^ key[16:23];
	assign out[40:47] = in[40:47] ^ key[48:55];
	assign out[48:55] = in[48:55] ^ key[80:87];
	assign out[56:63] = in[56:63] ^ key[112:119];
	
	assign out[64:71] = in[64:71] ^ key[8:15];
	assign out[72:79] = in[72:79] ^ key[40:47];
	assign out[80:87] = in[80:87] ^ key[72:79];
	assign out[88:95] = in[88:95] ^ key[104:111];
	
	assign out[96:103] = in[96:103] ^ key[0:7];
	assign out[104:111] = in[104:111] ^ key[32:39];
	assign out[112:119] = in[112:119] ^ key[64:71];
	assign out[120:127] = in[120:127] ^ key[96:103];
	
endmodule	
	