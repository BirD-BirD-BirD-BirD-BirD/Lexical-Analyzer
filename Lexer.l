import java.util.*;
%%

%class Lexer
%public
%unicode
%standalone

%{
	List<String> symbolTable = new ArrayList<String>();  
%}

LineTerminator  = \r|\n|\r\n	
string = \" [^\"]* \" 
WhiteSpace = {LineTerminator} | [\t\f]	
Comment = {TraditionalComment} | {EndOfLineComment}	
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"	
EndOfLineComment = "//" {string}* {LineTerminator}? 
Identifier = [A-Za-z][A-Za-z0-9]*	
DecIntegerLiteral = 0 | [1-9][0-9]* 
Operator = "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
Parenthesis = "(" | ")"
Semicolon = ";"
Keyword = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"
 
  

%%
	{Operator}
	{
		System.out.println("operator: " + yytext());
	} 

	{Parenthesis}
	{
		System.out.println("parenthesis: " + yytext());
	}

	{Semicolon}
	{
		System.out.println("semicolon: " + yytext());
	}

	{Keyword} 
	{
		System.out.println("keyword: " + yytext());
	}
	
	{DecIntegerLiteral}{Identifier}
	{
		System.out.println("error:" + yytext());
		System.exit(0);
	}

	{DecIntegerLiteral}
	{
		System.out.println("integer: " + yytext());
	}

	{Identifier}+
	{
		if(symbolTable.contains(yytext())){
			System.out.println("identifier \"" + yytext() + "\" already in symbol table");
		}else{
			symbolTable.add(yytext());
			System.out.println("new identifier: " + yytext());
		}
	}
	
	{string}
	{
		System.out.println("string: " + yytext());
	}

	{Comment}
	{}

	{WhiteSpace}
	{}

	[^ \t\r\n\f]
	{
		System.out.println("Error: " + yytext() + " does not align with any syntax");
	}

