
%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <iostream>
	#include <math.h>

	void yyerror(char *s);
	int yylex();
	extern FILE* yyin;
    float PI = 3.14159265359;

   int counter = 0;
   
	
%}
%union
{
double dtype;
int itype;
std::string *x;
char c;

}


%verbose 


%token PLUS TIMES EQUAL SUBSTRACT  DIVIDE POWER SIN COS INT SEMICOLON INT DOUBLE CHAR STRING
%token<dtype> NUMBER 
%token<itype> NUMBERINT
%type<x> convert
%token<x> ZMIENNA
%token<c> CHARVAL
%token<x> STRINGVAL 
%left SUBSTRACT PLUS	
%left DIVIDE TIMES
%left POWER
%left SIN COS

%%

convert:
    // C to Python
      INT ZMIENNA EQUAL NUMBERINT SEMICOLON    { std::cout << *$2 << " = " << $4 << std::endl; }
    | DOUBLE ZMIENNA EQUAL NUMBER SEMICOLON    { std::cout << *$2 << " = " << $4 << std::endl; }
    | CHAR ZMIENNA EQUAL CHARVAL SEMICOLON     { std::cout << *$2 << " = '" << $4 << "'" << std::endl; }
    | STRING ZMIENNA EQUAL STRINGVAL SEMICOLON { std::cout << *$2 << " = " << *$4 << std::endl; }

    // Python to C
    | ZMIENNA EQUAL NUMBERINT                  { std::cout << "int " << *$1 << " = " << $3 << ";" << std::endl; }
    | ZMIENNA EQUAL NUMBER                     { std::cout << "double " << *$1 << " = " << $3 << ";" << std::endl; }
    | ZMIENNA EQUAL CHARVAL                    { std::cout << "char " << *$1 << " = '" << $3 << "';" << std::endl; }
    | ZMIENNA EQUAL STRINGVAL                  { std::cout << "string " << *$1 << " = " << *$3 << ";" << std::endl; }
;

	
%%

void yyerror(char *s) 
{
    fprintf(stderr, "%s\n", s);
}

int main() 
{
    std::ios_base::sync_with_stdio (true);
    yyparse();    
    return 0;
}
