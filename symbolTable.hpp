#pragma once
#ifndef SYMBOLTABLE_HPP
#define SYMBOLTABLE_HPP
#include <vector>
#include <iostream>
#include <string>
#include <string.h>
using namespace std;

int varValue(char* symbol);
int varExists(char* symbol);
void addValue(char* symbol, int number);
void addString(char* symbol, char*text);
void addDoubleValue(char* symbol, double number);
char* strValue(char* symbol);
void removeQuote(char * symbol, char c);
double doubleVarValue(char* symbol);

struct Table
{
    char *id;
    char *text;
    int value;
    double dValue;
};

std::vector<Table> symbols;


/*
checks if a recognised var already exists, also used
to return the index of an var recognised in the code .
*/
int varExists(char* symbol){
    for(int i =0; i<symbols.size(); i++){
        if(strcmp(symbols[i].id, symbol)==0) return i;
    }
    return -1;
}

/*
adds a var to the symbol table, and checks if the var
already exists, if so it just updates it's value.
 */
void addValue(char* symbol, int number){
    int check = varExists(symbol);

    
    if(check != -1){
        symbols[check].value = number;
        return;
    }

    Table t;
    t.id = symbol;
    t.value = number;
    symbols.push_back(t);

}

/*
Remove the quotes marks from a string value
 */
void removeQuote(char * symbol, char c){
    if(symbol == NULL) return;
    
    char * pDest = symbol;

    while(*symbol){
        if(*symbol != c) *pDest++ = *symbol;
        symbol++;
    }
    *pDest = '\0';

}

void addString(char* symbol, char*text){
    removeQuote(text, '"');
    int check = varExists(symbol);
    if(check != -1){
        strcpy(symbols[check].text,text);
        return;
    }
    
    Table t;
    t.id = symbol;
    t.text = text;
    symbols.push_back(t);
}

/*
returns the value of the given symbol
 */
int varValue(char* symbol){

    int check = varExists(symbol);
    if(check!=-1) return symbols[check].value;
    return -1;
}

char* strValue(char* symbol){

    int check = varExists(symbol);
    if(check!=-1) return symbols[check].text;
    return NULL;
}

void addDoubleValue(char* symbol, double number){
    int check = varExists(symbol);

    
    if(check != -1){
        symbols[check].dValue = number;
        return;
    }

    Table t;
    t.id = symbol;
    t.dValue = number;
    symbols.push_back(t);

}

double doubleVarValue(char* symbol){

    int check = varExists(symbol);
    if(check!=-1) return symbols[check].dValue;
    return -1;
}



#endif