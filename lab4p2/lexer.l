
 


%option noyywrap

%{
   #include <stdlib.h> 
   #include <iostream>
	#include "parser.tab.h"
%}
 
%%
"int"       { return INT; }
"double"    { return DOUBLE; }
"char"      { return CHAR; }
"string"    { return STRING; }

[0-9]+\.[0-9]*     { yylval.dtype = atof(yytext); return NUMBER; }
[0-9]+             { yylval.itype = atoi(yytext); return NUMBERINT; }
\'[a-zA-Z0-9]\'     { yylval.c = yytext[1]; return CHARVAL; }
\"[^\"]*\"         { yylval.x = new std::string(yytext); return STRINGVAL; }
"*"            return TIMES;
"+"            return PLUS;
=              return EQUAL;
";"         { return SEMICOLON; }
"-"            return SUBSTRACT;
"/"            return DIVIDE;
"pow"          return POWER;
"sin"            return SIN;  
"cos"            return COS;
[a-zA-Z0-9]+      { yylval.x = new std::string(yytext); return ZMIENNA; }   
.              /* remove other characters */
            

%%
