# Simple compiler using lex/yacc
This is a project of a compiler that deals with simple expressions, such as:
```
int x = 10+10;
print x;
int y = 2*(x+5);
print y;
print x+y;
int z = 2*(5*(x+y));
print z;
string str = "bananinha";
sprint str;
double a = 22.5;
dprint a;

```
## Tokens:

    "string"        STRING
    "int"           INT
    "double"        DOUBLE
    "sprint"        SPRINT
    "dprint"        DPRINT
    "print"         PRINT
    "exit"          EXIT
    [a-zA-Z][_a-zA-Z]*       IDENTIFIER
    [-]?[0-9]+          NUMBER
    [-]?[0-9]+[.][0-9]+ DNUMBER
    ["]([-_.,:=a-zA-Z0-9]+)["] STRID
    "-"                 MINUS
	"+"                 PLUS
	"="                 ATR
	";"                 EOL
	"*"                 TIMES
	"/"                 DIV
	"("                 ABRP
	")"                 FECP
	";"                 EOL
	
## Grammar

```
line    : assignment EOL        
        | EXIT EOL              
        | print1 EOL         
        | print2 EOL       
        | print3 EOL        
        | line assignment EOL   
        | line print1 EOL   
        | line print2 EOL    
        | line print3 EOL    
        | line EXIT EOL         
        ;

print1   : SPRINT exp2                 
         ;

exp2     : IDENTIFIER                    

print2  : PRINT exp                  
        ;

print3  : DPRINT expd                  
        ;

assignment  : INT var ATR exp        
            | STRING var ATR STRID            
            | DOUBLE var ATR expd    
            ;

var        : IDENTIFIER         
            ;

exp     : term                  
        | exp PLUS term         
        | exp MINUS term        
        ;

expd    : termd                  
        | expd PLUS termd         
        | expd MINUS termd         
        ;

term    : factor                  
        | term TIMES factor       
        | term DIV factor         
        ;

termd    : factord                  
        | termd TIMES factord       
        | termd DIV factord         
        ;

factor  : NUMBER                  
        | IDENTIFIER              
        | ABRP exp FECP           
        ;
factord  : DNUMBER                  
        | IDENTIFIER              
        | ABRP expd FECP           
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
