
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
}


%verbose 


%token PLUS TIMES EQUAL SUBSTRACT  DIVIDE POWER SIN COS LPAREN RPAREN
%token<dtype> NUMBER
%type<dtype> total expression
%type<x> convert
%token<x> ZMIENNA

%left SUBSTRACT PLUS	
%left DIVIDE TIMES
%left POWER
%left SIN COS

%%

total      : expression EQUAL                {  std::cout <<  $1 << std::endl;   }
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
           | NUMBER                          {  $$ = $1;   }
           ;




            convert : ZMIENNA EQUAL ZMIENNA  {std::cout << "To zmienna" << std::endl; }
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
