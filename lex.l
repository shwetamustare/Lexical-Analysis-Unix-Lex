%{
int charcount=0,wordcount=0,linecount=1;
%}

letter[a-zA-Z]
digit[0-9]

%%
\n {linecount++;}
\/\/.* ;
"/*"(.*|[\n])*"*/" {}
void |
int |
char |
include |
main |
printf |
if |
for |
break |
return |
while {printf ("\n line %d\t\t|\t%s\t|\tkeyword\t\t\t|\n",linecount,yytext);}
"+" |
"-" |
"*" |
"/" {printf ("\n line %d\t\t|\t%s\t|\toperator\t\t|\n",linecount,yytext);}
"(" |
")" {printf ("\n line %d\t\t|\t%s\t|\tparanthesis\t\t|\n",linecount,yytext);}
"{" |
"[" |
"]" |
"}" {printf ("\n line %d\t\t|\t%s\t|\tbrackets\t\t|\n",linecount,yytext);}
"=" {printf ("\n line %d\t\t|\t%s\t|\tassignment operator\t|\n",linecount,yytext);}
{digit}+ {printf ("\n line %d\t\t|\t%s\t|\tinteger constant\t|\n",linecount,yytext);}
{letter}({letter}|{digit})* {printf ("\n line %d\t\t|\t%s\t|\tidentifier\t\t|\n",linecount,yytext);}
"," |
";" {printf ("\n line %d\t\t|\t%s\t|\tspecial symbols\t\t|\n",linecount,yytext);}
. ;

%%

int main(int argc,char **argv)
{
FILE *fp;
fp=fopen(argv[1],"r");
yyin=fp;
printf("\nLine no.\t|\tlexeme\t|\ttoken");
printf("\n----------------------------------------------------------------\n");
yylex();
printf("------------------------------------------------------------------\n");
return 1;
}
yywrap()
{}

/*
[root@localhost]# lex lex.l
[root@localhost]# gcc lex.yy.c
[root@localhost]# ./a.out prog.c

Line no.	|	lexeme	|	token
-----------------------------------------------------------------
 line 3		|	int	|	keyword			|

 line 3		|	main	|	keyword			|

 line 3		|	(	|	paranthesis		|

 line 3		|	)	|	paranthesis		|

 line 3		|	{	|	brackets		|

 line 4		|	int	|	keyword			|

 line 4		|	a	|	identifier		|

 line 4		|	,	|	special symbols		|

 line 4		|	b	|	identifier		|

 line 4		|	,	|	special symbols		|

 line 4		|	c	|	identifier		|

 line 4		|	;	|	special symbols		|

 line 5		|	a	|	identifier		|

 line 5		|	=	|	assignment operator	|

 line 5		|	b	|	identifier		|

 line 5		|	+	|	operator		|

 line 5		|	c	|	identifier		|

 line 5		|	;	|	special symbols		|

 line 6		|	return	|	keyword			|

 line 6		|	0	|	integer constant	|

 line 6		|	;	|	special symbols		|

 line 7		|	}	|	brackets		|
-----------------------------------------------------------------

*/

