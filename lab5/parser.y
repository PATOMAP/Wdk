
%{
	#include <stdio.h>
	#include <iostream>
	#include <math.h>
    #include <stdlib.h>
    #include "parser.tab.h"

    extern int yylex(); // Deklaracja yylex
    void yyerror(const char *s);
    extern FILE *yyin; // Deklaracja yyin
	
%}
%union
{


}


%verbose 



%token REF RREF STAR LPAREN RPAREN LBRACKET RBRACKET COMMA COLON SEMICOLON NUMBER  INT DOUBLE CONST CHAR VOID CONSTEXP IDENTIFIER
%start function_declaration
%%

function_declaration:
    simple_type IDENTIFIER LPAREN parameter_list RPAREN SEMICOLON { printf("OK\n"); }
    | simple_type IDENTIFIER LPAREN RPAREN SEMICOLON { printf("OK\n"); }
    | IDENTIFIER LPAREN RPAREN COLON simple_type SEMICOLON { printf("ERROR\n"); }
    | complex_type IDENTIFIER LPAREN parameter_list RPAREN SEMICOLON { printf("OK\n"); }
    ;

type:
    simple_type
    | complex_type
    ;

simple_type:
    INT
    | DOUBLE
    | CHAR
    | VOID
    ;

complex_type:
    CONST type
    | type STAR
    | type REF
    | type RREF
    ;

parameter_list:
    parameter
    | parameter_list COMMA parameter
    ;

parameter:
    type IDENTIFIER
    | type
    ;

	
%%

void yyerror(const char *s) 
{
    fprintf(stderr, "Error: %s\n", s);
}

int main() 
{
    std::ios_base::sync_with_stdio(true);

    FILE *file = fopen("in.txt", "r");
    if (!file) {
        perror("Nie można otworzyć pliku in.txt");
        return 1;
    }
    yyin = file; // Ustawienie yyin na plik in.txt

    yyparse();    

    fclose(file); // Zamknięcie pliku po zakończeniu
    return 0;
}
