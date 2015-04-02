/*
 * AES.h
 *
 *  Created on: Apr 1, 2015
 *      Author: jwang118
 */

#ifndef AES_H_
#define AES_H_

void AES(unsigned char in[16], unsigned char out[16], unsigned long w[44]);
void AddRoundKey(unsigned char state[16], unsigned long word[4]);
void SubBytes(unsigned char state[16]);
void MixColumns(unsigned char state[16]);
void ShiftRows(unsigned char state[16]);
unsigned char gmul(unsigned char a, unsigned char b);
char charToHex(char c);
char charsToHex(char c1, char c2);

#endif /* AES_H_ */
