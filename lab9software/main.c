#include "AES.h"
#include "keyexpansion.h"
#include <stdio.h>

int main() {
	int Nk = 4;
	int Nb = 4;
	int Nr = 10;
	unsigned char key[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F};
	//unsigned char key[16] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	unsigned char decrypted_message[16] = { 0xEC, 0xE2, 0x98, 0xDC, 0xEC, 0xE2, 0x98, 0xDC, 0xEC, 0xE2, 0x98, 0xDC, 0xEC, 0xE2, 0x98, 0xDC };
	unsigned char encrypted_message[16];
	unsigned long key_expansion[44];
	KeyExpansion(key, key_expansion, Nk);
	int j;
	for (j = 0; j < 4; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 4; j < 8; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 8; j < 12; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 12; j < 16; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 16; j < 20; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 20; j < 24; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 24; j < 28; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	AES(decrypted_message, encrypted_message, key_expansion);
	int i;
	for (i = 0; i < 16; i++)
	{
		printf("%x", encrypted_message[i]);
	}
	printf("\n");
	return 0;
}
