#include <stdio.h>
#include"../arko-test.h"

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}	
	zad1(argv[1]);
	printf("%s\n", argv[1]);
	return 0;
}
