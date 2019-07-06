%{
#include "y.tab.h"
#include <stdio.h>
void printTEXT(char* s);

%}
%%

"print"             {return PRINT;}
"exit"              {return EXIT;}
[a-zA-Z][_a-zA-Z]*  {yylval.id = strdup(yytext);return IDENTIFIER;}
[-]?[0-9]+          {yylval.num = atoi(yytext); return NUMBER;}
[ \t\n]             ;
"-"                 {return MINUS;}
"+"                 {return PLUS;}
"="                 {return ATR;}
";"                 {return EOL;}
"*"                 {return TIMES;}
"/"                 {return DIV;}
"("                 {return ABRP;}
")"                 {return FECP;}
.                   {ECHO;}
       

%%
void printTEXT(char*s){
    printf("%s\n", s);
}

int yywrap(void){
    return 1;
}