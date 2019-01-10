#ifndef __F_H_
#define __F_H_

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
char* bezier(char*, int, int*); 

typedef struct Points {
    int num;
    int cursor;
    int x[MAX_POINTS];
    int y[MAX_POINTS];
} Points;

#endif // __F_H_
