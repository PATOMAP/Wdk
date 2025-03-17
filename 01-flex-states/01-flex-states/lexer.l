/*** Definition Section has one variable
which can be accessed inside yylex() 
and main() ({ALL}\.{ALL}|[a-z]+)@gmail\.com printf("e-mail: %s \n", yytext); ***/
%{

%}
ALL [A-Z][a-z]+

%%

[a-zA-Z0-9]+.+[a-zA-Z0-9]+[\@\]+[a-z]+.+[a-z] printf("e-mail: %s \n", yytext);
.*                                              printf("To nie jest e-mail: %s \n", yytext);
\n {return 0;}
%%

/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){



yylex();


return 0;
}
