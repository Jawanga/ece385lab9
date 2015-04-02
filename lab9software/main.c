#include "AES.h"
#include "keyexpansion.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
	int Nk = 4;
	int Nb = 4;
	int Nr = 10;
	unsigned char key[33];
	unsigned char decrypted_message[33];
	unsigned char encrypted_message[16];
	unsigned char key_test[32];
	unsigned char decrypted_message_test[32];
	unsigned char pairs[16];
	unsigned char key_pairs[16];
	unsigned char pairs_hex[16];
	unsigned char key_pairs_hex[16];
	unsigned long key_expansion[44];
	unsigned char test[4] = { 0xdb, 0x13, 0x53, 0x45 };
	int i, k;

	/*
	for (k = 0; k < 4; k++)
	{
	printf("%x", test[k]);
	}
	printf("\n");
	MixColumns(test);
	for (k = 0; k < 4; k++)
	{
	printf("%x", test[k]);
	}
	printf("\n");
	*/

	/*
	printf("Enter Decrypted Message: ");
	scanf("%s", &decrypted_message_test);
	printf("\n");
	printf("Enter Key: ");
	scanf("%s", &key_test);

	for (i = 0; i < 16; i++)
	{
		pairs_hex[i] = charsToHex(decrypted_message_test[2*i], decrypted_message_test[2*i + 1]);
	}

	for (i = 0; i < 16; i++)
	{
		key_pairs_hex[i] = charsToHex(key_test[2*i], key_test[2*i + 1]);
	}
	
	for (i = 0; i < 16; i++)
	{
		printf("%x", pairs_hex[i]);
	}
	printf("\n");
	for (i = 0; i < 16; i++)
	{
		printf("%x", key_pairs_hex[i]);
	}
	printf("\n");
	*/

	/*
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
	for (j = 28; j < 32; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 32; j < 36; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 36; j < 40; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	for (j = 40; j < 44; j++) {
		printf("%x", key_expansion[j]);
	}
	printf("\n");
	*/
	printf("Enter Decrypted Message: ");
	scanf("%s", &decrypted_message);
	printf("\n");
	printf("Enter Key: ");
	scanf("%s", &key);

	for (i = 0; i < 16; i++)
	{
		pairs_hex[i] = charsToHex(decrypted_message[2 * i], decrypted_message[2 * i + 1]);
	}

	for (i = 0; i < 16; i++)
	{
		key_pairs_hex[i] = charsToHex(key[2 * i], key[2 * i + 1]);
	}
	
	KeyExpansion(key_pairs_hex, key_expansion, Nk);

	AES(pairs_hex, encrypted_message, key_expansion);
	for (i = 0; i < 16; i++)
	{
		printf("%x", encrypted_message[i]);
	}
	printf("\n");
	return 0;
}
