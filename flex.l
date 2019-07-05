%{
#include "y.tab.h"
#include <stdio.h>

%}
%%

"print"             {return print;}
"exit"              {return exit_command;}
[a-zA-Z]+            {yylval.id = strdup(yytext);return identifier;}
[0-9]+              {yylval.num = atoi(yytext); return number;}
[ \t\n]             ;
[-+=;]              {return yytext[0];}
.                   {ECHO; printf("Erro");}
       

%%

int yywrap(void){
    return 1;
}