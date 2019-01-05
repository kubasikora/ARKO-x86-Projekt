#include <stdio.h>
#include"../examples.h"

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}	
	int ret = issue6(argv[1]);
	printf("%d\n", ret);
	return 0;
}
