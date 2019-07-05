
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
%token print
%token exit_command
%token <num> number
%token <id> identifier


/*declaring non terminals that are going
to map to the specific type*/
%type <num> line exp term
%type <id> assignment iden


%%

/*Grammar*/

line    : assignment ';'        {;}   
        | exit_command ';'              {exit(0);}
        | print exp ';'         {printf("%d\n", $2);}
        | line assignment ';'   {;}
        | line print exp ';'    {printf("%d\n", $3);}
        | line exit_command ';'         {exit(0);}
        ;

assignment  : iden '=' exp        {addValue($1,$3);}
            ;

iden        : identifier         {$$ = $1;}
            ;

exp     : term                  {$$ = $1;}
        | exp '+' term         {$$ = $1 + $3;}
        | exp '-' term        {$$ = $1 - $3;} 
        ;

term    : number                  {$$ = $1;}
        | identifier                   {$$ = varValue($1);}
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


