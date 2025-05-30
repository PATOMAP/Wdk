%option noyywrap

%{
    #include "parser.tab.h"
    int current_line = 1;
%}

%%

"int"               { return INT; }
"double"            { return DOUBLE; }
"const"             { return CONST; }
"constexp"          { return CONSTEXP; }
"char"              { return CHAR; }
"void"              { return VOID; }

"&"+                 { return REF; }
"*"+                 { return STAR; }

"("                 { return LPAREN; }
")"                 { return RPAREN; }
"["                 { return LBRACKET; }
"]"                 { return RBRACKET; }
","                 { return COMMA; }
":"                 { return COLON; }
";"                 { return SEMICOLON; }

"//"[^\n]*          { /* komentarz prosty */ }
"/*"([^*]|\*+[^*/])*\*+\/    { /* komentarz wieloliniowy */ }

[0-9]+              { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }

[\n]+               { current_line++; }
[ \t\r]+            { /* tabulatory,enter */ }

.                   { return yytext[0]; }

%%
