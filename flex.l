%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>


%}
%%

"-"                 {return MINUS;}
"+"                 {return PLUS;}
"="                 {return ATR;}
";"                 {return EOL;}
"*"                 {return TIMES;}
"/"                 {return DIV;}
"("                 {return ABRP;}
")"                 {return FECP;}
"print"             {return PRINT;}
"sprint"            {return SPRINT;}
"dprint"            {return DPRINT;}
"string"            {return STRING;}
"int"               {return INT;}
"double"            {return DOUBLE;}
"exit"              {return EXIT;}
[-]?[0-9]+          {yylval.num = atoi(yytext); return NUMBER;}
[-]?[0-9]+[.][0-9]+ {yylval.dnum = atof(yytext); return DNUMBER;}
[a-zA-Z][_a-zA-Z]*  {yylval.id = strdup(yytext);return IDENTIFIER;}
["]([-_.,:=a-zA-Z0-9]+)["] {yylval.stringid = strdup(yytext);return STRID;}
[ \t\n]             ;

.                   {ECHO;}
       

%%

int yywrap(void){
    return 1;
}