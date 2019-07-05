
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include <string>
    //#include "symbolTable.hpp"
    extern int yylex(void);
    void yyerror(char const* s);
    int symbols[52];
    int symbolVal(char* symbol);
    void updateSymbolVal(char* symbol, int val);
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
%type <id> assignment


%%

/*Grammar*/

line    : assignment ';'        {;}   
        | exit_command ';'              {exit(0);}
        | print exp ';'         {printf("%d\n", $2);}
        | line assignment ';'   {;}
        | line print exp ';'    {printf("%d\n", $3);}
        | line exit_command ';'         {exit(0);}
        ;

assignment  : identifier '=' exp        {updateSymbolVal($1, $3);}
            ;

exp     : term                  {$$ = $1;}
        | exp '+' term         {$$ = $1 + $3;}
        | exp '-' term        {$$ = $1 - $3;} 
        ;

term    : number                  {$$ = $1;}
        | identifier                   {$$ = symbolVal($1);}
        ;

%%

/*C code*/

int computeSymbolIndex(char* token){
    int t = atoi(token);
    int idx = -1;
    if(islower(t)){
        idx = t - 'a' + 26;
    }else if(isupper(t)){
        idx = t - 'A';
    }
    return idx;
}

int symbolVal(char* symbol){
    int bucket = computeSymbolIndex(symbol);
    return symbols[bucket];
}

void updateSymbolVal(char* symbol, int val){
    int bucket = computeSymbolIndex(symbol);
    symbols[bucket] = val;
}

void yyerror(char const* s) { 
    printf("%s", s);
    exit(1);
} //print errors

int main(void){
    //aply the grammar rules
    return yyparse();
}


