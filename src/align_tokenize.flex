%option noyywrap
%{
#include <iostream>
#include <memory>
using namespace std;
#include "align_ast.h"
#include "align_grammar.hpp"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-register"

%}
%%
"+"	{ return ADD; }
"-" { return SUB; }
"*"	{ return MUL; }
"/" { return DIV; }
"|" { return ABS; }
[0-9]+ { yylval.node = new AST_value(atoi( yytext )); return NUMBER; }
\n { return EOL; }
[ \t]		{ /* ignore */ }
. { std::cout << "Bad char " << *yytext << std::endl; }
%%

void parse_string( const char * str ){
	yy_switch_to_buffer( yy_scan_string( str ) );
}

#pragma clang diagnostic pop