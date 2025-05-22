%{
    #include <stdio.h>
    #include <iostream>
    #include <stdlib.h>
    extern int yylex();
    void yyerror(const char *s);
    extern FILE *yyin;
    extern int current_line;
    int flag;
%}

%token REF  STAR LPAREN RPAREN LBRACKET RBRACKET COMMA COLON SEMICOLON NUMBER
%token INT DOUBLE CONST CHAR VOID CONSTEXP IDENTIFIER 

%start program

%%

program:
      /* pusty */
    | program function_declaration
    ;

function_declaration:
      full_type IDENTIFIER LPAREN parameter_list RPAREN SEMICOLON { printf("Linia %d: OK\n", current_line);}
    | full_type IDENTIFIER LPAREN RPAREN SEMICOLON { printf("Linia %d: OK\n", current_line); }
    | error SEMICOLON { printf("Linia %d: Error\n", current_line); yyerrok; }
    ;
full_type:
      type_const base_type type_const pointer_ampersand
    ;
type_const:
      /* pusty */
    | type_const CONST
    | type_const CONSTEXP
    ;

base_type:
      INT
    | DOUBLE
    | CHAR
    | VOID
    ;

pointer_ampersand:
      /* pusty */
    | pointer_ampersand STAR 
    | pointer_ampersand REF
    ;
    
parameter_list:
      parameter
    | parameter_list COMMA parameter
    ;

parameter:
      full_type array_suffix
    | full_type IDENTIFIER
    | full_type
    ;

array_suffix:
      LBRACKET NUMBER RBRACKET
    | LBRACKET RBRACKET
    ;

%%

void yyerror(const char *s)
{
    
}

int main()
{
    std::ios_base::sync_with_stdio(true);

    FILE *file = fopen("in.txt", "r");
    if (!file) {
        perror("Nie można otworzyć pliku in.txt");
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);
    return 0;
}
