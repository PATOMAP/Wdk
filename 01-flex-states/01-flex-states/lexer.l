%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int fileCount = 0;//zliczanie liczby plików
int fileCountITC = 0;//ziczanie plików itc
bool flagItc = false;//gdy jest odczyt plik ITC
int sumInFile=0;//suma z pliku itc

	#define MAX 100
	YY_BUFFER_STATE buffer[MAX];
	int fileIndex = 0;//indeks który plik odczytujemy
%}

%x COMMENT
%x INCLUDE
CHARS [a-zA-Z0-9]+
%%
[0-9]+ {
        if(flagItc)
        {
            sumInFile=sumInFile+atoi(yytext);//zliczanie sumy liczb w pliku itc
        }
        else{
            printf("%s",yytext);
        }
    }
^.{133,}$          { printf("Za dużo znaków: %s\n", yytext); } //gdy w lini występuję więcej niż 144 znaki
<INCLUDE>{
[ \t\\#"<>{}]*		;              //ucinanie w przypadku wystąpienia znaku po include 
{CHARS}"."{CHARS}">"? 	{          //pliku z includa
        if (yytext[yyleng - 1] == '>') {
        yytext[yyleng - 1] = '\0'; // ucinanie w przypadku wystąpienia > np. include <plik.txt>
      }
                        char *po_kropce = strchr(yytext, '.');//znajdowanie rozszerzenia
                        char itc[]="itc";
                        po_kropce++;
                        if(strcmp(po_kropce, itc) == 0)//porównanie rozszerzenia jesli jest to itc ustawia flage
                        {
                            flagItc=true;
                        }
						printf("Plik: %s\n", yytext);
                        printf("Rozszerzenie: %s\n",po_kropce);
						buffer[fileIndex++] = YY_CURRENT_BUFFER;  // ustawienie aktualnego buffera
						yyin = fopen(yytext, "r"); //odczytanie nowego pliku wewnątrz innego
						yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE)); //wybranie bufera do dalszego skanowania
						BEGIN(INITIAL);
					}
}

<<EOF>> {
     fileCount++;//zliczanie plików
        if (fileIndex == 0)
        {
            printf("\nKoniec pliku głównego!\nPrzetworzono %d plik(ów)\n",fileCount);//potwierdzenie zakończenia anlizowania pliku głównego
            yyterminate();
        }
        else
        {
            if(flagItc==true)
            {
                fileCountITC++;
                 printf("\nPrzetworzono  %d plik(ów) ITC\n",fileCountITC);//potwierdzenie zakończenia anlizowania pliku gspecjalnego itc,ilość plików znalizowanych specjalnych
                 printf("\nSuma liczb w pliku %d\n",sumInFile);//suma wszystkich liczb w pliku itc
                 sumInFile=0;
                 flagItc=false;

            }
            printf("\nKoniec pliku wczytanego!\nPrzetworzono %d plik(ów)\n",fileCount); //potwierdzenie zakończenia anlizowania pliku,ilość plików znalizowanych
            yy_delete_buffer(YY_CURRENT_BUFFER);//usuniecie obecnego buffera
            yy_switch_to_buffer(buffer[--fileIndex]);//przelączenie do poprzedniego buffera
        }
}

"//".* ;                                                  //Komentarz jednoliniowy ignoruje
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

	yyin = fopen("Plik.txt", "r");//otwarcie pliku początkowego
	if (yyin != NULL)
	{
		yylex();		
	}
	fclose(yyin);

}
