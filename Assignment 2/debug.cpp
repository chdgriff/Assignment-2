// debug.cpp
//
// Created by Christopher Griffis on 10/16/18.

#include <iostream>
#include <string>
#include <cstdarg> // va_list(), va_start(), va_end()
#include <cstdio> // vprintf()
#include "debug.h"

using namespace std;

string debugFlags = "";
bool allDebugFlags = false;

void set_debugflags(char* flags) {
  if (flags == nullptr) allDebugFlags = true;
  else {
    debugFlags = flags;
  }
  DEBUGF('x', "debugFlags = ", debugFlags.c_str())
  DEBUGF('y', "allDebugFlags = ", allDebugFlags)
}

bool is_debugflag(char flag) {
  if (debugFlags.find(flag) == string::npos) return false;
  return true;
}

void printDebug(char flag, string file, int line,
                string funct, string format...) {
  
  if (allDebugFlags || is_debugflag(flag)) {
    va_list arg;
    va_start(arg, format);
    cout << "DEBUGF(" << flag << "): " << file << "["<<  line  << "] "
          << funct << ": ";
    vprintf(format.c_str(), arg);
    cout << "\n";
    va_end(arg);
  }
}







