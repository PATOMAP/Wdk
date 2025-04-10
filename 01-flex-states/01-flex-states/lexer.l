%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int fileCount = 0;
int fileCountITC = 0;
bool flagItc = false;
int sumInFile=0;

	#define MAX 100
	YY_BUFFER_STATE buffer[MAX];
	int fileIndex = 0;
%}

%x COMMENT
%x INCLUDE
%s COUNT
CHARS [a-zA-Z0-9]+
%%
[0-9]+ {
        if(flagItc)
        {
            sumInFile=sumInFile+atoi(yytext);
        }
        else{
            printf("%s",yytext);
        }
    }
^.{133,}$          { printf("Za dużo znaków: %s\n", yytext); }
<INCLUDE>{
[ \t\\#"<>{}]*		;
{CHARS}"."{CHARS}">"? 	{
        if (yytext[yyleng - 1] == '>') {
        yytext[yyleng - 1] = '\0'; // ucinamy > jeśli jest
      }
                        char *po_kropce = strchr(yytext, '.');
                        char itc[]="itc";
                        po_kropce++;
                        if(strcmp(po_kropce, itc) == 0)
                        {
                            flagItc=true;
                        }
                        printf("Rozszerzenie: %s\n",po_kropce);
						printf("Plik: %s\n", yytext);
						buffer[fileIndex++] = YY_CURRENT_BUFFER;
						yyin = fopen(yytext, "r");
						yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
						BEGIN(INITIAL);
					}
}

<<EOF>> {
     fileCount++;
        if (fileIndex == 0)
        {
            printf("\nKoniec pliku głównego!\nPrzetworzono %d plik(ów)\n",fileCount);
            yyterminate();
        }
        else
        {
            if(flagItc==true)
            {
                fileCountITC++;
                 printf("\nPrzetworzono  %d plik(ów) ITC\n",fileCountITC);
                 printf("\nSuma liczb w pliku %d\n",sumInFile);
                 sumInFile=0;
                 flagItc=false;

            }
            printf("\nKoniec pliku wczytanego!\nPrzetworzono %d plik(ów)\n",fileCount);
            yy_delete_buffer(YY_CURRENT_BUFFER);
            yy_switch_to_buffer(buffer[--fileIndex]);
        }
}

"//".* ;
"/*"               { BEGIN(COMMENT); }                    // Komentarz wieloliniowy
"include"			{BEGIN(INCLUDE);}
<COMMENT>[^*\n]*   ;                                      // Ignoruj treść komentarza
<COMMENT>"*"+[^*/\n]* ;                                   // Ignoruj gwiazdki
<COMMENT>"*"+"/"   { BEGIN(INITIAL); }                    // Koniec komentarza




%%

int yywrap(void) {
    return 1; // kończymy skanowanie danego pliku
}



int main() {

	yyin = fopen("lorem.txt", "r");
	if (yyin != NULL)
	{
		yylex();		/* start lexer analyser */
	}
	fclose(yyin);

}
