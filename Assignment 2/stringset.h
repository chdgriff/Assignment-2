// stringset.hpp
//
// Created by Christopher Griffis on 10/12/18.

#ifndef stringset_hpp
#define stringset_hpp


#include <cstdio>
#include <string>
# include <unordered_set>

using namespace std;


const string* intern_stringset (const char*);
void dump_stringset (FILE*);

#endif /* stringset_hpp */
