
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
}


%verbose 


%token PLUS TIMES EQUAL SUBSTRACT  DIVIDE POWER SIN COS 
%token<dtype> NUMBER 
%token<itype> NUMBERINT
%type<x> convert
%token<x> ZMIENNA

%left SUBSTRACT PLUS	
%left DIVIDE TIMES
%left POWER
%left SIN COS

%%

            convert : ZMIENNA EQUAL ZMIENNA  {std::cout << " to string" << std::endl;  }
            |  ZMIENNA EQUAL NUMBER {std::cout << " to liczba" << std::endl;  }
            |  ZMIENNA EQUAL NUMBERINT {
                $$ = "int "+$1+" "+$2+" "+$3;
                std::cout << zm << std::endl;  
                }
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
