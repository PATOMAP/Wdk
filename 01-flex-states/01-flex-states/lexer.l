/*** Definition Section has one variable
which can be accessed inside yylex() 
and main() [a-zA-Z0-9!@#$%^&*()_+=-]{8,15}  ***/

/***Task1***/
/*** 
{ EMAIL} {printf("E-mail: %s \n", yytext);}
{PASSWORD} { printf("Hasło: %s \n", yytext); } 
.*         {printf("Nie rozpoznano: %s \n", yytext); }
***/

/***Task2***/
/*** 
\n         {lines++;printf("Count lines:%d\n",lines);}
\t         {tabs++;printf("Count tabs:%d\n",tabs);}
{WORDS}      {words++;printf("Count word:%d\n",words);} 
***/
/*** Task3 ***/
/***

 ***/

%{
        int words= 0;
        int tabs = 0;
        int lines =0;
%}

EMAIL [a-zA-Z0-9]+.+[a-zA-Z0-9]+[@]+[a-z]+.+[a-z]
PASSWORD  [a-zA-Z0-9!@#$%^&*()_+=-]{8,15}
WORDS  [a-zA-Z]+
FLOAT [0-9]+[.]+[0-9]
PLUS [\+]
MINUS [\-]
MULTIPLY [\*]
DIVIDE [\/]
%%
{FLOAT} {printf("FLOAT: %s \n", yytext);}
{PLUS}  {printf("PLUS: %s \n", yytext);}
end        { printf("Kończę program.\n"); return 0; }
%%

/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){ return 1;}
int main(){



yylex();


return 0;
}
