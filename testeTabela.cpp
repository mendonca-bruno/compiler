#include <iostream>
#include <string>
#include <vector>
#include <ctype.h>
using namespace std;

struct Table{
    string id;
    int num;
};



int main(){
    std::vector<Table> table;
    string s = "var";
    int var = 5;

    Table t;
    t.id = s;
    t.num = var;

    table.push_back(t);

    for(Table x:table){
        if(x.id == "var") cout << "BooM" << endl;
    }
    


}