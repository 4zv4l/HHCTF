#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char** argv){
    if(argc != 2){
        printf("Usage : <Key>\n");
    } else {
        printf("analyse the key...\n");
        srand(0);
        int sum = 0;
        for(int i=0; i<strlen(argv[1]);i++){
            sum += argv[1][i];
        }
        if(sum == rand()){
            int b[5] = {0x48,0x42,0x51,0x47,0x52};
            for(int i=0;i<sizeof(argv[1]);i++){
                argv[1][i] = 	(char)b[(rand()%5)];
            }
            printf("HHCTF{%s}\n", argv[1]);
        } else{
            printf("Wrong key!\n");
        }
    }
    return 0;
}
