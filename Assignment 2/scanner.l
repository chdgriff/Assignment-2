%{
  
  #include "lyutils.h"
  
  #define YY_USER_ACTION { lexer::advance(); }
  #define RETURN(SYM) { return yylval_token(SYM); }
  
%}

%option 8bit
%option debug
%option nodefault
%option nounput
%option noyywrap
%option warn

LETTER        [A-Za-z]
DIGIT         [0-9]
IDENTIFIER    {LETTER}({LETTER}|{DIGIT})*
DECIMAL_INT   [1-9]{DIGIT}*
OCTAL_INT     0[1-7]*
HEX_INT       0[xX][{DIGIT}A-Fa-f]+
NUMBER       {DECIMAL_INT}|{OCTAL_INT}|{HEX_INT}
CHAR          '([^\\'\n]|\\[\\'"0nt])'
STRING        \"([^\\"\n]|\\[\\’"0nt])*\"

BAD_IDENT    {DIGIT}+({LETTER}|{DIGIT})*
BAD_CHAR     '([^\\'\n]|\\[\\'"0nt]?)[^']?
BAD_STRING   \"([^\\"\n]|\\[\\'"0nt])*[^\"]?


%%

"#".*         { lexer::include(); }
[ \t]+        {  }
\n            { lexer::newline(); }

"if"          { RETURN(TOK_IF); }
"else"        { RETURN(TOK_ELSE); }
"while"       { RETURN(TOK_WHILE); }
"return"     { RETURN(TOK_RETURN); }
"int"         { RETURN(TOK_INT); }
"string"      { RETURN(TOK_STRING); }
"struct"      { RETURN(TOK_STRUCT); }
"void"        { RETURN(TOK_VOID); }
"new"         { RETURN(TOK_NEW); }
"null"        { RETURN(TOK_NULL); }
"not"         { RETURN(TOK_NOT); }

{NUMBER}      { RETURN(TOK_INTCON); }
{IDENTIFIER}  { RETURN(TOK_IDENT); }
{CHAR}        { RETURN(TOK_CHARCON); }
{STRING}      { RETURN(TOK_STRINGCON); }

"=="          { RETURN(TOK_EQ); }
"!="          { RETURN(TOK_NE); }
"<"           { RETURN(TOK_LT); }
"<="          { RETURN(TOK_LE); }
">"           { RETURN(TOK_GT); }
">="          { RETURN(TOK_GE); }
"->"          { RETURN(TOK_ARROW); }
"[]"          { RETURN(TOK_ARRAY); }

"+"           { RETURN('+'); }
"-"           { RETURN('-'); }
"*"           { RETURN('*'); }
"/"           { RETURN('/'); }
"%"           { RETURN('%'); }
"="           { RETURN('='); }
","           { RETURN(','); }
"("           { RETURN('('); }
")"           { RETURN(')'); }
"["           { RETURN('['); }
"]"           { RETURN(']'); }
"{"           { RETURN('{'); }
"}"           { RETURN('}'); }

{BAD_IDENT}   { lexer::badtoken(yytext); }
{BAD_CHAR}    { lexer::badtoken(yytext); }
{BAD_STRING}  { lexer::badtoken(yytext); }
.             { lexer::badchar(*yytext); }




%%
