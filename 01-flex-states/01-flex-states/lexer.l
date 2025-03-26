/*** Definition Section has one variable
which can be accessed inside yylex() 
and main() [a-zA-Z0-9!@#$%^&*()_+=-]{8,15}  ***/

/***Task1***/
/*** 
{EMAIL} {printf("E-mail: %s \n", yytext);}
{PASSWORD} { printf("Hasło: %s \n", yytext); } 
***/

/***Task2***/
/*** 
\n         {lines++;printf("Count lines:%d\n",lines);}
\t         {tabs++;printf("Count tabs:%d\n",tabs);}
{WORDS}      {words++;printf("Count word:%d\n",words);} 
***/
/*** Task3 ***/
/***
{BOOL} {printf("Bool: %s \n", yytext);}
{FLOAT} {printf("Float: %s \n", yytext);}
{PLUS}  {printf("Char plus: %s \n", yytext);}
{MINUS}  {printf("Char minus: %s \n", yytext);}
{MULTIPLY}  {printf("Char multiply: %s \n", yytext);}
{DIVIDE}  {printf("Char divide: %s \n", yytext);}
{EQUAL} {printf("Char equal : %s \n", yytext);}
{GREATER} {printf("Char greater : %s \n", yytext);}
{LESS} {printf("Char less : %s \n", yytext);}
{GREATEREQUAL} {printf("Char greater or equal : %s \n", yytext);}
{LESSEQUAL} {printf("Char less or equal : %s \n", yytext);}
{LPAREN} {printf("Char left parenthesis: %s \n", yytext);}
{RPAREN} {printf("Char right parenthesis: %s \n", yytext);}
{LBRACKET} {printf("Char left bracket: %s \n", yytext);}
{RBRACKET} {printf("Char right bracket: %s \n", yytext);}
{LBRACE} {printf("Char left brace: %s \n", yytext);}
{RBRACE} {printf("Char right brace: %s \n", yytext);}
{LANGLE} {printf("Char left angle bracket: %s \n", yytext);}
{RANGLE} {printf("Char right angle bracket: %s \n", yytext);}
{SEMICOLON} {printf("Char semicolon: %s \n", yytext);}
.{1} {printf("Other char: %s \n", yytext);}
 ***/

%{
        int words= 0;
        int tabs = 0;
        int lines =0;
%}

EMAIL [a-zA-Z0-9]+\.+[a-zA-Z0-9]+*@[a-zA-Z0-9]+\.[a-zA-Z]{2,}
PASSWORD  [a-zA-Z0-9!@#$%^&*()_+=-]{8,15}
WORDS  [a-zA-Z]{2,}
FLOAT [0-9]+[.]+[0-9]
PLUS [\+]
MINUS [\-]
MULTIPLY [\*]
DIVIDE [\/]
EQUAL =
GREATER >
LESS <
GREATEREQUAL =>
LESSEQUAL <=
LPAREN [(]
RPAREN [)]
LBRACKET [\[]
RBRACKET [\]]
LBRACE [{]
RBRACE [}]
LANGLE [<]
RANGLE [>]
SEMICOLON [;]
BOOL true|false

%%
end        { printf("End program\n"); return 0; }
\n         {lines++;printf("Count lines:%d\n",lines);}
\t         {tabs++;printf("Count tabs:%d\n",tabs);}
{WORDS}      {words++;printf("Count word:%d word:%s\n",words,yytext);} 
{EMAIL} {printf("E-mail: %s \n", yytext);}
{PASSWORD} { printf("Hasło: %s \n", yytext); } 
{BOOL} {printf("Bool: %s \n", yytext);}
{FLOAT} {printf("Float: %s \n", yytext);}
{PLUS}  {printf("Char plus: %s \n", yytext);}
{MINUS}  {printf("Char minus: %s \n", yytext);}
{MULTIPLY}  {printf("Char multiply: %s \n", yytext);}
{DIVIDE}  {printf("Char divide: %s \n", yytext);}
{EQUAL} {printf("Char equal : %s \n", yytext);}
{GREATER} {printf("Char greater : %s \n", yytext);}
{LESS} {printf("Char less : %s \n", yytext);}
{GREATEREQUAL} {printf("Char greater or equal : %s \n", yytext);}
{LESSEQUAL} {printf("Char less or equal : %s \n", yytext);}
{LPAREN} {printf("Char left parenthesis: %s \n", yytext);}
{RPAREN} {printf("Char right parenthesis: %s \n", yytext);}
{LBRACKET} {printf("Char left bracket: %s \n", yytext);}
{RBRACKET} {printf("Char right bracket: %s \n", yytext);}
{LBRACE} {printf("Char left brace: %s \n", yytext);}
{RBRACE} {printf("Char right brace: %s \n", yytext);}
{LANGLE} {printf("Char left angle bracket: %s \n", yytext);}
{RANGLE} {printf("Char right angle bracket: %s \n", yytext);}
{SEMICOLON} {printf("Char semicolon: %s \n", yytext);}
.{1} {printf("Other char: %s \n", yytext);}
%%

/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){ return 1;}
int main(){



yylex();


return 0;
}
