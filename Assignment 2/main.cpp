// main.cpp
//
// Created by Christopher Griffis on 10/12/18.
// Last modified 11/13/18


#include <unistd.h> // getopt()
#include <libgen.h> // basename()
#include <iostream> // cout, cerr
#include <string> // string
#include <cstring> // streerror()
#include <cstdio> // fgets()

#include "auxlib.h"
#include "string_set.h"
#include "lyutils.h"

using namespace std;

const string CPP = "/usr/bin/cpp -nostdinc";
string CPP_command;
FILE* tok_file;

// Runs file through CPP and through lexer
void cpp_popen(const string file_path) {
  CPP_command = CPP + " " + file_path;
  DEBUGF('c', "CPP_command = %s\n", CPP_command.c_str());

  yyin = popen(CPP_command.c_str(), "r");
  if (yyin == nullptr) {
    eprintf("%s: %s: %s\n", CPP_command.c_str(), strerror(errno));
    exit(EXIT_FAILURE);
  } else {
    if (yy_flex_debug) {
      eprintf("-- popen (%s), fileno(yyin) = %d\n",
              CPP_command.c_str(), fileno (yyin));
    }
  }
  lexer::newfilename(CPP_command);
}

// Closes CPP pipe
void cpp_pclose() {
  int pclose_rc = pclose(yyin);
  eprint_status(CPP_command.c_str(), pclose_rc);
  if(pclose_rc != 0) exit(EXIT_FAILURE);
}

void scan_options(int argc, char* argv[]) {
  int options = 0;
  while ((options = getopt(argc, argv, "@:D::ly")) != -1) {
    switch (options) {
      case '@':
        set_debugflags(optarg);
        break;
      case 'D':
        break;
      case 'l':
        yy_flex_debug = 1;
        break;
      case 'y':
        yydebug = 1;
        break;
      default:
        eprintf("Invalid Flag, "
                "Usage: oc [-ly] [-@flags] [-D string] program.oc\n");
        exit(EXIT_FAILURE);
    }
  }
  
  // if no file provided
  if (optind > argc) {
    eprintf("No file provided, "
            "Usage: oc [-ly] [-@flags] [-D string] program.oc\n");
    exit(EXIT_FAILURE);
  }
}

string set_file_extension(const string file_name) {
  string file_extension = file_name.substr(file_name.size()-3, 3);
  if (file_extension.compare(".oc") != 0) {
    eprintf("Invalid input of type \"%s\" must be of type \".oc\"\n",
            file_extension.c_str());
    exit(EXIT_FAILURE);
  }
  return file_extension;
}


int main(int argc, char * argv[]) {
  yy_flex_debug = 0;
  yydebug = 0;
  exec::execname = "oc";
  
  scan_options(argc, argv);
  
  string file_path = argv[optind];
  DEBUGF('d', "file_path = %s\n", file_path.c_str());
  string file_name = basename(const_cast<char*>(file_path.c_str()));
  DEBUGF('b', "file_name = %s\n", file_name.c_str());
  string file_extension = set_file_extension(file_name);
  string file_base_name(file_name, 0, file_name.size()-3);
  DEBUGF('c', "file_base_name = %s\n", file_base_name.c_str());
  
  string_set set;
  tok_file = fopen((file_base_name + ".tok").c_str() , "w");
  cpp_popen(file_path);
  int parse_rc = 0;
  do {
    parse_rc = yylex();
    string_set::intern(yytext);
  } while (parse_rc != YYEOF);
  
  cpp_pclose();
  fclose(tok_file);
  
  yylex_destroy();
  
  FILE* str_file = fopen((file_base_name + ".str").c_str() , "w");
  string_set::dump(str_file);
  fclose(str_file);

  
  delete parser::root;
  
  return exec::exit_status;
}
