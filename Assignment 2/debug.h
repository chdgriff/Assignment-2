// debug.h
//
// Created by Christopher Griffis on 10/16/18.

#ifndef debug_h
#define debug_h

#include <string>
using namespace std;

void set_debugflags(char* flags);

bool is_debugflag(char flag);

void printDebug(char flag, string file, int line,
                string funct, string format, ...);

#define DEBUGF(FLAG, FORM, ...) printDebug(FLAG, __FILE__, __LINE__, \
                          __PRETTY_FUNCTION__, FORM, __VA_ARGS__);

#endif /* debug_h */
