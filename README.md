# Simple compiler using lex/yacc
This is a project of a compiler that deals with simple expressions, such as:
```
x = 10+10;
print x;
y = 2*(x+5);
print y;
print x+y;
z = 2*(5*(x+y));
print z;

```
## Tokens:


    "print"         PRINT
    "exit"          EXIT
    [a-zA-Z][_a-zA-Z]*       IDENTIFIER
    [-]?[0-9]+          NUMBER
    "-"                 MINUS
	"+"                 PLUS
	"="                 ATR
	";"                 EOL
	"*"                 TIMES
	"/"                 DIV
	"("                 ABRP
	")"                 FECP
	";"                 EOL
	
##Grammar

```
line    : assignment EOL
        | EXIT EOL
        | PRINT exp EO
        | line assignment EOL
        | line PRINT exp EOL
        | line EXIT EOL
        ;

assignment  : IDENTIFIER ATR exp
            ;
			
exp     : term
        | exp PLUS term
        | exp MINUS term 
        ;

term    : factor
        | term TIMES factor
        | term DIV factor
        ;

factor  : NUMBER
        | IDENTIFIER
        | ABRP exp FECP
        ;
```
            
### Compiling

`yacc -d myComp.y`

`g++ -c y.tab.c -o y.tab.o`

`lex flex.l`

`g++ -c lex.yy.c -o lex.yy.o`

`g++ lex.yy.o y.tab.o -o compiler`

#### Made by

Bruno Mendonça Santos
