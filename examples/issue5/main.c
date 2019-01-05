#include <stdio.h>
#include"../examples.h"

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}	
	argv[1] = issue5(argv[1]);
	printf("%s\n", argv[1]);
	return 0;
}
