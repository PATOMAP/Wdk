
 


%option noyywrap

%{
   #include <stdlib.h> 
   #include <iostream>
	#include "parser.tab.h"
%}
 
%%
[0-9]+ { yylval.dtype = atoi(yytext); return NUMBERINT; }
[0-9]+(\.[0-9]*)? { yylval.dtype = atof(yytext); return NUMBER; }
"*"            return TIMES;
"+"            return PLUS;
=              return EQUAL;
"-"            return SUBSTRACT;
"/"            return DIVIDE;
"pow"          return POWER;
"sin"            return SIN;  
"cos"            return COS;
[a-zA-Z0-9]+      { yylval.x = new std::string(yytext); return ZMIENNA; }   
.              /* remove other characters */
            

%%
