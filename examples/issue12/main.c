#include <stdio.h>
#include"../examples.h"

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}	
	char* result = issue12(argv[1]);
	printf("%s\n", result);
	return 0;
}
