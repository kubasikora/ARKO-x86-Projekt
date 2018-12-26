#include <stdio.h>
#include"issue1.h"

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}	
	issue1(argv[1]);
	printf(argv[1]);
	printf("\n");
	return 0;
}
