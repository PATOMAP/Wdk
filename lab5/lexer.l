%option noyywrap

%{
    #include "parser.tab.h"
%}

%%
"int"               { return INT; }
"double"            { return DOUBLE; }
"const"             { return CONST; }
"char"              { return CHAR; }
"void"              { return VOID; }
"&"                 { return REF; }
"&&"                { return RREF; }
"*"                 { return STAR; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"["                 { return LBRACKET; }
"]"                 { return RBRACKET; }
","                 { return COMMA; }
":"                 { return COLON; }
";"                 { return SEMICOLON; }
"constexp"          { return CONSTEXP; }
[0-9]+              { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[ \t\n]+            { /* ignoruj białe znaki */ }
.                   { return yytext[0]; }

%%