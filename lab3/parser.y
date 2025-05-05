
%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <iostream>
	#include <math.h>

	void yyerror(char *s);
	int yylex();
	extern FILE* yyin;

   int counter = 0;
	
%}

%verbose 

%token PLUS TIMES NUMBER EQUAL SUBSTRACT DIVIDE POWER SQRT
%left SUBSTRACT PLUS	
%left DIVIDE TIMES
%left POWER SQRT
%%

total      : expression EQUAL                {  std::cout <<  $1 << std::endl;   }
           ;

expression : expression PLUS  expression      {  $$ = $1 + $3;   }
           | expression TIMES  expression     {  $$ = $1 * $3;   } 
           | expression SUBSTRACT expression  {  $$ = $1 - $3;   } 
           | expression POWER expression      {  $$ = pow($1,$3);} 
           | SQRT expression                  {  $$ = sqrt($2);  } 
           | expression DIVIDE expression     
           {  
            if($2!=0)
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
