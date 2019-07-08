
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include <string>
    #include "symbolTable.hpp"
    extern int yylex(void);
    extern char *yytext;
    void yyerror(char const* s);
%}

%union {int num; char* id; char* stringid; double dnum;}

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
%token SPRINT
%token DPRINT
%token STRING
%token INT
%token DOUBLE
%token <num> NUMBER
%token <id> IDENTIFIER
%token <stringid> STRID
%token <dnum> DNUMBER


/*declaring non terminals that are going
to map to the specific type*/
%type <num> exp term factor print2
%type <id> assignment var
%type <stringid> print1 exp2
%type <dnum> expd termd factord print3

%%

/*Grammar*/

line    : assignment EOL        {;}
        | EXIT EOL              {exit(0);}
        | print1 EOL         {printf("%s\n",$1);}
        | print2 EOL       {printf("%d\n", $1);}
        | print3 EOL        {printf("%f\n", $1);}
        | line assignment EOL   {;}
        | line print1 EOL   {printf("%s\n", $2);}
        | line print2 EOL    {printf("%d\n", $2);}
        | line print3 EOL    {printf("%f\n", $2);}
        | line EXIT EOL         {exit(0);}
        ;

print1   : SPRINT exp2                 {$$ = $2;}
         ;

exp2     : IDENTIFIER                    {$$ = strValue($1);}

print2  : PRINT exp                  {$$ = $2;}
        ;

print3  : DPRINT expd                  {$$ = $2;}
        ;

assignment  : INT var ATR exp        {addValue($2,$4);}
            | STRING var ATR STRID            {addString($2,$4);}
            | DOUBLE var ATR expd    {addDoubleValue($2,$4);}
            ;

var        : IDENTIFIER         {$$ = $1;}
            ;

exp     : term                  {$$ = $1;}
        | exp PLUS term         {$$ = $1 + $3;}
        | exp MINUS term        {$$ = $1 - $3;} 
        ;

expd    : termd                  {$$ = $1;}
        | expd PLUS termd         {$$ = $1 + $3;}
        | expd MINUS termd        {$$ = $1 - $3;} 
        ;

term    : factor                  {$$ = $1;}
        | term TIMES factor       {$$ = $1 * $3;}
        | term DIV factor        {$$ = $1 / $3;} 
        ;

termd    : factord                  {$$ = $1;}
        | termd TIMES factord       {$$ = $1 * $3;}
        | termd DIV factord        {$$ = $1 / $3;} 
        ;

factor  : NUMBER                  {$$ = $1;}
        | IDENTIFIER              {$$ = varValue($1);}
        | ABRP exp FECP           {$$ = $2;}
        ;
factord  : DNUMBER                  {$$ = $1;}
        | IDENTIFIER              {$$ = doubleVarValue($1);}
        | ABRP expd FECP           {$$ = $2;}
        ;

%%

/*C code*/

void yyerror(char const* s) { 
    printf("%s\n%s", s,yytext);
    exit(1);
} //print errors

int main(void){
    //aply the grammar rules
    return yyparse();
}


