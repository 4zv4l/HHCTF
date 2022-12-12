#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>

#define LEN(X) (sizeof(X)/sizeof(*X))

static void
caesar(char *str, size_t len, int ciph)
{
    ciph%=26;
    for(size_t i = 0; i < len; i++) {
        unsigned char c = str[i];
        if(c >= 'A' && c <= 'Z') {
            c += ciph;
            if(c > 'Z') c -= 'Z' - 'A' + 1;
        } else if (c >= 'a' && c <= 'z') {
            c += ciph;
            if(c > 'z') c -= 'z' - 'a' + 1;
        }
        str[i] = c;
    }
}

extern int
main(void)
{
    srand(6666);
    char *str[] = {
        strdup("TTOFR{"),
        strdup("NlpDlc"),
        strdup("_sc_"),
        strdup("OdW}"),
    };
    int r = rand();
    for(size_t i = 0; i < LEN(str); i++)
        if(!str[i]) return 1;
    for(size_t i = 0; i < LEN(str); i++)
        caesar(str[i], strlen(str[i]), r++);
    for(size_t i = 0; i < LEN(str); i++) {
        printf("%s", str[i]);
        free(str[i]);
    }
}
