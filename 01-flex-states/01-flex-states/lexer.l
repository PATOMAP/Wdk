
/* TASK:

Print all labels defined with #define directive in "yy.lex.c" file. 

*/ 

%option noyywrap 

%{
	
	#include <iostream>
   	#include <set>
   	#include <string>
	 
	
#ifdef _WIN32
    // needed by Visual Studio compiler:
	int isatty (int a)  // is deprecated, use _isatty instead
	{
	    return _isatty(a);
	}
	
	int fileno (FILE * f)
	{
	    return _fileno(f);
	}
#endif
	
#define DEBUG(x)  cerr << __FILE__ << " (" << __LINE__ << ") " << #x << " == " << x << endl;	


    std::set<std::string> labels;
       
	
%}
 
%x DEFINED
 

%%
 
 
 
 
\r?\n                      {  /* remove newlines */ }                           
.                          {  /* remove all characters */ }



%%

 

int main() 
{
    yyin = fopen ("lex.yy.c", "r");
    yylex();   
    
    for (const auto t : labels)
    {
        std::cout << t << std::endl;
    }
    return 0;
}

 
