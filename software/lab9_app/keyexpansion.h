/*
 * keyexpansion.h
 *
 *  Created on: Apr 1, 2015
 *      Author: jwang118
 */

#ifndef KEYEXPANSION_H_
#define KEYEXPANSION_H_

#ifndef KEYEXPANSION_H_
#define KEYEXPANSION_H_

void KeyExpansion(unsigned char key[16], unsigned long w[44], int Nk);
unsigned long SubWord(unsigned long word);
unsigned long RotWord(unsigned long word);

#endif /* KEYEXPANSION_H_ */


#endif /* KEYEXPANSION_H_ */
