// scanner.l
//
// Created by Christopher Griffis on 10/29/18.


%{
  
}%

// Definitions
%option 8bit
%option debug
%option nodefault
%option nounput
%option noyywrap
%option warn

LETTER    [A-Za-z]
DIGIT     [0-9]
INCLUDE   [\#{LETTER}+]


%%
// Rules

"+"       { return }
"-"
"*"
"/"
"%"
"="
"=="
"!="
"<"
"<="
">"
">="
"->"
","
";"
"("
")"
"["
"]"
"{"
"}"
"[]"


%%

// User code
