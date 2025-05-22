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

"sin"       { return SIN; }  
"cos"       { return COS; }
"pow"       { return POWER; }

[0-9]+\.[0-9]*     { yylval.dtype = atof(yytext); return NUMBER; }
[0-9]+             { yylval.dtype = atof(yytext); return NUMBER; }

\'[a-zA-Z0-9]\'     { yylval.c = yytext[1]; return CHARVAL; }
\"[^\"]*\"         { yylval.x = new std::string(yytext); return STRINGVAL; }

"*"         { return TIMES; }
"+"         { return PLUS; }
"-"         { return SUBSTRACT; }
"/"         { return DIVIDE; }
"="         { return EQUAL; }
";"         { return SEMICOLON; }
"("         { return LPAREN; }
")"         { return RPAREN; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.x = new std::string(yytext);
    return ZMIENNA;
}

[ \t\r\n]+      ; // ignoruj białe znaki

.               { /* ignoruj inne znaki */ }

%%
