// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import com.intellij.psi.tree.IElementType;
import com.intellij.psi.PsiElement;
import com.intellij.lang.ASTNode;
import org.intellij.sdk.language.psi.impl.*;

public interface AngelScriptElementTypes {

  IElementType ARGLIST = new AngelScriptElementType("ARGLIST");
  IElementType ASSIGN = new AngelScriptElementType("ASSIGN");
  IElementType ASSIGNOP = new AngelScriptElementType("ASSIGNOP");
  IElementType BITOP = new AngelScriptElementType("BITOP");
  IElementType BITS = new AngelScriptElementType("BITS");
  IElementType BREAK = new AngelScriptElementType("BREAK");
  IElementType CASE = new AngelScriptElementType("CASE");
  IElementType CAST = new AngelScriptElementType("CAST");
  IElementType CLAZZ = new AngelScriptElementType("CLAZZ");
  IElementType COMPOP = new AngelScriptElementType("COMPOP");
  IElementType CONDITION = new AngelScriptElementType("CONDITION");
  IElementType CONSTRUCTCALL = new AngelScriptElementType("CONSTRUCTCALL");
  IElementType CONTINUE = new AngelScriptElementType("CONTINUE");
  IElementType DATATYPE = new AngelScriptElementType("DATATYPE");
  IElementType DOWHILE = new AngelScriptElementType("DOWHILE");
  IElementType ENUM = new AngelScriptElementType("ENUM");
  IElementType EXPR = new AngelScriptElementType("EXPR");
  IElementType EXPROP = new AngelScriptElementType("EXPROP");
  IElementType EXPRPOSTOP = new AngelScriptElementType("EXPRPOSTOP");
  IElementType EXPRPREOP = new AngelScriptElementType("EXPRPREOP");
  IElementType EXPRSTAT = new AngelScriptElementType("EXPRSTAT");
  IElementType EXPRTERM = new AngelScriptElementType("EXPRTERM");
  IElementType EXPRVALUE = new AngelScriptElementType("EXPRVALUE");
  IElementType FOR = new AngelScriptElementType("FOR");
  IElementType FUNC = new AngelScriptElementType("FUNC");
  IElementType FUNCATTR = new AngelScriptElementType("FUNCATTR");
  IElementType FUNCC = new AngelScriptElementType("FUNCC");
  IElementType FUNCCALL = new AngelScriptElementType("FUNCCALL");
  IElementType FUNCDEF = new AngelScriptElementType("FUNCDEF");
  IElementType IDENTIFIER = new AngelScriptElementType("IDENTIFIER");
  IElementType IF = new AngelScriptElementType("IF");
  IElementType IMPORT = new AngelScriptElementType("IMPORT");
  IElementType INITLIST = new AngelScriptElementType("INITLIST");
  IElementType INTERFACE = new AngelScriptElementType("INTERFACE");
  IElementType INTFMTHD = new AngelScriptElementType("INTFMTHD");
  IElementType LAMBDA = new AngelScriptElementType("LAMBDA");
  IElementType LITERAL = new AngelScriptElementType("LITERAL");
  IElementType LOGICOP = new AngelScriptElementType("LOGICOP");
  IElementType MATHOP = new AngelScriptElementType("MATHOP");
  IElementType MIXIN = new AngelScriptElementType("MIXIN");
  IElementType NAMESPA = new AngelScriptElementType("NAMESPA");
  IElementType NUMBER = new AngelScriptElementType("NUMBER");
  IElementType PARAMLIST = new AngelScriptElementType("PARAMLIST");
  IElementType PRIMTYPE = new AngelScriptElementType("PRIMTYPE");
  IElementType RETURN = new AngelScriptElementType("RETURN");
  IElementType SCOPE = new AngelScriptElementType("SCOPE");
  IElementType SETTING = new AngelScriptElementType("SETTING");
  IElementType STATBLOCK = new AngelScriptElementType("STATBLOCK");
  IElementType STATEMENT = new AngelScriptElementType("STATEMENT");
  IElementType STRING = new AngelScriptElementType("STRING");
  IElementType STRUCT = new AngelScriptElementType("STRUCT");
  IElementType SWITCH = new AngelScriptElementType("SWITCH");
  IElementType TRY = new AngelScriptElementType("TRY");
  IElementType TYPE = new AngelScriptElementType("TYPE");
  IElementType TYPEDEF = new AngelScriptElementType("TYPEDEF");
  IElementType TYPEMOD = new AngelScriptElementType("TYPEMOD");
  IElementType VAR = new AngelScriptElementType("VAR");
  IElementType VARACCESS = new AngelScriptElementType("VARACCESS");
  IElementType VIRTPROP = new AngelScriptElementType("VIRTPROP");
  IElementType WHILE = new AngelScriptElementType("WHILE");

  IElementType T_ABSTRACT = new AngelScriptTokenType("abstract");
  IElementType T_AND_TEXT = new AngelScriptTokenType("and");
  IElementType T_ASSIGN = new AngelScriptTokenType("=");
  IElementType T_AT = new AngelScriptTokenType("@");
  IElementType T_AUTO = new AngelScriptTokenType("auto");
  IElementType T_BITS = new AngelScriptTokenType("t_bits");
  IElementType T_BIT_AND = new AngelScriptTokenType("&");
  IElementType T_BIT_AND_ASSIGN = new AngelScriptTokenType("&=");
  IElementType T_BIT_CLEAR = new AngelScriptTokenType("&^");
  IElementType T_BIT_CLEAR_ASSIGN = new AngelScriptTokenType("&^=");
  IElementType T_BIT_OR = new AngelScriptTokenType("|");
  IElementType T_BIT_OR_ASSIGN = new AngelScriptTokenType("|=");
  IElementType T_BIT_XOR = new AngelScriptTokenType("^");
  IElementType T_BIT_XOR_ASSIGN = new AngelScriptTokenType("^=");
  IElementType T_BLOCK_COMMENT = new AngelScriptTokenType("t_block_comment");
  IElementType T_BOOL = new AngelScriptTokenType("bool");
  IElementType T_BREAK = new AngelScriptTokenType("break");
  IElementType T_CASE = new AngelScriptTokenType("case");
  IElementType T_CAST = new AngelScriptTokenType("cast");
  IElementType T_CATCH = new AngelScriptTokenType("catch");
  IElementType T_CLASS = new AngelScriptTokenType("class");
  IElementType T_COLON = new AngelScriptTokenType(":");
  IElementType T_COLONCOLON = new AngelScriptTokenType("::");
  IElementType T_COMMA = new AngelScriptTokenType(",");
  IElementType T_COND_AND = new AngelScriptTokenType("&&");
  IElementType T_COND_OR = new AngelScriptTokenType("||");
  IElementType T_CONST = new AngelScriptTokenType("const");
  IElementType T_CONTINUE = new AngelScriptTokenType("continue");
  IElementType T_DEFAULT = new AngelScriptTokenType("default");
  IElementType T_DO = new AngelScriptTokenType("do");
  IElementType T_DOT = new AngelScriptTokenType(".");
  IElementType T_DOUBLE = new AngelScriptTokenType("double");
  IElementType T_ELIF_COMMENT = new AngelScriptTokenType("t_elif_comment");
  IElementType T_ELSE = new AngelScriptTokenType("else");
  IElementType T_ENUM = new AngelScriptTokenType("enum");
  IElementType T_EQ = new AngelScriptTokenType("==");
  IElementType T_EXPLICIT = new AngelScriptTokenType("explicit");
  IElementType T_EXPONENT = new AngelScriptTokenType("**");
  IElementType T_EXP_ASSIGN = new AngelScriptTokenType("**=");
  IElementType T_EXTERNAL = new AngelScriptTokenType("external");
  IElementType T_FALSE = new AngelScriptTokenType("false");
  IElementType T_FINAL = new AngelScriptTokenType("final");
  IElementType T_FLOAT = new AngelScriptTokenType("float");
  IElementType T_FOR = new AngelScriptTokenType("for");
  IElementType T_FROM = new AngelScriptTokenType("from");
  IElementType T_FUNCDEF = new AngelScriptTokenType("funcdef");
  IElementType T_FUNCTION = new AngelScriptTokenType("function");
  IElementType T_GREATER = new AngelScriptTokenType(">");
  IElementType T_GREATER_OR_EQUAL = new AngelScriptTokenType(">=");
  IElementType T_IDENT = new AngelScriptTokenType("t_ident");
  IElementType T_IF = new AngelScriptTokenType("if");
  IElementType T_IMPORT = new AngelScriptTokenType("import");
  IElementType T_IN = new AngelScriptTokenType("in");
  IElementType T_INOUT = new AngelScriptTokenType("inout");
  IElementType T_INT = new AngelScriptTokenType("int");
  IElementType T_INT16 = new AngelScriptTokenType("int16");
  IElementType T_INT32 = new AngelScriptTokenType("int32");
  IElementType T_INT64 = new AngelScriptTokenType("int64");
  IElementType T_INT8 = new AngelScriptTokenType("int8");
  IElementType T_INTERFACE = new AngelScriptTokenType("interface");
  IElementType T_IS = new AngelScriptTokenType("t_IS");
  IElementType T_LBRACE = new AngelScriptTokenType("{");
  IElementType T_LBRACK = new AngelScriptTokenType("[");
  IElementType T_LESS = new AngelScriptTokenType("<");
  IElementType T_LESS_OR_EQUAL = new AngelScriptTokenType("<=");
  IElementType T_LINE_COMMENT = new AngelScriptTokenType("t_line_comment");
  IElementType T_LOGIC_XOR = new AngelScriptTokenType("^^");
  IElementType T_LPAREN = new AngelScriptTokenType("(");
  IElementType T_MINUS = new AngelScriptTokenType("-");
  IElementType T_MINUS_ASSIGN = new AngelScriptTokenType("-=");
  IElementType T_MINUS_MINUS = new AngelScriptTokenType("--");
  IElementType T_MIXIN = new AngelScriptTokenType("mixin");
  IElementType T_MUL = new AngelScriptTokenType("*");
  IElementType T_MUL_ASSIGN = new AngelScriptTokenType("*=");
  IElementType T_NAMESPACE = new AngelScriptTokenType("namespace");
  IElementType T_NOT = new AngelScriptTokenType("!");
  IElementType T_NOT_EQ = new AngelScriptTokenType("!=");
  IElementType T_NULL = new AngelScriptTokenType("null");
  IElementType T_NUMB = new AngelScriptTokenType("t_numb");
  IElementType T_NUMB_2 = new AngelScriptTokenType("t_numb_2");
  IElementType T_OR_TEXT = new AngelScriptTokenType("or");
  IElementType T_OUT = new AngelScriptTokenType("out");
  IElementType T_OVERRIDE = new AngelScriptTokenType("override");
  IElementType T_PLUS = new AngelScriptTokenType("+");
  IElementType T_PLUS_ASSIGN = new AngelScriptTokenType("+=");
  IElementType T_PLUS_PLUS = new AngelScriptTokenType("++");
  IElementType T_PRE_COMMENT = new AngelScriptTokenType("t_pre_comment");
  IElementType T_PRIVATE = new AngelScriptTokenType("private");
  IElementType T_PROPERTY = new AngelScriptTokenType("property");
  IElementType T_PROTECTED = new AngelScriptTokenType("protected");
  IElementType T_QUEST = new AngelScriptTokenType("?");
  IElementType T_QUOTIENT = new AngelScriptTokenType("/");
  IElementType T_QUOTIENT_ASSIGN = new AngelScriptTokenType("/=");
  IElementType T_RBRACE = new AngelScriptTokenType("}");
  IElementType T_RBRACK = new AngelScriptTokenType("]");
  IElementType T_REMAINDER = new AngelScriptTokenType("%");
  IElementType T_REMAINDER_ASSIGN = new AngelScriptTokenType("%=");
  IElementType T_RETURN = new AngelScriptTokenType("return");
  IElementType T_RPAREN = new AngelScriptTokenType(")");
  IElementType T_SEMICOLON = new AngelScriptTokenType(";");
  IElementType T_SEND_CHANNEL = new AngelScriptTokenType("<-");
  IElementType T_SHARED = new AngelScriptTokenType("shared");
  IElementType T_SHIFT_LEFT_ASSIGN = new AngelScriptTokenType("<<=");
  IElementType T_SHIFT_RIGHT_ASSIGN = new AngelScriptTokenType(">>=");
  IElementType T_SHIFT_SHIFT_RIGHT_ASSIN = new AngelScriptTokenType(">>>=");
  IElementType T_STRING_BLOCK = new AngelScriptTokenType("t_string_block");
  IElementType T_STRING_DOUBLE = new AngelScriptTokenType("t_string_double");
  IElementType T_STRING_SINGLE = new AngelScriptTokenType("t_string_single");
  IElementType T_STRUCT = new AngelScriptTokenType("struct");
  IElementType T_SWITCH = new AngelScriptTokenType("switch");
  IElementType T_TILDE = new AngelScriptTokenType("~");
  IElementType T_TRIPLE_DOT = new AngelScriptTokenType("...");
  IElementType T_TRUE = new AngelScriptTokenType("true");
  IElementType T_TRY = new AngelScriptTokenType("try");
  IElementType T_TYPEDEF = new AngelScriptTokenType("typedef");
  IElementType T_UINT = new AngelScriptTokenType("uint");
  IElementType T_UINT16 = new AngelScriptTokenType("uint16");
  IElementType T_UINT32 = new AngelScriptTokenType("uint32");
  IElementType T_UINT64 = new AngelScriptTokenType("uint64");
  IElementType T_UINT8 = new AngelScriptTokenType("uint8");
  IElementType T_VAR_ASSIGN = new AngelScriptTokenType(":=");
  IElementType T_VOID = new AngelScriptTokenType("void");
  IElementType T_WHILE = new AngelScriptTokenType("while");
  IElementType T_XOR_TEST = new AngelScriptTokenType("xor");

  class Factory {
    public static PsiElement createElement(ASTNode node) {
      IElementType type = node.getElementType();
      if (type == ARGLIST) {
        return new AngelScriptArglistImpl(node);
      }
      else if (type == ASSIGN) {
        return new AngelScriptAssignImpl(node);
      }
      else if (type == ASSIGNOP) {
        return new AngelScriptAssignopImpl(node);
      }
      else if (type == BITOP) {
        return new AngelScriptBitopImpl(node);
      }
      else if (type == BITS) {
        return new AngelScriptBitsImpl(node);
      }
      else if (type == BREAK) {
        return new AngelScriptBreakImpl(node);
      }
      else if (type == CASE) {
        return new AngelScriptCaseImpl(node);
      }
      else if (type == CAST) {
        return new AngelScriptCastImpl(node);
      }
      else if (type == CLAZZ) {
        return new AngelScriptClazzImpl(node);
      }
      else if (type == COMPOP) {
        return new AngelScriptCompopImpl(node);
      }
      else if (type == CONDITION) {
        return new AngelScriptConditionImpl(node);
      }
      else if (type == CONSTRUCTCALL) {
        return new AngelScriptConstructcallImpl(node);
      }
      else if (type == CONTINUE) {
        return new AngelScriptContinueImpl(node);
      }
      else if (type == DATATYPE) {
        return new AngelScriptDatatypeImpl(node);
      }
      else if (type == DOWHILE) {
        return new AngelScriptDowhileImpl(node);
      }
      else if (type == ENUM) {
        return new AngelScriptEnumImpl(node);
      }
      else if (type == EXPR) {
        return new AngelScriptExprImpl(node);
      }
      else if (type == EXPROP) {
        return new AngelScriptExpropImpl(node);
      }
      else if (type == EXPRPOSTOP) {
        return new AngelScriptExprpostopImpl(node);
      }
      else if (type == EXPRPREOP) {
        return new AngelScriptExprpreopImpl(node);
      }
      else if (type == EXPRSTAT) {
        return new AngelScriptExprstatImpl(node);
      }
      else if (type == EXPRTERM) {
        return new AngelScriptExprtermImpl(node);
      }
      else if (type == EXPRVALUE) {
        return new AngelScriptExprvalueImpl(node);
      }
      else if (type == FOR) {
        return new AngelScriptForImpl(node);
      }
      else if (type == FUNC) {
        return new AngelScriptFuncImpl(node);
      }
      else if (type == FUNCATTR) {
        return new AngelScriptFuncattrImpl(node);
      }
      else if (type == FUNCC) {
        return new AngelScriptFunccImpl(node);
      }
      else if (type == FUNCCALL) {
        return new AngelScriptFunccallImpl(node);
      }
      else if (type == FUNCDEF) {
        return new AngelScriptFuncdefImpl(node);
      }
      else if (type == IDENTIFIER) {
        return new AngelScriptIdentifierImpl(node);
      }
      else if (type == IF) {
        return new AngelScriptIfImpl(node);
      }
      else if (type == IMPORT) {
        return new AngelScriptImportImpl(node);
      }
      else if (type == INITLIST) {
        return new AngelScriptInitlistImpl(node);
      }
      else if (type == INTERFACE) {
        return new AngelScriptInterfaceImpl(node);
      }
      else if (type == INTFMTHD) {
        return new AngelScriptIntfmthdImpl(node);
      }
      else if (type == LAMBDA) {
        return new AngelScriptLambdaImpl(node);
      }
      else if (type == LITERAL) {
        return new AngelScriptLiteralImpl(node);
      }
      else if (type == LOGICOP) {
        return new AngelScriptLogicopImpl(node);
      }
      else if (type == MATHOP) {
        return new AngelScriptMathopImpl(node);
      }
      else if (type == MIXIN) {
        return new AngelScriptMixinImpl(node);
      }
      else if (type == NAMESPA) {
        return new AngelScriptNamespaImpl(node);
      }
      else if (type == NUMBER) {
        return new AngelScriptNumberImpl(node);
      }
      else if (type == PARAMLIST) {
        return new AngelScriptParamlistImpl(node);
      }
      else if (type == PRIMTYPE) {
        return new AngelScriptPrimtypeImpl(node);
      }
      else if (type == RETURN) {
        return new AngelScriptReturnImpl(node);
      }
      else if (type == SCOPE) {
        return new AngelScriptScopeImpl(node);
      }
      else if (type == SETTING) {
        return new AngelScriptSettingImpl(node);
      }
      else if (type == STATBLOCK) {
        return new AngelScriptStatblockImpl(node);
      }
      else if (type == STATEMENT) {
        return new AngelScriptStatementImpl(node);
      }
      else if (type == STRING) {
        return new AngelScriptStringImpl(node);
      }
      else if (type == STRUCT) {
        return new AngelScriptStructImpl(node);
      }
      else if (type == SWITCH) {
        return new AngelScriptSwitchImpl(node);
      }
      else if (type == TRY) {
        return new AngelScriptTryImpl(node);
      }
      else if (type == TYPE) {
        return new AngelScriptTypeImpl(node);
      }
      else if (type == TYPEDEF) {
        return new AngelScriptTypedefImpl(node);
      }
      else if (type == TYPEMOD) {
        return new AngelScriptTypemodImpl(node);
      }
      else if (type == VAR) {
        return new AngelScriptVarImpl(node);
      }
      else if (type == VARACCESS) {
        return new AngelScriptVaraccessImpl(node);
      }
      else if (type == VIRTPROP) {
        return new AngelScriptVirtpropImpl(node);
      }
      else if (type == WHILE) {
        return new AngelScriptWhileImpl(node);
      }
      throw new AssertionError("Unknown element type: " + type);
    }
  }
}
