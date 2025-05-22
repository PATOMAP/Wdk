
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
    std::string *x;
    char c;  // dla CHARVAL

}


%verbose 


%token PLUS TIMES EQUAL SUBSTRACT  DIVIDE POWER SIN COS INT SEMICOLON  DOUBLE CHAR STRING
%token  LPAREN RPAREN
%token<dtype> NUMBER 
%type<x> convert 
%type<dtype> expression
%token<x> ZMIENNA
%token<c> CHARVAL
%token<x> STRINGVAL 
%left SUBSTRACT PLUS	
%left DIVIDE TIMES
%left POWER
%left SIN COS

%%

convert:
    
    INT ZMIENNA EQUAL expression SEMICOLON {
        std::cout << "To jest (int) zmiennej: int " << *$2 << " = " << $4 <<";"<< std::endl;
    }
  | DOUBLE ZMIENNA EQUAL expression SEMICOLON {
        std::cout << "To jest (double) zmiennej: double " << *$2 << " = " << $4 <<";"<< std::endl;
    }
  | CHAR ZMIENNA EQUAL CHARVAL SEMICOLON {
        std::cout << "To jest (char) zmiennej: char " << *$2 << " = '" << $4 << "';"<<std::endl;
    }
  | STRING ZMIENNA EQUAL STRINGVAL SEMICOLON {
        std::cout << "To jest (string) zmiennej: string " << *$2 << " = " << *$4 <<";"<<std::endl;
    }
  | INT TIMES ZMIENNA EQUAL expression SEMICOLON {
        std::cout << "To jest (int*) zmiennej: int* " << *$3 << " = " << $5 << ";" << std::endl;
    }
  | DOUBLE TIMES ZMIENNA EQUAL expression SEMICOLON {
        std::cout << "To jest (double*) zmiennej: double* " << *$3 << " = " << $5 << ";" << std::endl;
    }
  | CHAR TIMES ZMIENNA EQUAL CHARVAL SEMICOLON {
        std::cout << "To jest (char*) zmiennej: char* " << *$3 << " = '" << $5 << "';" << std::endl;
    }
  | STRING TIMES ZMIENNA EQUAL STRINGVAL SEMICOLON {
        std::cout << "To jest (string*) zmiennej: string* " << *$3 << " = " << *$5 << ";" << std::endl;
    }
;

expression : expression PLUS  expression      {  $$ =  $1 + $3;   }
           | expression TIMES  expression     {  $$ = $1 * $3;   } 
           | expression SUBSTRACT expression  {  $$ = $1 - $3;   } 
           | expression POWER expression      {  $$ = pow($1,$3);   } 
           | SIN expression      {  $$ = sin($2*M_PI/180);   } 
           | COS expression      {  $$ = cos($2*M_PI/180);   } 
           | LPAREN expression RPAREN { $$ = $2; }
           | expression DIVIDE expression     
           {  
            if($3!=0)
            {
                          $$ = $1 / $3;  
            }
            else
            {
                       yyerror("Divison by 0 !");
                       
            }
 
            }  
           | NUMBER                          
           {
            $$ = $1;   }
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
