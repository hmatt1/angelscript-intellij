package org.intellij.sdk.language;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;

import static com.intellij.psi.TokenType.BAD_CHARACTER;
import static com.intellij.psi.TokenType.WHITE_SPACE;
import static org.intellij.sdk.language.psi.AngelScriptElementTypes.*;

%%

%{
  public _AngelScriptLexer() {
    this((java.io.Reader)null);
  }
%}

%public
%class _AngelScriptLexer
%implements FlexLexer
%function advance
%type IElementType
%unicode

EOL=\R
WHITE_SPACE=\s+

T_ELIF_COMMENT="#elif" !([^]* "#endif" [^]*) ("#endif")?
T_BLOCK_COMMENT="/*" !([^]* "*/" [^]*) ("*/")?
T_LINE_COMMENT="//".*
T_PRE_COMMENT=#.*
T_WHITE_SPACE=[ \t\n\x0B\f\r]+
T_IS=is
T_BITS=(0b|0B|0o|0O|0d|0D|0x|0X)([0123456789AaBbCcDdEeF])+
T_IDENT=([A-Za-z_][_0-9A-Za-z]*)
T_NUMB=([0-9]+\.?[0-9]*(f|(e[0-9]+))?)
T_NUMB_2=(\.[0-9]*(f|(e[0-9]+))?)
T_STRING_SINGLE='([^'\\]|\\.)*'
T_STRING_DOUBLE=\"([^\"\\]|\\.)*\"
T_STRING_BLOCK=\"\"\"(.|\n)*\"\"\"

%%
<YYINITIAL> {
  {WHITE_SPACE}          { return WHITE_SPACE; }

  "null"                 { return T_NULL; }
  "true"                 { return T_TRUE; }
  "false"                { return T_FALSE; }
  "function"             { return T_FUNCTION; }
  "cast"                 { return T_CAST; }
  "void"                 { return T_VOID; }
  "case"                 { return T_CASE; }
  "default"              { return T_DEFAULT; }
  "return"               { return T_RETURN; }
  "try"                  { return T_TRY; }
  "catch"                { return T_CATCH; }
  "continue"             { return T_CONTINUE; }
  "if"                   { return T_IF; }
  "else"                 { return T_ELSE; }
  "do"                   { return T_DO; }
  "while"                { return T_WHILE; }
  "for"                  { return T_FOR; }
  "break"                { return T_BREAK; }
  "switch"               { return T_SWITCH; }
  "override"             { return T_OVERRIDE; }
  "final"                { return T_FINAL; }
  "explicit"             { return T_EXPLICIT; }
  "property"             { return T_PROPERTY; }
  "int"                  { return T_INT; }
  "int8"                 { return T_INT8; }
  "int16"                { return T_INT16; }
  "int32"                { return T_INT32; }
  "int64"                { return T_INT64; }
  "uint"                 { return T_UINT; }
  "uint8"                { return T_UINT8; }
  "uint16"               { return T_UINT16; }
  "uint32"               { return T_UINT32; }
  "uint64"               { return T_UINT64; }
  "float"                { return T_FLOAT; }
  "double"               { return T_DOUBLE; }
  "bool"                 { return T_BOOL; }
  "auto"                 { return T_AUTO; }
  "const"                { return T_CONST; }
  "in"                   { return T_IN; }
  "out"                  { return T_OUT; }
  "inout"                { return T_INOUT; }
  "mixin"                { return T_MIXIN; }
  "private"              { return T_PRIVATE; }
  "protected"            { return T_PROTECTED; }
  "external"             { return T_EXTERNAL; }
  "shared"               { return T_SHARED; }
  "funcdef"              { return T_FUNCDEF; }
  "enum"                 { return T_ENUM; }
  "import"               { return T_IMPORT; }
  "from"                 { return T_FROM; }
  "interface"            { return T_INTERFACE; }
  "namespace"            { return T_NAMESPACE; }
  "typedef"              { return T_TYPEDEF; }
  "abstract"             { return T_ABSTRACT; }
  "class"                { return T_CLASS; }
  "struct"               { return T_STRUCT; }
  "{"                    { return T_LBRACE; }
  "}"                    { return T_RBRACE; }
  "["                    { return T_LBRACK; }
  "]"                    { return T_RBRACK; }
  "("                    { return T_LPAREN; }
  ")"                    { return T_RPAREN; }
  ":"                    { return T_COLON; }
  ";"                    { return T_SEMICOLON; }
  ","                    { return T_COMMA; }
  "="                    { return T_ASSIGN; }
  "=="                   { return T_EQ; }
  "!"                    { return T_NOT; }
  "!="                   { return T_NOT_EQ; }
  "+"                    { return T_PLUS; }
  "++"                   { return T_PLUS_PLUS; }
  "+="                   { return T_PLUS_ASSIGN; }
  "-"                    { return T_MINUS; }
  "--"                   { return T_MINUS_MINUS; }
  "-="                   { return T_MINUS_ASSIGN; }
  "||"                   { return T_COND_OR; }
  "|="                   { return T_BIT_OR_ASSIGN; }
  "&"                    { return T_BIT_AND; }
  "&^="                  { return T_BIT_CLEAR_ASSIGN; }
  "&^"                   { return T_BIT_CLEAR; }
  "&&"                   { return T_COND_AND; }
  "&="                   { return T_BIT_AND_ASSIGN; }
  "|"                    { return T_BIT_OR; }
  "<"                    { return T_LESS; }
  "<<="                  { return T_SHIFT_LEFT_ASSIGN; }
  "<-"                   { return T_SEND_CHANNEL; }
  "<="                   { return T_LESS_OR_EQUAL; }
  "^"                    { return T_BIT_XOR; }
  "^="                   { return T_BIT_XOR_ASSIGN; }
  "^^"                   { return T_LOGIC_XOR; }
  "*="                   { return T_MUL_ASSIGN; }
  "*"                    { return T_MUL; }
  "/="                   { return T_QUOTIENT_ASSIGN; }
  "/"                    { return T_QUOTIENT; }
  "%"                    { return T_REMAINDER; }
  "%="                   { return T_REMAINDER_ASSIGN; }
  ">"                    { return T_GREATER; }
  ">>="                  { return T_SHIFT_RIGHT_ASSIGN; }
  ">="                   { return T_GREATER_OR_EQUAL; }
  ":="                   { return T_VAR_ASSIGN; }
  "."                    { return T_DOT; }
  "..."                  { return T_TRIPLE_DOT; }
  "**"                   { return T_EXPONENT; }
  "and"                  { return T_AND_TEXT; }
  "or"                   { return T_OR_TEXT; }
  "xor"                  { return T_XOR_TEST; }
  "**="                  { return T_EXP_ASSIGN; }
  ">>>="                 { return T_SHIFT_SHIFT_RIGHT_ASSIN; }
  "?"                    { return T_QUEST; }
  "~"                    { return T_TILDE; }
  "@"                    { return T_AT; }
  "::"                   { return T_COLONCOLON; }

  {T_ELIF_COMMENT}       { return T_ELIF_COMMENT; }
  {T_BLOCK_COMMENT}      { return T_BLOCK_COMMENT; }
  {T_LINE_COMMENT}       { return T_LINE_COMMENT; }
  {T_PRE_COMMENT}        { return T_PRE_COMMENT; }
  {T_WHITE_SPACE}        { return T_WHITE_SPACE; }
  {T_IS}                 { return T_IS; }
  {T_BITS}               { return T_BITS; }
  {T_IDENT}              { return T_IDENT; }
  {T_NUMB}               { return T_NUMB; }
  {T_NUMB_2}             { return T_NUMB_2; }
  {T_STRING_SINGLE}      { return T_STRING_SINGLE; }
  {T_STRING_DOUBLE}      { return T_STRING_DOUBLE; }
  {T_STRING_BLOCK}       { return T_STRING_BLOCK; }

}

[^] { return BAD_CHARACTER; }
