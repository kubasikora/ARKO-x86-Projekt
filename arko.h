#ifndef __ARKO_H_
#define __ARKO_H_

#define MAX_POINTS 5


/**
 *  Funkcja bezier odrysowuje na podanej bitmapie 
 *  krzywą Beziera maksymalnie czwartego stopnia 
 *  (do pięciu punktów).
 *  Argumenty funkcji:
 *      - wskaźnik na bitmapę
 *      - liczba punktów z których należy odrysować bitmapę
 *      - wskaźnik na tablicę punktów (x,y)
 **/ 

#ifdef FLOAT
float bezier(unsigned char*, int, int*, int*);
#else
unsigned char* bezier(unsigned char*, int, int*, int*);
#endif //FLOAT

/**
 *  Struktura Points przechowuje informację o 
 *  kliknięciach użytkownika. Przechowuje ilość punktów,
 *  miejsce następnego zapisu oraz tablice x i y.
 **/ 
typedef struct Points {
    int num;
    int cursor;
    int x[MAX_POINTS];
    int y[MAX_POINTS];
} Points;

#endif // __ARKO_H_
