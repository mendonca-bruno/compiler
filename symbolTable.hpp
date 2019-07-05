#pragma once
#ifndef SYMBOLTABLE_HPP
#define SYMBOLTABLE_HPP
#include <vector>
#include <iostream>
#include <string>
using namespace std;

int varValue(char symbol);
int varExists(char symbol);
void addValue(char symbol, int number);

struct Table
{
    char id;
    int value;
};

std::vector<Table> symbols;


/*
checks if a recognised var already exists, also used
to return the index of an var recognised in the code .
*/
int varExists(char symbol){
    for(int i =0; i<symbols.size(); i++){
        if(symbols[i].id == symbol) return i;
    }
    return -1;
}

/*
adds a var to the symbol table, and checks if the var
already exists, if so it just updates it's value.
 */
void addValue(char symbol, int number){
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
returns the value of the given symbol
 */
int varValue(char symbol){
    int check = varExists(symbol);
    if(check!=-1) return symbols[check].value;
    return -1;
}



#endif