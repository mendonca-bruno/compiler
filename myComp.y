
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include <string>
    #include "symbolTable.hpp"
    extern int yylex(void);
    void yyerror(char const* s);
%}

%union {int num; char* id;}

/*defining start rule*/
%start line

/*declaring tokens*/
%token PRINT
%token EXIT
%token MINUS
%token PLUS
%token ATR
%token EOL
%token ABRP
%token FECP
%token TIMES
%token DIV
%token <num> NUMBER
%token <id> IDENTIFIER


/*declaring non terminals that are going
to map to the specific type*/
%type <num> line exp term factor
%type <id> assignment var


%%

/*Grammar*/

line    : assignment EOL        {;}   
        | EXIT EOL              {exit(0);}
        | PRINT exp EOL         {printf("%d\n", $2);}
        | line assignment EOL   {;}
        | line PRINT exp EOL    {printf("%d\n", $3);}
        | line EXIT EOL         {exit(0);}
        ;

assignment  : var ATR exp        {addValue($1,$3);}
            ;

var        : IDENTIFIER         {$$ = $1;}
            ;

exp     : term                  {$$ = $1;}
        | exp PLUS term         {$$ = $1 + $3;}
        | exp MINUS term        {$$ = $1 - $3;} 
        ;

term    : factor                  {$$ = $1;}
        | term TIMES factor       {$$ = $1 * $3;}
        | term DIV factor        {$$ = $1 / $3;} 
        ;

factor  : NUMBER                  {$$ = $1;}
        | IDENTIFIER              {$$ = varValue($1);}
        | ABRP exp FECP           {$$ = $2;}
        ;

%%

/*C code*/

void yyerror(char const* s) { 
    printf("%s", s);
    exit(1);
} //print errors

int main(void){
    //aply the grammar rules
    return yyparse();
}


