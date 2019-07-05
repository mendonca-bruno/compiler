# Simple compiler using lex/yacc
This is a project of a compiler that deals with simple expressions, such as:
```
var = 10;
print var;
y = var+10;
print y;
x = var*y;
print x;
z = x/2;
print z;
```
## Tokens:


    "print"         {return print;}
    "exit"          {return exit_command;}
    [a-zA-Z]+       {return identifier;}
    [0-9]+          {return number;}
    [ \t\n]         ;
    [-+*/=;]        {return yytext[0];}
    .{ECHO;         printf("Error");}
	
##Grammar


    line    : assignment ';'
            | exit_command ';'
            | print exp ';'
            | line assignment ';'
            | line print exp ';'
            | line exit_command ';'
            ;
    
    assignment  : identifier '=' exp
                		;
    
    exp     : term
            | exp '+' term
            | exp '-' term
            ;
    
    term    : factor
            | term '*' factor
    		| term '/' factor
    		;
    
    factor	: number
    		| identifier
    		| '(' exp ')'
    		;
            
### Compiling

`yacc -d myComp.y`
`g++ -c y.tab.c -o y.tab.o`
`lex flex.l`
`g++ -c lex.yy.c -o lex.yy.o`
`g++ lex.yy.o y.tab.o -o compiler`

#### Made by

Bruno Mendonça Santos"# compiler" 
