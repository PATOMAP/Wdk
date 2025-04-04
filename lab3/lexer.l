
 


%option noyywrap

%{
   #include <stdlib.h> 
   #include <iostream>
	#include "parser.tab.h"
%}
 
%%

[0-9]+         { /* int */ yylval =  atoi(/* char* */ yytext);  return NUMBER; } 
"*"            return TIMES;
"+"            return PLUS;
=              return EQUAL;
"-"            return SUBSTRACT;
"/"            return DIVIDE;
"pow"          return POWER;
.              /* remove other characters */
              

%%
