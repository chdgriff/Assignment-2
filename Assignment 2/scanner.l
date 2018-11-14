%{
  
  #include "lyutils.h"
  
  #define YY_USER_ACTION  { lexer::advance(); }
  
%}

%option 8bit
%option debug
%option nodefault
%option nounput
%option noyywrap
%option verbose
%option warn

LETTER          [A-Za-z_]
DIGIT           [0-9]

DECIMAL_INT   [1-9]{DIGIT}*
OCTAL_INT     0[0-7]*
HEX_INT       0[xX][{DIGIT}A-Fa-f]+
INTEGER       {DECIMAL_INT}|{OCTAL_INT}|{HEX_INT}

IDENTIFIER    {LETTER}({LETTER}|{DIGIT})*
CHAR          '([^\\'\n]|\\[\\'"0nt])'
STRING        \"([^\\"\n]|\\[\\’"0nt])*\"

BAD_IDENT     {DIGIT}+({LETTER}|{DIGIT})*
BAD_CHAR      '([^\\'\n]|\\[\\'"0nt]?)[^']?
BAD_STRING    \"([^\\"\n]|\\[\\'"0nt])*[^\"]?

%%

"#".*         { lexer::include(); }
[ \t]+        { }
\n            { lexer::newline(); }

"if"          { return yylval_token(TOK_IF); }
"else"        { return yylval_token(TOK_ELSE); }
"while"       { return yylval_token(TOK_WHILE); }
"return"      { return yylval_token(TOK_RETURN); }
"int"         { return yylval_token(TOK_INT); }
"string"      { return yylval_token(TOK_STRING); }
"struct"      { return yylval_token(TOK_STRUCT); }
"void"        { return yylval_token(TOK_VOID); }
"new"         { return yylval_token(TOK_NEW); }
"null"        { return yylval_token(TOK_NULL); }
"not"         { return yylval_token(TOK_NOT); }

{INTEGER}     { return yylval_token(TOK_INTCON); }
{CHAR}        { return yylval_token(TOK_CHARCON); }
{STRING}      { return yylval_token(TOK_STRINGCON); }
{IDENTIFIER}  { return yylval_token(TOK_IDENT); }

"=="          { return yylval_token(TOK_EQ); }
"!="          { return yylval_token(TOK_NE); }
"<"           { return yylval_token(TOK_LT); }
"<="          { return yylval_token(TOK_LE); }
">"           { return yylval_token(TOK_GT); }
">="          { return yylval_token(TOK_GE); }
"->"          { return yylval_token(TOK_ARROW); }
"[]"          { return yylval_token(TOK_ARRAY); }

"+"           { return yylval_token('+'); }
"-"           { return yylval_token('-'); }
"*"           { return yylval_token('*'); }
"/"           { return yylval_token('/'); }
"%"           { return yylval_token('%'); }
"="           { return yylval_token('='); }
","           { return yylval_token(','); }
";"           { return yylval_token(';'); }
"("           { return yylval_token('('); }
")"           { return yylval_token(')'); }
"["           { return yylval_token('['); }
"]"           { return yylval_token(']'); }
"{"           { return yylval_token('{'); }
"}"           { return yylval_token('}'); }

{BAD_IDENT}   { lexer::badtoken(yytext); }
{BAD_CHAR}    { lexer::badtoken(yytext); }
{BAD_STRING}  { lexer::badtoken(yytext); }
.             { lexer::badchar(*yytext); }

%%
