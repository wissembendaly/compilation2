%{	
 
#include <stdio.h>	
#include <stdlib.h>	          
#include <string.h>
#include <math.h>	
#include "SyntaxicAnalyser.tab.h"	

%}

%option yylineno
delim     [ \t]
bl        {delim}+
chiffre   [0-9]
lettre    [a-zA-Z]
id        ({lettre}|_|$)({lettre}|{chiffre}|_|$)*
nb        ("-")?{chiffre}+("."{chiffre}+)?(("E"|"e")"-"?{chiffre}+)?
integer    -?{chiffre}+
boolean    (true|false)
p_ouvrante  (\()
p_fermante  (\))
b_ouvrant   (\{)
b_fermant   (\})
cr_ouvrante  (\[)
cr_fermante  (\])
point_virgule   (";")
virgule     (",")
point       (".")
COMMENT_LINE        "//"
COMMENT_START        \/\*
COMMENT_END         \*\/
COMMENT_BLOCK       {COMMENT_START}(.|\n)*{COMMENT_END}
string     \"[^\"]*\"
type      (int|int\[\]|boolean|boolean\[\]|String|String\[\])
COMMENT_BLOCK_ERROR   \/\*([^(\*\/)]|\n)*
STRING_BLOCK_ERROR    \"([^(\")])*
iderrone    {chiffre}({lettre}|{chiffre}|_|$)*



%%


{bl}                                                                                 /* pas d'actions */
"\\n" 			                                                                 ++yylineno;
{virgule}                                                                            return(VIRGULE);
{point_virgule}                                                                      return(POINT_VIRGULE);
{point}                                                                              return(POINT);
{integer}                                                                            return(INTEGER_LITERAL);
{boolean}                                                                            return(BOOLEAN_LITERAL);
{p_ouvrante}                                                                         return(P_OUVRANTE);
{p_fermante}                                                                         return(P_FERMANTE);
{cr_ouvrante}                                                                         return(Cr_OUVRANTE);
{cr_fermante}                                                                         return(Cr_FERMANTE);
{b_ouvrant}                                                                          return(START_BLOCK);
{b_fermant}                                                                          return(END_BLOCK);


"class"                                                                              return(CLASS);
"static"                                                                             return(STATIC);
"extends"                                                                            return(EXTENDS);
"private"                                                                            return(PRIVATE);
"public"                                                                             return(PUBLIC);
"package"                                                                            return(PACKAGE);
"if"                                                                                 return(IF);
"else"                                                                               return(ELSE);
"while"                                                                              return(WHILE);
"this"                                                                               return(THIS);
"new"                                                                                return(NEW);
"return"                                                                             return(RETURN);
"length"                                                                             return(LENGTH);
"void"                                                                               return(VOID);
"main"                                                                               return(MAIN);
"System.out.println"                                                                 return(SYSTEM_OUT_PRINTLN);
"String"                                                                             return(STR);
{string}                                                                             return(STRING);
{id}                                                                                 return(ID);


"!="                                                                                 return(INEQUALITY); 
"=="                                                                                 return(EQUALITY); 
"-"                                                                                  return(SUBSTRACTION); 
"*"                                                                                  return(MULTIPLICATION);
"="                                                                                  return(AFFECTATION);
"/"                                                                                  return(DIVISION); 
"+"                                                                                  return(ADD); 
"&&"                                                                                 return(ET); 
"||"                                                                                 return(OR);
"<"                                                                                  return(INF);
">"                                                                                  return(SUP);
"!"                                                                                  return(NOT);
{COMMENT_BLOCK}								  										 {fprintf("block_comment_on_line :%d",yylineno);}
{COMMENT_LINE}								  										 {fprintf("block_line_on_line :%d",yylineno);}	



{COMMENT_BLOCK_ERROR}                   {fprintf(stderr,"comment_not_closed line :%d",yylineno);}
{STRING_BLOCK_ERROR}                    {fprintf(stderr,"string_not_closed line :%d",yylineno);}

{iderrone}                              {printf("illegal identifier \'%s\' line :%d",yytext,yylineno);}


%%

int yywrap(void)
{
	return(1);
}
