/*** Definition Section has one variable
which can be accessed inside yylex() 
and main() ***/
%{

%}
ALL [A-Z][a-z]+

%%
({ALL}\.{ALL}|[a-z]+)@gmail\.com printf("e-mail: %s \n", yytext);

\n {return 0;}
%%

/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){



yylex();


return 0;
}
