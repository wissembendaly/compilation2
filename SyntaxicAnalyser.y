%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;

int yyerror(char const * msg);	
int yylex(void);

%}
%token SUP
%token NOT
%token CLASS
%token STATIC
%token EXTENDS
%token PRIVATE
%token PUBLIC
%token PACKAGE
%token IF
%token ELSE
%token WHILE
%token THIS
%token NEW
%token RETURN
%token LENGTH
%token VOID
%token MAIN
%token SYSTEM_OUT_PRINTLN
%token ID
%token STRING
%token STR
%token PROGRAM 
%token P_OUVRANTE
%token P_FERMANTE
%token CR_OUVRANTE
%token CR_FERMANTE
%token START_BLOCK
%token END_BLOCK
%token VIRGULE
%token POINT_VIRGULE
%token POINT
%token INTEGER_LITERAL
%token BOOLEAN_LITERAL
%token INEQUALITY
%token EQUALITY
%token SUBSTRACTION
%token MULTIPLICATION
%token AFFECTATION
%token DIVISION
%token ADD 
%token ET 
%token OR
%token INF





%start programme

%%

programme 				: MainClass  ClassDeclaration
                        | MainClass
						| MainClass  ClassDeclaration error  {yyerror ("Detection des declaration invalid"); }	
						;
MainClass               : CLASS ID START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK
                        | CLASS error START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK {yyerror (" invalid declaration : class name not found"); }
                        | CLASS ID error PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK {yyerror ("declaration invalid : '{' expected but not found"); }
                        | CLASS ID START_BLOCK PUBLIC STATIC VOID MAIN error STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK {yyerror ("declaration invalid : '(' expected but not found"); }
                        | CLASS ID START_BLOCK PUBLIC STATIC VOID error P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK {yyerror (" invalid declaration : class main not found"); }
                        | CLASS ID START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE error ID P_FERMANTE START_BLOCK Statement END_BLOCK END_BLOCK {yyerror (" invalid declaration : ']' expected but not found"); }
                        | CLASS ID START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID error START_BLOCK Statement END_BLOCK END_BLOCK {yyerror (" invalid declaration : ')' expected but not found"); }
                        | CLASS ID START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement error END_BLOCK {yyerror (" invalid declaration : '}' expected but not found"); }
                        | CLASS error START_BLOCK PUBLIC STATIC VOID MAIN P_OUVRANTE STR CR_OUVRANTE CR_FERMANTE ID P_FERMANTE START_BLOCK Statement END_BLOCK error {yyerror (" invalid declaration :'}' expected but not found"); }
                        ;
ClassDeclaration        : CLASS ID EXTENDS ID START_BLOCK VarDeclarations MethodDeclarations END_BLOCK
                        | CLASS ID EXTENDS ID START_BLOCK VarDeclarations END_BLOCK
                        | CLASS ID EXTENDS ID START_BLOCK MethodDeclarations END_BLOCK
                        | CLASS ID START_BLOCK VarDeclarations MethodDeclarations END_BLOCK
                        | CLASS ID START_BLOCK MethodDeclarations END_BLOCK
                        | CLASS ID START_BLOCK VarDeclarations END_BLOCK
                        | CLASS ID error VarDeclarations MethodDeclarations END_BLOCK {yyerror ("declaration invalid : '{' expect but not found"); }
                        | CLASS ID START_BLOCK VarDeclarations MethodDeclarations error {yyerror ("declaration invalid : '}' expect but not found"); }
                        | error ID START_BLOCK VarDeclarations MethodDeclarations END_BLOCK {yyerror ("declaration invalid : keyword class not found "); }
                        ;
VarDeclarations         : VarDeclaration VarDeclarations
                        | VarDeclaration
                        ;
MethodDeclarations      : MethodDeclaration MethodDeclarations
                        | MethodDeclaration
                        ;
VarDeclaration          : type ID POINT_VIRGULE
                        | type ID error {yyerror ("declaration invalid : ';' expect but not found"); }
                        ;
MethodDeclaration       : PUBLIC type ID P_OUVRANTE P_FERMANTE START_BLOCK VarDeclarations Statements RETURN expression POINT_VIRGULE END_BLOCK
                        | PUBLIC type ID P_OUVRANTE argDeclarations P_FERMANTE START_BLOCK VarDeclarations Statements RETURN expression POINT_VIRGULE END_BLOCK
                        ;
Statements              : Statement Statements
                        | Statement
                        ;
argDeclarations         : argDeclaration VIRGULE argDeclarations
                        | argDeclaration
                        ;
argDeclaration          : type ID 
                        ;
type                    : INTEGER_LITERAL
                        | BOOLEAN_LITERAL
                        | INTEGER_LITERAL CR_FERMANTE CR_FERMANTE
                        | ID
                        ;
Statement               : START_BLOCK Statements END_BLOCK
                        | IF P_OUVRANTE expression P_FERMANTE Statement ELSE Statement
                        | WHILE P_OUVRANTE expression P_FERMANTE Statement
                        | SYSTEM_OUT_PRINTLN P_OUVRANTE expression P_FERMANTE POINT_VIRGULE
                        | ID AFFECTATION expression POINT_VIRGULE
                        | ID CR_OUVRANTE expression CR_FERMANTE AFFECTATION expression POINT_VIRGULE
                        ;  
expression              : INTEGER_LITERAL expressionComp
                        | BOOLEAN_LITERAL expressionComp
                        | ID expressionComp
                        | THIS expressionComp
                        | NEW INTEGER_LITERAL CR_OUVRANTE expression CR_FERMANTE expressionComp
                        | NEW ID P_OUVRANTE P_FERMANTE expressionComp
                        | NOT expression expressionComp
                        | P_OUVRANTE expression P_FERMANTE expressionComp
                        | STRING expressionComp
                        ;
expressionComp          : ET expression expressionComp
					    | OR expression expressionComp
						| SUP expression expressionComp
						| INF expression expressionComp
						| ADD expression expressionComp
						| SUBSTRACTION expression expressionComp
						| MULTIPLICATION expression expressionComp
						| CR_OUVRANTE expression CR_FERMANTE expression expressionComp
						| POINT LENGTH expression expressionComp
						| POINT ID P_OUVRANTE expressions P_FERMANTE expression expressionComp
						|
						;
expressions             : expression VIRGULE expressions
                        | expression 
                        ;                        
%% 



int yyerror(char const *msg) {
       
	
	fprintf(stderr, "%s %d\n", msg,yylineno);
	return 0;
	
	
}

extern FILE *yyin;

int main()
{
 yyparse();
 
 
}