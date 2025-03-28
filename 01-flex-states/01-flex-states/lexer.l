%{
#include <stdio.h>

int fileCount = 0;

%}
%x COMMENT
%%

<<EOF>> { 
    fileCount++;
    printf("Przetworzono %d plików\n", fileCount);
    yyterminate();
}
"//" { BEGIN(COMMENT); }    /* Komentarz jednoliniowy */
"/*" { BEGIN(COMMENT); }    /* Komentarz wieloliniowy */

<COMMENT>[^*\n]*   ;        /* Ignorowanie treści komentarza */
<COMMENT>"*"+[^*/\n]*   ;   /* Ignorowanie gwiazdek */
<COMMENT>"*"+"/" { BEGIN(INITIAL); }  /* Koniec komentarza */
^.{133,}$ {printf("Za duzo znakow:%s",yytext);}
%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
       const char*file="task.txt";
        yylex();
        yyin = fopen(file, "r");
        if (!yyin) {
            printf("Nie można otworzyć pliku: %s\n", file);
            return 1;
        }
    

    
    return 0;
}
