// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.parser;

import com.intellij.lang.PsiBuilder;
import com.intellij.lang.PsiBuilder.Marker;
import static org.intellij.sdk.language.psi.AngelScriptElementTypes.*;
import static org.intellij.sdk.language.parser.AngelScriptParserUtil.*;
import com.intellij.psi.tree.IElementType;
import com.intellij.lang.ASTNode;
import com.intellij.psi.tree.TokenSet;
import com.intellij.lang.PsiParser;
import com.intellij.lang.LightPsiParser;

@SuppressWarnings({"SimplifiableIfStatement", "UnusedAssignment"})
public class AngelScriptParser implements PsiParser, LightPsiParser {

  public ASTNode parse(IElementType t, PsiBuilder b) {
    parseLight(t, b);
    return b.getTreeBuilt();
  }

  public void parseLight(IElementType t, PsiBuilder b) {
    boolean r;
    b = adapt_builder_(t, b, this, null);
    Marker m = enter_section_(b, 0, _COLLAPSE_, null);
    r = parse_root_(t, b);
    exit_section_(b, 0, m, t, r, true, TRUE_CONDITION);
  }

  protected boolean parse_root_(IElementType t, PsiBuilder b) {
    return parse_root_(t, b, 0);
  }

  static boolean parse_root_(IElementType t, PsiBuilder b, int l) {
    return SCRIPT(b, l + 1);
  }

  /* ********************************************************** */
  // '(' ((IDENTIFIER ':')? ASSIGN (',' (IDENTIFIER ':')? ASSIGN)*)? ')'
  public static boolean ARGLIST(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST")) return false;
    if (!nextTokenIs(b, T_LPAREN)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LPAREN);
    r = r && ARGLIST_1(b, l + 1);
    r = r && consumeToken(b, T_RPAREN);
    exit_section_(b, m, ARGLIST, r);
    return r;
  }

  // ((IDENTIFIER ':')? ASSIGN (',' (IDENTIFIER ':')? ASSIGN)*)?
  private static boolean ARGLIST_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1")) return false;
    ARGLIST_1_0(b, l + 1);
    return true;
  }

  // (IDENTIFIER ':')? ASSIGN (',' (IDENTIFIER ':')? ASSIGN)*
  private static boolean ARGLIST_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = ARGLIST_1_0_0(b, l + 1);
    r = r && ASSIGN(b, l + 1);
    r = r && ARGLIST_1_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ':')?
  private static boolean ARGLIST_1_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_0")) return false;
    ARGLIST_1_0_0_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ':'
  private static boolean ARGLIST_1_0_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' (IDENTIFIER ':')? ASSIGN)*
  private static boolean ARGLIST_1_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!ARGLIST_1_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "ARGLIST_1_0_2", c)) break;
    }
    return true;
  }

  // ',' (IDENTIFIER ':')? ASSIGN
  private static boolean ARGLIST_1_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && ARGLIST_1_0_2_0_1(b, l + 1);
    r = r && ASSIGN(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ':')?
  private static boolean ARGLIST_1_0_2_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_2_0_1")) return false;
    ARGLIST_1_0_2_0_1_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ':'
  private static boolean ARGLIST_1_0_2_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ARGLIST_1_0_2_0_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // CONDITION ( ASSIGNOP ASSIGN )?
  public static boolean ASSIGN(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ASSIGN")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, ASSIGN, "<assign>");
    r = CONDITION(b, l + 1);
    r = r && ASSIGN_1(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ( ASSIGNOP ASSIGN )?
  private static boolean ASSIGN_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ASSIGN_1")) return false;
    ASSIGN_1_0(b, l + 1);
    return true;
  }

  // ASSIGNOP ASSIGN
  private static boolean ASSIGN_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ASSIGN_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = ASSIGNOP(b, l + 1);
    r = r && ASSIGN(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // '=' | '+=' | '-=' | '*=' | '/=' | '|=' | '&=' | '^=' | '%=' | '**=' | '<<=' | '>>=' | '>>>='
  public static boolean ASSIGNOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ASSIGNOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, ASSIGNOP, "<assignop>");
    r = consumeToken(b, T_ASSIGN);
    if (!r) r = consumeToken(b, T_PLUS_ASSIGN);
    if (!r) r = consumeToken(b, T_MINUS_ASSIGN);
    if (!r) r = consumeToken(b, T_MUL_ASSIGN);
    if (!r) r = consumeToken(b, T_QUOTIENT_ASSIGN);
    if (!r) r = consumeToken(b, T_BIT_OR_ASSIGN);
    if (!r) r = consumeToken(b, T_BIT_AND_ASSIGN);
    if (!r) r = consumeToken(b, T_BIT_XOR_ASSIGN);
    if (!r) r = consumeToken(b, T_REMAINDER_ASSIGN);
    if (!r) r = consumeToken(b, T_EXP_ASSIGN);
    if (!r) r = consumeToken(b, T_SHIFT_LEFT_ASSIGN);
    if (!r) r = consumeToken(b, T_SHIFT_RIGHT_ASSIGN);
    if (!r) r = consumeToken(b, T_SHIFT_SHIFT_RIGHT_ASSIN);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // '&' | '|' | '^' | t_LESS t_LESS t_LESS | t_LESS t_LESS | t_GREATER t_GREATER t_GREATER | t_GREATER t_GREATER
  public static boolean BITOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "BITOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, BITOP, "<bitop>");
    r = consumeToken(b, T_BIT_AND);
    if (!r) r = consumeToken(b, T_BIT_OR);
    if (!r) r = consumeToken(b, T_BIT_XOR);
    if (!r) r = parseTokens(b, 0, T_LESS, T_LESS, T_LESS);
    if (!r) r = parseTokens(b, 0, T_LESS, T_LESS);
    if (!r) r = parseTokens(b, 0, T_GREATER, T_GREATER, T_GREATER);
    if (!r) r = parseTokens(b, 0, T_GREATER, T_GREATER);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // t_bits
  public static boolean BITS(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "BITS")) return false;
    if (!nextTokenIs(b, T_BITS)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_BITS);
    exit_section_(b, m, BITS, r);
    return r;
  }

  /* ********************************************************** */
  // 'break' ';'
  public static boolean BREAK(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "BREAK")) return false;
    if (!nextTokenIs(b, T_BREAK)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, BREAK, null);
    r = consumeTokens(b, 1, T_BREAK, T_SEMICOLON);
    p = r; // pin = 1
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // (('case' EXPR) | 'default') ':' STATEMENT*
  public static boolean CASE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CASE")) return false;
    if (!nextTokenIs(b, "<case>", T_CASE, T_DEFAULT)) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, CASE, "<case>");
    r = CASE_0(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    r = r && CASE_2(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('case' EXPR) | 'default'
  private static boolean CASE_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CASE_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = CASE_0_0(b, l + 1);
    if (!r) r = consumeToken(b, T_DEFAULT);
    exit_section_(b, m, null, r);
    return r;
  }

  // 'case' EXPR
  private static boolean CASE_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CASE_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_CASE);
    r = r && EXPR(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // STATEMENT*
  private static boolean CASE_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CASE_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!STATEMENT(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "CASE_2", c)) break;
    }
    return true;
  }

  /* ********************************************************** */
  // 'cast' '<' TYPE '>' '(' ASSIGN ')'
  public static boolean CAST(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CAST")) return false;
    if (!nextTokenIs(b, T_CAST)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, CAST, null);
    r = consumeTokens(b, 1, T_CAST, T_LESS);
    p = r; // pin = 1
    r = r && report_error_(b, TYPE(b, l + 1));
    r = p && report_error_(b, consumeTokens(b, -1, T_GREATER, T_LPAREN)) && r;
    r = p && report_error_(b, ASSIGN(b, l + 1)) && r;
    r = p && consumeToken(b, T_RPAREN) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // ('shared' | 'abstract' | 'final' | 'external')* t_class IDENTIFIER (';' | ((':' VARACCESS (',' VARACCESS)*)? '{' (SETTING | VIRTPROP | FUNC | FUNCC | VAR | FUNCDEF | STATEMENT | STRUCT )* '}'))
  public static boolean CLAZZ(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ")) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, CLAZZ, "<clazz>");
    r = CLAZZ_0(b, l + 1);
    r = r && consumeToken(b, T_CLASS);
    p = r; // pin = 2
    r = r && report_error_(b, IDENTIFIER(b, l + 1));
    r = p && CLAZZ_3(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ('shared' | 'abstract' | 'final' | 'external')*
  private static boolean CLAZZ_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!CLAZZ_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "CLAZZ_0", c)) break;
    }
    return true;
  }

  // 'shared' | 'abstract' | 'final' | 'external'
  private static boolean CLAZZ_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_SHARED);
    if (!r) r = consumeToken(b, T_ABSTRACT);
    if (!r) r = consumeToken(b, T_FINAL);
    if (!r) r = consumeToken(b, T_EXTERNAL);
    return r;
  }

  // ';' | ((':' VARACCESS (',' VARACCESS)*)? '{' (SETTING | VIRTPROP | FUNC | FUNCC | VAR | FUNCDEF | STATEMENT | STRUCT )* '}')
  private static boolean CLAZZ_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = CLAZZ_3_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (':' VARACCESS (',' VARACCESS)*)? '{' (SETTING | VIRTPROP | FUNC | FUNCC | VAR | FUNCDEF | STATEMENT | STRUCT )* '}'
  private static boolean CLAZZ_3_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = CLAZZ_3_1_0(b, l + 1);
    r = r && consumeToken(b, T_LBRACE);
    r = r && CLAZZ_3_1_2(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, m, null, r);
    return r;
  }

  // (':' VARACCESS (',' VARACCESS)*)?
  private static boolean CLAZZ_3_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_0")) return false;
    CLAZZ_3_1_0_0(b, l + 1);
    return true;
  }

  // ':' VARACCESS (',' VARACCESS)*
  private static boolean CLAZZ_3_1_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COLON);
    r = r && VARACCESS(b, l + 1);
    r = r && CLAZZ_3_1_0_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' VARACCESS)*
  private static boolean CLAZZ_3_1_0_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_0_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!CLAZZ_3_1_0_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "CLAZZ_3_1_0_0_2", c)) break;
    }
    return true;
  }

  // ',' VARACCESS
  private static boolean CLAZZ_3_1_0_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_0_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && VARACCESS(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (SETTING | VIRTPROP | FUNC | FUNCC | VAR | FUNCDEF | STATEMENT | STRUCT )*
  private static boolean CLAZZ_3_1_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!CLAZZ_3_1_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "CLAZZ_3_1_2", c)) break;
    }
    return true;
  }

  // SETTING | VIRTPROP | FUNC | FUNCC | VAR | FUNCDEF | STATEMENT | STRUCT
  private static boolean CLAZZ_3_1_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CLAZZ_3_1_2_0")) return false;
    boolean r;
    r = SETTING(b, l + 1);
    if (!r) r = VIRTPROP(b, l + 1);
    if (!r) r = FUNC(b, l + 1);
    if (!r) r = FUNCC(b, l + 1);
    if (!r) r = VAR(b, l + 1);
    if (!r) r = FUNCDEF(b, l + 1);
    if (!r) r = STATEMENT(b, l + 1);
    if (!r) r = STRUCT(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // '==' | '!=' | t_LESS | '<=' | t_GREATER | '>=' | '!' t_IS | t_IS
  public static boolean COMPOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "COMPOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, COMPOP, "<compop>");
    r = consumeToken(b, T_EQ);
    if (!r) r = consumeToken(b, T_NOT_EQ);
    if (!r) r = consumeToken(b, T_LESS);
    if (!r) r = consumeToken(b, T_LESS_OR_EQUAL);
    if (!r) r = consumeToken(b, T_GREATER);
    if (!r) r = consumeToken(b, T_GREATER_OR_EQUAL);
    if (!r) r = parseTokens(b, 0, T_NOT, T_IS);
    if (!r) r = consumeToken(b, T_IS);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // EXPR ('?' ASSIGN ':' ASSIGN)?
  public static boolean CONDITION(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CONDITION")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, CONDITION, "<condition>");
    r = EXPR(b, l + 1);
    r = r && CONDITION_1(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('?' ASSIGN ':' ASSIGN)?
  private static boolean CONDITION_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CONDITION_1")) return false;
    CONDITION_1_0(b, l + 1);
    return true;
  }

  // '?' ASSIGN ':' ASSIGN
  private static boolean CONDITION_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CONDITION_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_QUEST);
    r = r && ASSIGN(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    r = r && ASSIGN(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // TYPE ARGLIST
  public static boolean CONSTRUCTCALL(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CONSTRUCTCALL")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, CONSTRUCTCALL, "<constructcall>");
    r = TYPE(b, l + 1);
    r = r && ARGLIST(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // 'continue' ';'
  public static boolean CONTINUE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "CONTINUE")) return false;
    if (!nextTokenIs(b, T_CONTINUE)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, CONTINUE, null);
    r = consumeTokens(b, 1, T_CONTINUE, T_SEMICOLON);
    p = r; // pin = 1
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // IDENTIFIER | PRIMTYPE | '?' | 'auto'
  public static boolean DATATYPE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "DATATYPE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, DATATYPE, "<datatype>");
    r = IDENTIFIER(b, l + 1);
    if (!r) r = PRIMTYPE(b, l + 1);
    if (!r) r = consumeToken(b, T_QUEST);
    if (!r) r = consumeToken(b, T_AUTO);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // 'do' STATEMENT 'while' '(' ASSIGN ')' ';'
  public static boolean DOWHILE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "DOWHILE")) return false;
    if (!nextTokenIs(b, T_DO)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, DOWHILE, null);
    r = consumeToken(b, T_DO);
    p = r; // pin = 1
    r = r && report_error_(b, STATEMENT(b, l + 1));
    r = p && report_error_(b, consumeTokens(b, -1, T_WHILE, T_LPAREN)) && r;
    r = p && report_error_(b, ASSIGN(b, l + 1)) && r;
    r = p && report_error_(b, consumeTokens(b, -1, T_RPAREN, T_SEMICOLON)) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // ('shared' | 'external')* 'enum' IDENTIFIER (';' | ('{' (IDENTIFIER ('=' EXPR)? (',' IDENTIFIER ('=' EXPR)?)* ',' ?)? '}'))
  public static boolean ENUM(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM")) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, ENUM, "<enum>");
    r = ENUM_0(b, l + 1);
    r = r && consumeToken(b, T_ENUM);
    p = r; // pin = 2
    r = r && report_error_(b, IDENTIFIER(b, l + 1));
    r = p && ENUM_3(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ('shared' | 'external')*
  private static boolean ENUM_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!ENUM_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "ENUM_0", c)) break;
    }
    return true;
  }

  // 'shared' | 'external'
  private static boolean ENUM_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_SHARED);
    if (!r) r = consumeToken(b, T_EXTERNAL);
    return r;
  }

  // ';' | ('{' (IDENTIFIER ('=' EXPR)? (',' IDENTIFIER ('=' EXPR)?)* ',' ?)? '}')
  private static boolean ENUM_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = ENUM_3_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '{' (IDENTIFIER ('=' EXPR)? (',' IDENTIFIER ('=' EXPR)?)* ',' ?)? '}'
  private static boolean ENUM_3_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LBRACE);
    r = r && ENUM_3_1_1(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ('=' EXPR)? (',' IDENTIFIER ('=' EXPR)?)* ',' ?)?
  private static boolean ENUM_3_1_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1")) return false;
    ENUM_3_1_1_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ('=' EXPR)? (',' IDENTIFIER ('=' EXPR)?)* ',' ?
  private static boolean ENUM_3_1_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && ENUM_3_1_1_0_1(b, l + 1);
    r = r && ENUM_3_1_1_0_2(b, l + 1);
    r = r && ENUM_3_1_1_0_3(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ('=' EXPR)?
  private static boolean ENUM_3_1_1_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_1")) return false;
    ENUM_3_1_1_0_1_0(b, l + 1);
    return true;
  }

  // '=' EXPR
  private static boolean ENUM_3_1_1_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && EXPR(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' IDENTIFIER ('=' EXPR)?)*
  private static boolean ENUM_3_1_1_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!ENUM_3_1_1_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "ENUM_3_1_1_0_2", c)) break;
    }
    return true;
  }

  // ',' IDENTIFIER ('=' EXPR)?
  private static boolean ENUM_3_1_1_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && IDENTIFIER(b, l + 1);
    r = r && ENUM_3_1_1_0_2_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ('=' EXPR)?
  private static boolean ENUM_3_1_1_0_2_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_2_0_2")) return false;
    ENUM_3_1_1_0_2_0_2_0(b, l + 1);
    return true;
  }

  // '=' EXPR
  private static boolean ENUM_3_1_1_0_2_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_2_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && EXPR(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ',' ?
  private static boolean ENUM_3_1_1_0_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "ENUM_3_1_1_0_3")) return false;
    consumeToken(b, T_COMMA);
    return true;
  }

  /* ********************************************************** */
  // EXPRTERM (EXPROP EXPRTERM)*
  public static boolean EXPR(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPR")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPR, "<expr>");
    r = EXPRTERM(b, l + 1);
    r = r && EXPR_1(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // (EXPROP EXPRTERM)*
  private static boolean EXPR_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPR_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!EXPR_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "EXPR_1", c)) break;
    }
    return true;
  }

  // EXPROP EXPRTERM
  private static boolean EXPR_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPR_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = EXPROP(b, l + 1);
    r = r && EXPRTERM(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // MATHOP | BITOP | COMPOP | LOGICOP
  public static boolean EXPROP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPROP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPROP, "<exprop>");
    r = MATHOP(b, l + 1);
    if (!r) r = BITOP(b, l + 1);
    if (!r) r = COMPOP(b, l + 1);
    if (!r) r = LOGICOP(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // ASSIGN | ('.' (FUNCCALL | IDENTIFIER)) | ('[' (IDENTIFIER ':')? ASSIGN (',' (IDENTIFIER ':' ASSIGN)?)* ']') | ARGLIST | '++' | '--'
  public static boolean EXPRPOSTOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPRPOSTOP, "<exprpostop>");
    r = ASSIGN(b, l + 1);
    if (!r) r = EXPRPOSTOP_1(b, l + 1);
    if (!r) r = EXPRPOSTOP_2(b, l + 1);
    if (!r) r = ARGLIST(b, l + 1);
    if (!r) r = consumeToken(b, T_PLUS_PLUS);
    if (!r) r = consumeToken(b, T_MINUS_MINUS);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // '.' (FUNCCALL | IDENTIFIER)
  private static boolean EXPRPOSTOP_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_DOT);
    r = r && EXPRPOSTOP_1_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // FUNCCALL | IDENTIFIER
  private static boolean EXPRPOSTOP_1_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_1_1")) return false;
    boolean r;
    r = FUNCCALL(b, l + 1);
    if (!r) r = IDENTIFIER(b, l + 1);
    return r;
  }

  // '[' (IDENTIFIER ':')? ASSIGN (',' (IDENTIFIER ':' ASSIGN)?)* ']'
  private static boolean EXPRPOSTOP_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LBRACK);
    r = r && EXPRPOSTOP_2_1(b, l + 1);
    r = r && ASSIGN(b, l + 1);
    r = r && EXPRPOSTOP_2_3(b, l + 1);
    r = r && consumeToken(b, T_RBRACK);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ':')?
  private static boolean EXPRPOSTOP_2_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_1")) return false;
    EXPRPOSTOP_2_1_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ':'
  private static boolean EXPRPOSTOP_2_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' (IDENTIFIER ':' ASSIGN)?)*
  private static boolean EXPRPOSTOP_2_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_3")) return false;
    while (true) {
      int c = current_position_(b);
      if (!EXPRPOSTOP_2_3_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "EXPRPOSTOP_2_3", c)) break;
    }
    return true;
  }

  // ',' (IDENTIFIER ':' ASSIGN)?
  private static boolean EXPRPOSTOP_2_3_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_3_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && EXPRPOSTOP_2_3_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ':' ASSIGN)?
  private static boolean EXPRPOSTOP_2_3_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_3_0_1")) return false;
    EXPRPOSTOP_2_3_0_1_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ':' ASSIGN
  private static boolean EXPRPOSTOP_2_3_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPOSTOP_2_3_0_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_COLON);
    r = r && ASSIGN(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // '-' | '+' | '!' | '++' | '--' | '~' | '@'
  public static boolean EXPRPREOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRPREOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPRPREOP, "<exprpreop>");
    r = consumeToken(b, T_MINUS);
    if (!r) r = consumeToken(b, T_PLUS);
    if (!r) r = consumeToken(b, T_NOT);
    if (!r) r = consumeToken(b, T_PLUS_PLUS);
    if (!r) r = consumeToken(b, T_MINUS_MINUS);
    if (!r) r = consumeToken(b, T_TILDE);
    if (!r) r = consumeToken(b, T_AT);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // ASSIGN? ';'
  public static boolean EXPRSTAT(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRSTAT")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPRSTAT, "<exprstat>");
    r = EXPRSTAT_0(b, l + 1);
    r = r && consumeToken(b, T_SEMICOLON);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ASSIGN?
  private static boolean EXPRSTAT_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRSTAT_0")) return false;
    ASSIGN(b, l + 1);
    return true;
  }

  /* ********************************************************** */
  // ((TYPE '=')? INITLIST) | ((EXPRPREOP)* EXPRVALUE (EXPRPOSTOP)*)
  public static boolean EXPRTERM(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPRTERM, "<exprterm>");
    r = EXPRTERM_0(b, l + 1);
    if (!r) r = EXPRTERM_1(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // (TYPE '=')? INITLIST
  private static boolean EXPRTERM_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = EXPRTERM_0_0(b, l + 1);
    r = r && INITLIST(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (TYPE '=')?
  private static boolean EXPRTERM_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_0_0")) return false;
    EXPRTERM_0_0_0(b, l + 1);
    return true;
  }

  // TYPE '='
  private static boolean EXPRTERM_0_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_0_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = TYPE(b, l + 1);
    r = r && consumeToken(b, T_ASSIGN);
    exit_section_(b, m, null, r);
    return r;
  }

  // (EXPRPREOP)* EXPRVALUE (EXPRPOSTOP)*
  private static boolean EXPRTERM_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = EXPRTERM_1_0(b, l + 1);
    r = r && EXPRVALUE(b, l + 1);
    r = r && EXPRTERM_1_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (EXPRPREOP)*
  private static boolean EXPRTERM_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_1_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!EXPRTERM_1_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "EXPRTERM_1_0", c)) break;
    }
    return true;
  }

  // (EXPRPREOP)
  private static boolean EXPRTERM_1_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_1_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = EXPRPREOP(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (EXPRPOSTOP)*
  private static boolean EXPRTERM_1_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_1_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!EXPRTERM_1_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "EXPRTERM_1_2", c)) break;
    }
    return true;
  }

  // (EXPRPOSTOP)
  private static boolean EXPRTERM_1_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRTERM_1_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = EXPRPOSTOP(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // LAMBDA | 'void' | CONSTRUCTCALL | FUNCCALL | VARACCESS | CAST | LITERAL | '(' ASSIGN ')'
  public static boolean EXPRVALUE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRVALUE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, EXPRVALUE, "<exprvalue>");
    r = LAMBDA(b, l + 1);
    if (!r) r = consumeToken(b, T_VOID);
    if (!r) r = CONSTRUCTCALL(b, l + 1);
    if (!r) r = FUNCCALL(b, l + 1);
    if (!r) r = VARACCESS(b, l + 1);
    if (!r) r = CAST(b, l + 1);
    if (!r) r = LITERAL(b, l + 1);
    if (!r) r = EXPRVALUE_7(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // '(' ASSIGN ')'
  private static boolean EXPRVALUE_7(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "EXPRVALUE_7")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LPAREN);
    r = r && ASSIGN(b, l + 1);
    r = r && consumeToken(b, T_RPAREN);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // 'for' '(' (VAR | EXPRSTAT) EXPRSTAT (ASSIGN (',' ASSIGN)*)? ')' STATEMENT
  public static boolean FOR(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR")) return false;
    if (!nextTokenIs(b, T_FOR)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, FOR, null);
    r = consumeTokens(b, 1, T_FOR, T_LPAREN);
    p = r; // pin = 1
    r = r && report_error_(b, FOR_2(b, l + 1));
    r = p && report_error_(b, EXPRSTAT(b, l + 1)) && r;
    r = p && report_error_(b, FOR_4(b, l + 1)) && r;
    r = p && report_error_(b, consumeToken(b, T_RPAREN)) && r;
    r = p && STATEMENT(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // VAR | EXPRSTAT
  private static boolean FOR_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR_2")) return false;
    boolean r;
    r = VAR(b, l + 1);
    if (!r) r = EXPRSTAT(b, l + 1);
    return r;
  }

  // (ASSIGN (',' ASSIGN)*)?
  private static boolean FOR_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR_4")) return false;
    FOR_4_0(b, l + 1);
    return true;
  }

  // ASSIGN (',' ASSIGN)*
  private static boolean FOR_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR_4_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = ASSIGN(b, l + 1);
    r = r && FOR_4_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' ASSIGN)*
  private static boolean FOR_4_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR_4_0_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!FOR_4_0_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "FOR_4_0_1", c)) break;
    }
    return true;
  }

  // ',' ASSIGN
  private static boolean FOR_4_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FOR_4_0_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && ASSIGN(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // ('shared' | 'external')* ('private' | 'protected')? ((TYPE '&'?) | '~')? IDENTIFIER PARAMLIST 'const'? FUNCATTR (';' | STATBLOCK)
  public static boolean FUNC(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, FUNC, "<func>");
    r = FUNC_0(b, l + 1);
    r = r && FUNC_1(b, l + 1);
    r = r && FUNC_2(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && PARAMLIST(b, l + 1);
    r = r && FUNC_5(b, l + 1);
    r = r && FUNCATTR(b, l + 1);
    r = r && FUNC_7(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('shared' | 'external')*
  private static boolean FUNC_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!FUNC_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "FUNC_0", c)) break;
    }
    return true;
  }

  // 'shared' | 'external'
  private static boolean FUNC_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_SHARED);
    if (!r) r = consumeToken(b, T_EXTERNAL);
    return r;
  }

  // ('private' | 'protected')?
  private static boolean FUNC_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_1")) return false;
    FUNC_1_0(b, l + 1);
    return true;
  }

  // 'private' | 'protected'
  private static boolean FUNC_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_1_0")) return false;
    boolean r;
    r = consumeToken(b, T_PRIVATE);
    if (!r) r = consumeToken(b, T_PROTECTED);
    return r;
  }

  // ((TYPE '&'?) | '~')?
  private static boolean FUNC_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_2")) return false;
    FUNC_2_0(b, l + 1);
    return true;
  }

  // (TYPE '&'?) | '~'
  private static boolean FUNC_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = FUNC_2_0_0(b, l + 1);
    if (!r) r = consumeToken(b, T_TILDE);
    exit_section_(b, m, null, r);
    return r;
  }

  // TYPE '&'?
  private static boolean FUNC_2_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_2_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = TYPE(b, l + 1);
    r = r && FUNC_2_0_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '&'?
  private static boolean FUNC_2_0_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_2_0_0_1")) return false;
    consumeToken(b, T_BIT_AND);
    return true;
  }

  // 'const'?
  private static boolean FUNC_5(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_5")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  // ';' | STATBLOCK
  private static boolean FUNC_7(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNC_7")) return false;
    boolean r;
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = STATBLOCK(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // ('override' | 'final' | 'explicit' | 'property')*
  public static boolean FUNCATTR(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCATTR")) return false;
    Marker m = enter_section_(b, l, _NONE_, FUNCATTR, "<funcattr>");
    while (true) {
      int c = current_position_(b);
      if (!FUNCATTR_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "FUNCATTR", c)) break;
    }
    exit_section_(b, l, m, true, false, null);
    return true;
  }

  // 'override' | 'final' | 'explicit' | 'property'
  private static boolean FUNCATTR_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCATTR_0")) return false;
    boolean r;
    r = consumeToken(b, T_OVERRIDE);
    if (!r) r = consumeToken(b, T_FINAL);
    if (!r) r = consumeToken(b, T_EXPLICIT);
    if (!r) r = consumeToken(b, T_PROPERTY);
    return r;
  }

  /* ********************************************************** */
  // ('shared' | 'external')* ('private' | 'protected')? IDENTIFIER PARAMLIST 'const'? FUNCATTR (';' | STATBLOCK)
  public static boolean FUNCC(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, FUNCC, "<funcc>");
    r = FUNCC_0(b, l + 1);
    r = r && FUNCC_1(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && PARAMLIST(b, l + 1);
    r = r && FUNCC_4(b, l + 1);
    r = r && FUNCATTR(b, l + 1);
    r = r && FUNCC_6(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('shared' | 'external')*
  private static boolean FUNCC_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!FUNCC_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "FUNCC_0", c)) break;
    }
    return true;
  }

  // 'shared' | 'external'
  private static boolean FUNCC_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_SHARED);
    if (!r) r = consumeToken(b, T_EXTERNAL);
    return r;
  }

  // ('private' | 'protected')?
  private static boolean FUNCC_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_1")) return false;
    FUNCC_1_0(b, l + 1);
    return true;
  }

  // 'private' | 'protected'
  private static boolean FUNCC_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_1_0")) return false;
    boolean r;
    r = consumeToken(b, T_PRIVATE);
    if (!r) r = consumeToken(b, T_PROTECTED);
    return r;
  }

  // 'const'?
  private static boolean FUNCC_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_4")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  // ';' | STATBLOCK
  private static boolean FUNCC_6(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCC_6")) return false;
    boolean r;
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = STATBLOCK(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // SCOPE IDENTIFIER ARGLIST
  public static boolean FUNCCALL(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCCALL")) return false;
    if (!nextTokenIs(b, "<funccall>", T_COLONCOLON, T_IDENT)) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, FUNCCALL, "<funccall>");
    r = SCOPE(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && ARGLIST(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // ('external' | 'shared')* 'funcdef' TYPE '&'? IDENTIFIER PARAMLIST ';'
  public static boolean FUNCDEF(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCDEF")) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, FUNCDEF, "<funcdef>");
    r = FUNCDEF_0(b, l + 1);
    r = r && consumeToken(b, T_FUNCDEF);
    p = r; // pin = 2
    r = r && report_error_(b, TYPE(b, l + 1));
    r = p && report_error_(b, FUNCDEF_3(b, l + 1)) && r;
    r = p && report_error_(b, IDENTIFIER(b, l + 1)) && r;
    r = p && report_error_(b, PARAMLIST(b, l + 1)) && r;
    r = p && consumeToken(b, T_SEMICOLON) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ('external' | 'shared')*
  private static boolean FUNCDEF_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCDEF_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!FUNCDEF_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "FUNCDEF_0", c)) break;
    }
    return true;
  }

  // 'external' | 'shared'
  private static boolean FUNCDEF_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCDEF_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_EXTERNAL);
    if (!r) r = consumeToken(b, T_SHARED);
    return r;
  }

  // '&'?
  private static boolean FUNCDEF_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "FUNCDEF_3")) return false;
    consumeToken(b, T_BIT_AND);
    return true;
  }

  /* ********************************************************** */
  // t_ident
  public static boolean IDENTIFIER(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IDENTIFIER")) return false;
    if (!nextTokenIs(b, T_IDENT)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_IDENT);
    exit_section_(b, m, IDENTIFIER, r);
    return r;
  }

  /* ********************************************************** */
  // 'if' '(' ASSIGN ')' STATEMENT ('else' STATEMENT)?
  public static boolean IF(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IF")) return false;
    if (!nextTokenIs(b, T_IF)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, IF, null);
    r = consumeTokens(b, 1, T_IF, T_LPAREN);
    p = r; // pin = 1
    r = r && report_error_(b, ASSIGN(b, l + 1));
    r = p && report_error_(b, consumeToken(b, T_RPAREN)) && r;
    r = p && report_error_(b, STATEMENT(b, l + 1)) && r;
    r = p && IF_5(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ('else' STATEMENT)?
  private static boolean IF_5(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IF_5")) return false;
    IF_5_0(b, l + 1);
    return true;
  }

  // 'else' STATEMENT
  private static boolean IF_5_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IF_5_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ELSE);
    r = r && STATEMENT(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // 'import' TYPE '&'? IDENTIFIER PARAMLIST FUNCATTR 'from' STRING ';'
  public static boolean IMPORT(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IMPORT")) return false;
    if (!nextTokenIs(b, T_IMPORT)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, IMPORT, null);
    r = consumeToken(b, T_IMPORT);
    p = r; // pin = 1
    r = r && report_error_(b, TYPE(b, l + 1));
    r = p && report_error_(b, IMPORT_2(b, l + 1)) && r;
    r = p && report_error_(b, IDENTIFIER(b, l + 1)) && r;
    r = p && report_error_(b, PARAMLIST(b, l + 1)) && r;
    r = p && report_error_(b, FUNCATTR(b, l + 1)) && r;
    r = p && report_error_(b, consumeToken(b, T_FROM)) && r;
    r = p && report_error_(b, STRING(b, l + 1)) && r;
    r = p && consumeToken(b, T_SEMICOLON) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // '&'?
  private static boolean IMPORT_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "IMPORT_2")) return false;
    consumeToken(b, T_BIT_AND);
    return true;
  }

  /* ********************************************************** */
  // '{' (ASSIGN | INITLIST)? (',' (ASSIGN | INITLIST)?)* '}'
  public static boolean INITLIST(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST")) return false;
    if (!nextTokenIs(b, T_LBRACE)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LBRACE);
    r = r && INITLIST_1(b, l + 1);
    r = r && INITLIST_2(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, m, INITLIST, r);
    return r;
  }

  // (ASSIGN | INITLIST)?
  private static boolean INITLIST_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_1")) return false;
    INITLIST_1_0(b, l + 1);
    return true;
  }

  // ASSIGN | INITLIST
  private static boolean INITLIST_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_1_0")) return false;
    boolean r;
    r = ASSIGN(b, l + 1);
    if (!r) r = INITLIST(b, l + 1);
    return r;
  }

  // (',' (ASSIGN | INITLIST)?)*
  private static boolean INITLIST_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!INITLIST_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "INITLIST_2", c)) break;
    }
    return true;
  }

  // ',' (ASSIGN | INITLIST)?
  private static boolean INITLIST_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && INITLIST_2_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (ASSIGN | INITLIST)?
  private static boolean INITLIST_2_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_2_0_1")) return false;
    INITLIST_2_0_1_0(b, l + 1);
    return true;
  }

  // ASSIGN | INITLIST
  private static boolean INITLIST_2_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INITLIST_2_0_1_0")) return false;
    boolean r;
    r = ASSIGN(b, l + 1);
    if (!r) r = INITLIST(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // ('external' | 'shared')* ('interface') IDENTIFIER (';' | ((':' IDENTIFIER (',' IDENTIFIER)*)? '{' (VIRTPROP | INTFMTHD)* '}'))
  public static boolean INTERFACE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, INTERFACE, "<interface>");
    r = INTERFACE_0(b, l + 1);
    r = r && consumeToken(b, T_INTERFACE);
    r = r && IDENTIFIER(b, l + 1);
    r = r && INTERFACE_3(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('external' | 'shared')*
  private static boolean INTERFACE_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!INTERFACE_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "INTERFACE_0", c)) break;
    }
    return true;
  }

  // 'external' | 'shared'
  private static boolean INTERFACE_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_EXTERNAL);
    if (!r) r = consumeToken(b, T_SHARED);
    return r;
  }

  // ';' | ((':' IDENTIFIER (',' IDENTIFIER)*)? '{' (VIRTPROP | INTFMTHD)* '}')
  private static boolean INTERFACE_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = INTERFACE_3_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (':' IDENTIFIER (',' IDENTIFIER)*)? '{' (VIRTPROP | INTFMTHD)* '}'
  private static boolean INTERFACE_3_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = INTERFACE_3_1_0(b, l + 1);
    r = r && consumeToken(b, T_LBRACE);
    r = r && INTERFACE_3_1_2(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, m, null, r);
    return r;
  }

  // (':' IDENTIFIER (',' IDENTIFIER)*)?
  private static boolean INTERFACE_3_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_0")) return false;
    INTERFACE_3_1_0_0(b, l + 1);
    return true;
  }

  // ':' IDENTIFIER (',' IDENTIFIER)*
  private static boolean INTERFACE_3_1_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COLON);
    r = r && IDENTIFIER(b, l + 1);
    r = r && INTERFACE_3_1_0_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' IDENTIFIER)*
  private static boolean INTERFACE_3_1_0_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_0_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!INTERFACE_3_1_0_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "INTERFACE_3_1_0_0_2", c)) break;
    }
    return true;
  }

  // ',' IDENTIFIER
  private static boolean INTERFACE_3_1_0_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_0_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && IDENTIFIER(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (VIRTPROP | INTFMTHD)*
  private static boolean INTERFACE_3_1_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!INTERFACE_3_1_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "INTERFACE_3_1_2", c)) break;
    }
    return true;
  }

  // VIRTPROP | INTFMTHD
  private static boolean INTERFACE_3_1_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTERFACE_3_1_2_0")) return false;
    boolean r;
    r = VIRTPROP(b, l + 1);
    if (!r) r = INTFMTHD(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // TYPE '&'? IDENTIFIER PARAMLIST 'const'? ';'
  public static boolean INTFMTHD(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTFMTHD")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, INTFMTHD, "<intfmthd>");
    r = TYPE(b, l + 1);
    r = r && INTFMTHD_1(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && PARAMLIST(b, l + 1);
    r = r && INTFMTHD_4(b, l + 1);
    r = r && consumeToken(b, T_SEMICOLON);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // '&'?
  private static boolean INTFMTHD_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTFMTHD_1")) return false;
    consumeToken(b, T_BIT_AND);
    return true;
  }

  // 'const'?
  private static boolean INTFMTHD_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "INTFMTHD_4")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  /* ********************************************************** */
  // 'function' ARGLIST STATBLOCK
  public static boolean LAMBDA(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "LAMBDA")) return false;
    if (!nextTokenIs(b, T_FUNCTION)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, LAMBDA, null);
    r = consumeToken(b, T_FUNCTION);
    p = r; // pin = 1
    r = r && report_error_(b, ARGLIST(b, l + 1));
    r = p && STATBLOCK(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // NUMBER | STRING | BITS | t_true | t_false | t_null
  public static boolean LITERAL(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "LITERAL")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, LITERAL, "<literal>");
    r = NUMBER(b, l + 1);
    if (!r) r = STRING(b, l + 1);
    if (!r) r = BITS(b, l + 1);
    if (!r) r = consumeToken(b, T_TRUE);
    if (!r) r = consumeToken(b, T_FALSE);
    if (!r) r = consumeToken(b, T_NULL);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // '&&' | '||' | '^^' | 'and' | 'or' | 'xor'
  public static boolean LOGICOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "LOGICOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, LOGICOP, "<logicop>");
    r = consumeToken(b, T_COND_AND);
    if (!r) r = consumeToken(b, T_COND_OR);
    if (!r) r = consumeToken(b, T_LOGIC_XOR);
    if (!r) r = consumeToken(b, T_AND_TEXT);
    if (!r) r = consumeToken(b, T_OR_TEXT);
    if (!r) r = consumeToken(b, T_XOR_TEST);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // '+' | '-' | '*' | '/' | '' | '**' | '%'
  public static boolean MATHOP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "MATHOP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, MATHOP, "<mathop>");
    r = consumeToken(b, T_PLUS);
    if (!r) r = consumeToken(b, T_MINUS);
    if (!r) r = consumeToken(b, T_MUL);
    if (!r) r = consumeToken(b, T_QUOTIENT);
    if (!r) r = consumeToken(b, "");
    if (!r) r = consumeToken(b, T_EXPONENT);
    if (!r) r = consumeToken(b, T_REMAINDER);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // 'mixin' CLAZZ
  public static boolean MIXIN(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "MIXIN")) return false;
    if (!nextTokenIs(b, T_MIXIN)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, MIXIN, null);
    r = consumeToken(b, T_MIXIN);
    p = r; // pin = 1
    r = r && CLAZZ(b, l + 1);
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // 'namespace' IDENTIFIER ('::' IDENTIFIER)* '{' (SETTING | IMPORT | ENUM | TYPEDEF | CLAZZ | MIXIN | INTERFACE | FUNCDEF | VIRTPROP | VAR | FUNC | FUNCC | ';' | STATEMENT | NAMESPA | STRUCT )* '}'
  public static boolean NAMESPA(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NAMESPA")) return false;
    if (!nextTokenIs(b, T_NAMESPACE)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, NAMESPA, null);
    r = consumeToken(b, T_NAMESPACE);
    p = r; // pin = 1
    r = r && report_error_(b, IDENTIFIER(b, l + 1));
    r = p && report_error_(b, NAMESPA_2(b, l + 1)) && r;
    r = p && report_error_(b, consumeToken(b, T_LBRACE)) && r;
    r = p && report_error_(b, NAMESPA_4(b, l + 1)) && r;
    r = p && consumeToken(b, T_RBRACE) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ('::' IDENTIFIER)*
  private static boolean NAMESPA_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NAMESPA_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!NAMESPA_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "NAMESPA_2", c)) break;
    }
    return true;
  }

  // '::' IDENTIFIER
  private static boolean NAMESPA_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NAMESPA_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COLONCOLON);
    r = r && IDENTIFIER(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (SETTING | IMPORT | ENUM | TYPEDEF | CLAZZ | MIXIN | INTERFACE | FUNCDEF | VIRTPROP | VAR | FUNC | FUNCC | ';' | STATEMENT | NAMESPA | STRUCT )*
  private static boolean NAMESPA_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NAMESPA_4")) return false;
    while (true) {
      int c = current_position_(b);
      if (!NAMESPA_4_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "NAMESPA_4", c)) break;
    }
    return true;
  }

  // SETTING | IMPORT | ENUM | TYPEDEF | CLAZZ | MIXIN | INTERFACE | FUNCDEF | VIRTPROP | VAR | FUNC | FUNCC | ';' | STATEMENT | NAMESPA | STRUCT
  private static boolean NAMESPA_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NAMESPA_4_0")) return false;
    boolean r;
    r = SETTING(b, l + 1);
    if (!r) r = IMPORT(b, l + 1);
    if (!r) r = ENUM(b, l + 1);
    if (!r) r = TYPEDEF(b, l + 1);
    if (!r) r = CLAZZ(b, l + 1);
    if (!r) r = MIXIN(b, l + 1);
    if (!r) r = INTERFACE(b, l + 1);
    if (!r) r = FUNCDEF(b, l + 1);
    if (!r) r = VIRTPROP(b, l + 1);
    if (!r) r = VAR(b, l + 1);
    if (!r) r = FUNC(b, l + 1);
    if (!r) r = FUNCC(b, l + 1);
    if (!r) r = consumeToken(b, T_SEMICOLON);
    if (!r) r = STATEMENT(b, l + 1);
    if (!r) r = NAMESPA(b, l + 1);
    if (!r) r = STRUCT(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // t_numb | t_numb_2
  public static boolean NUMBER(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "NUMBER")) return false;
    if (!nextTokenIs(b, "<number>", T_NUMB, T_NUMB_2)) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, NUMBER, "<number>");
    r = consumeToken(b, T_NUMB);
    if (!r) r = consumeToken(b, T_NUMB_2);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // '(' ('void' | (TYPE TYPEMOD IDENTIFIER? ('=' EXPR)? (',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?)*))? ')'
  public static boolean PARAMLIST(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST")) return false;
    if (!nextTokenIs(b, T_LPAREN)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LPAREN);
    r = r && PARAMLIST_1(b, l + 1);
    r = r && consumeToken(b, T_RPAREN);
    exit_section_(b, m, PARAMLIST, r);
    return r;
  }

  // ('void' | (TYPE TYPEMOD IDENTIFIER? ('=' EXPR)? (',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?)*))?
  private static boolean PARAMLIST_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1")) return false;
    PARAMLIST_1_0(b, l + 1);
    return true;
  }

  // 'void' | (TYPE TYPEMOD IDENTIFIER? ('=' EXPR)? (',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?)*)
  private static boolean PARAMLIST_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_VOID);
    if (!r) r = PARAMLIST_1_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // TYPE TYPEMOD IDENTIFIER? ('=' EXPR)? (',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?)*
  private static boolean PARAMLIST_1_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = TYPE(b, l + 1);
    r = r && TYPEMOD(b, l + 1);
    r = r && PARAMLIST_1_0_1_2(b, l + 1);
    r = r && PARAMLIST_1_0_1_3(b, l + 1);
    r = r && PARAMLIST_1_0_1_4(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // IDENTIFIER?
  private static boolean PARAMLIST_1_0_1_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_2")) return false;
    IDENTIFIER(b, l + 1);
    return true;
  }

  // ('=' EXPR)?
  private static boolean PARAMLIST_1_0_1_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_3")) return false;
    PARAMLIST_1_0_1_3_0(b, l + 1);
    return true;
  }

  // '=' EXPR
  private static boolean PARAMLIST_1_0_1_3_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_3_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && EXPR(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?)*
  private static boolean PARAMLIST_1_0_1_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_4")) return false;
    while (true) {
      int c = current_position_(b);
      if (!PARAMLIST_1_0_1_4_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "PARAMLIST_1_0_1_4", c)) break;
    }
    return true;
  }

  // ',' TYPE TYPEMOD IDENTIFIER? ('=' EXPR)?
  private static boolean PARAMLIST_1_0_1_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_4_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && TYPE(b, l + 1);
    r = r && TYPEMOD(b, l + 1);
    r = r && PARAMLIST_1_0_1_4_0_3(b, l + 1);
    r = r && PARAMLIST_1_0_1_4_0_4(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // IDENTIFIER?
  private static boolean PARAMLIST_1_0_1_4_0_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_4_0_3")) return false;
    IDENTIFIER(b, l + 1);
    return true;
  }

  // ('=' EXPR)?
  private static boolean PARAMLIST_1_0_1_4_0_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_4_0_4")) return false;
    PARAMLIST_1_0_1_4_0_4_0(b, l + 1);
    return true;
  }

  // '=' EXPR
  private static boolean PARAMLIST_1_0_1_4_0_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PARAMLIST_1_0_1_4_0_4_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && EXPR(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // 'void' | 'int' | 'int8' | 'int16' | 'int32' | 'int64' | 'uint' | 'uint8' | 'uint16' | 'uint32' | 'uint64' | t_float | 'double' | 'bool'
  public static boolean PRIMTYPE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "PRIMTYPE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, PRIMTYPE, "<primtype>");
    r = consumeToken(b, T_VOID);
    if (!r) r = consumeToken(b, T_INT);
    if (!r) r = consumeToken(b, T_INT8);
    if (!r) r = consumeToken(b, T_INT16);
    if (!r) r = consumeToken(b, T_INT32);
    if (!r) r = consumeToken(b, T_INT64);
    if (!r) r = consumeToken(b, T_UINT);
    if (!r) r = consumeToken(b, T_UINT8);
    if (!r) r = consumeToken(b, T_UINT16);
    if (!r) r = consumeToken(b, T_UINT32);
    if (!r) r = consumeToken(b, T_UINT64);
    if (!r) r = consumeToken(b, T_FLOAT);
    if (!r) r = consumeToken(b, T_DOUBLE);
    if (!r) r = consumeToken(b, T_BOOL);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // 'return' ASSIGN? ';'
  public static boolean RETURN(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "RETURN")) return false;
    if (!nextTokenIs(b, T_RETURN)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, RETURN, null);
    r = consumeToken(b, T_RETURN);
    p = r; // pin = 1
    r = r && report_error_(b, RETURN_1(b, l + 1));
    r = p && consumeToken(b, T_SEMICOLON) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // ASSIGN?
  private static boolean RETURN_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "RETURN_1")) return false;
    ASSIGN(b, l + 1);
    return true;
  }

  /* ********************************************************** */
  // '::'? (IDENTIFIER '::')* (IDENTIFIER ('<' TYPE (',' TYPE)* '>')? '::')?
  public static boolean SCOPE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, SCOPE, "<scope>");
    r = SCOPE_0(b, l + 1);
    r = r && SCOPE_1(b, l + 1);
    r = r && SCOPE_2(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // '::'?
  private static boolean SCOPE_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_0")) return false;
    consumeToken(b, T_COLONCOLON);
    return true;
  }

  // (IDENTIFIER '::')*
  private static boolean SCOPE_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!SCOPE_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SCOPE_1", c)) break;
    }
    return true;
  }

  // IDENTIFIER '::'
  private static boolean SCOPE_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_COLONCOLON);
    exit_section_(b, m, null, r);
    return r;
  }

  // (IDENTIFIER ('<' TYPE (',' TYPE)* '>')? '::')?
  private static boolean SCOPE_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2")) return false;
    SCOPE_2_0(b, l + 1);
    return true;
  }

  // IDENTIFIER ('<' TYPE (',' TYPE)* '>')? '::'
  private static boolean SCOPE_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = IDENTIFIER(b, l + 1);
    r = r && SCOPE_2_0_1(b, l + 1);
    r = r && consumeToken(b, T_COLONCOLON);
    exit_section_(b, m, null, r);
    return r;
  }

  // ('<' TYPE (',' TYPE)* '>')?
  private static boolean SCOPE_2_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2_0_1")) return false;
    SCOPE_2_0_1_0(b, l + 1);
    return true;
  }

  // '<' TYPE (',' TYPE)* '>'
  private static boolean SCOPE_2_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2_0_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LESS);
    r = r && TYPE(b, l + 1);
    r = r && SCOPE_2_0_1_0_2(b, l + 1);
    r = r && consumeToken(b, T_GREATER);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' TYPE)*
  private static boolean SCOPE_2_0_1_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2_0_1_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!SCOPE_2_0_1_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SCOPE_2_0_1_0_2", c)) break;
    }
    return true;
  }

  // ',' TYPE
  private static boolean SCOPE_2_0_1_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCOPE_2_0_1_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && TYPE(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // (SETTING | IMPORT | ENUM | TYPEDEF | CLAZZ | MIXIN | INTERFACE | FUNCDEF | VIRTPROP | VAR | STATEMENT | FUNC | FUNCC | NAMESPA | ';' | STRUCT)*
  static boolean SCRIPT(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCRIPT")) return false;
    Marker m = enter_section_(b, l, _NONE_);
    while (true) {
      int c = current_position_(b);
      if (!SCRIPT_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SCRIPT", c)) break;
    }
    exit_section_(b, l, m, true, false, AngelScriptParser::script_recover);
    return true;
  }

  // SETTING | IMPORT | ENUM | TYPEDEF | CLAZZ | MIXIN | INTERFACE | FUNCDEF | VIRTPROP | VAR | STATEMENT | FUNC | FUNCC | NAMESPA | ';' | STRUCT
  private static boolean SCRIPT_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SCRIPT_0")) return false;
    boolean r;
    r = SETTING(b, l + 1);
    if (!r) r = IMPORT(b, l + 1);
    if (!r) r = ENUM(b, l + 1);
    if (!r) r = TYPEDEF(b, l + 1);
    if (!r) r = CLAZZ(b, l + 1);
    if (!r) r = MIXIN(b, l + 1);
    if (!r) r = INTERFACE(b, l + 1);
    if (!r) r = FUNCDEF(b, l + 1);
    if (!r) r = VIRTPROP(b, l + 1);
    if (!r) r = VAR(b, l + 1);
    if (!r) r = STATEMENT(b, l + 1);
    if (!r) r = FUNC(b, l + 1);
    if (!r) r = FUNCC(b, l + 1);
    if (!r) r = NAMESPA(b, l + 1);
    if (!r) r = consumeToken(b, T_SEMICOLON);
    if (!r) r = STRUCT(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // '[' EXPR? (TYPE? IDENTIFIER '=' ((INITLIST | EXPR)) | ARGLIST)? (','? IDENTIFIER (( '=' (INITLIST | EXPR)) | ARGLIST)?)* SETTING* ']'
  public static boolean SETTING(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING")) return false;
    if (!nextTokenIs(b, T_LBRACK)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LBRACK);
    r = r && SETTING_1(b, l + 1);
    r = r && SETTING_2(b, l + 1);
    r = r && SETTING_3(b, l + 1);
    r = r && SETTING_4(b, l + 1);
    r = r && consumeToken(b, T_RBRACK);
    exit_section_(b, m, SETTING, r);
    return r;
  }

  // EXPR?
  private static boolean SETTING_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_1")) return false;
    EXPR(b, l + 1);
    return true;
  }

  // (TYPE? IDENTIFIER '=' ((INITLIST | EXPR)) | ARGLIST)?
  private static boolean SETTING_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_2")) return false;
    SETTING_2_0(b, l + 1);
    return true;
  }

  // TYPE? IDENTIFIER '=' ((INITLIST | EXPR)) | ARGLIST
  private static boolean SETTING_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = SETTING_2_0_0(b, l + 1);
    if (!r) r = ARGLIST(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // TYPE? IDENTIFIER '=' ((INITLIST | EXPR))
  private static boolean SETTING_2_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_2_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = SETTING_2_0_0_0(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_ASSIGN);
    r = r && SETTING_2_0_0_3(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // TYPE?
  private static boolean SETTING_2_0_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_2_0_0_0")) return false;
    TYPE(b, l + 1);
    return true;
  }

  // INITLIST | EXPR
  private static boolean SETTING_2_0_0_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_2_0_0_3")) return false;
    boolean r;
    r = INITLIST(b, l + 1);
    if (!r) r = EXPR(b, l + 1);
    return r;
  }

  // (','? IDENTIFIER (( '=' (INITLIST | EXPR)) | ARGLIST)?)*
  private static boolean SETTING_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3")) return false;
    while (true) {
      int c = current_position_(b);
      if (!SETTING_3_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SETTING_3", c)) break;
    }
    return true;
  }

  // ','? IDENTIFIER (( '=' (INITLIST | EXPR)) | ARGLIST)?
  private static boolean SETTING_3_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = SETTING_3_0_0(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && SETTING_3_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ','?
  private static boolean SETTING_3_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0_0")) return false;
    consumeToken(b, T_COMMA);
    return true;
  }

  // (( '=' (INITLIST | EXPR)) | ARGLIST)?
  private static boolean SETTING_3_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0_2")) return false;
    SETTING_3_0_2_0(b, l + 1);
    return true;
  }

  // ( '=' (INITLIST | EXPR)) | ARGLIST
  private static boolean SETTING_3_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = SETTING_3_0_2_0_0(b, l + 1);
    if (!r) r = ARGLIST(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '=' (INITLIST | EXPR)
  private static boolean SETTING_3_0_2_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0_2_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && SETTING_3_0_2_0_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // INITLIST | EXPR
  private static boolean SETTING_3_0_2_0_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_3_0_2_0_0_1")) return false;
    boolean r;
    r = INITLIST(b, l + 1);
    if (!r) r = EXPR(b, l + 1);
    return r;
  }

  // SETTING*
  private static boolean SETTING_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SETTING_4")) return false;
    while (true) {
      int c = current_position_(b);
      if (!SETTING(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SETTING_4", c)) break;
    }
    return true;
  }

  /* ********************************************************** */
  // '{' (VAR | STATEMENT )* '}'
  public static boolean STATBLOCK(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STATBLOCK")) return false;
    if (!nextTokenIs(b, T_LBRACE)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LBRACE);
    r = r && STATBLOCK_1(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, m, STATBLOCK, r);
    return r;
  }

  // (VAR | STATEMENT )*
  private static boolean STATBLOCK_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STATBLOCK_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!STATBLOCK_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "STATBLOCK_1", c)) break;
    }
    return true;
  }

  // VAR | STATEMENT
  private static boolean STATBLOCK_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STATBLOCK_1_0")) return false;
    boolean r;
    r = VAR(b, l + 1);
    if (!r) r = STATEMENT(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // IF | FOR | WHILE | RETURN | STATBLOCK | BREAK | CONTINUE | DOWHILE | SWITCH | EXPRSTAT | TRY
  public static boolean STATEMENT(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STATEMENT")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, STATEMENT, "<statement>");
    r = IF(b, l + 1);
    if (!r) r = FOR(b, l + 1);
    if (!r) r = WHILE(b, l + 1);
    if (!r) r = RETURN(b, l + 1);
    if (!r) r = STATBLOCK(b, l + 1);
    if (!r) r = BREAK(b, l + 1);
    if (!r) r = CONTINUE(b, l + 1);
    if (!r) r = DOWHILE(b, l + 1);
    if (!r) r = SWITCH(b, l + 1);
    if (!r) r = EXPRSTAT(b, l + 1);
    if (!r) r = TRY(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // (t_string_single | t_string_double | t_string_block)+
  public static boolean STRING(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRING")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, STRING, "<string>");
    r = STRING_0(b, l + 1);
    while (r) {
      int c = current_position_(b);
      if (!STRING_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "STRING", c)) break;
    }
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // t_string_single | t_string_double | t_string_block
  private static boolean STRING_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRING_0")) return false;
    boolean r;
    r = consumeToken(b, T_STRING_SINGLE);
    if (!r) r = consumeToken(b, T_STRING_DOUBLE);
    if (!r) r = consumeToken(b, T_STRING_BLOCK);
    return r;
  }

  /* ********************************************************** */
  // ('external' | 'shared')* 'struct' IDENTIFIER (';' | STATBLOCK)
  public static boolean STRUCT(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRUCT")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, STRUCT, "<struct>");
    r = STRUCT_0(b, l + 1);
    r = r && consumeToken(b, T_STRUCT);
    r = r && IDENTIFIER(b, l + 1);
    r = r && STRUCT_3(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('external' | 'shared')*
  private static boolean STRUCT_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRUCT_0")) return false;
    while (true) {
      int c = current_position_(b);
      if (!STRUCT_0_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "STRUCT_0", c)) break;
    }
    return true;
  }

  // 'external' | 'shared'
  private static boolean STRUCT_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRUCT_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_EXTERNAL);
    if (!r) r = consumeToken(b, T_SHARED);
    return r;
  }

  // ';' | STATBLOCK
  private static boolean STRUCT_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "STRUCT_3")) return false;
    boolean r;
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = STATBLOCK(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // 'switch' '(' ASSIGN ')' '{' CASE* '}'
  public static boolean SWITCH(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SWITCH")) return false;
    if (!nextTokenIs(b, T_SWITCH)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, SWITCH, null);
    r = consumeTokens(b, 1, T_SWITCH, T_LPAREN);
    p = r; // pin = 1
    r = r && report_error_(b, ASSIGN(b, l + 1));
    r = p && report_error_(b, consumeTokens(b, -1, T_RPAREN, T_LBRACE)) && r;
    r = p && report_error_(b, SWITCH_5(b, l + 1)) && r;
    r = p && consumeToken(b, T_RBRACE) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  // CASE*
  private static boolean SWITCH_5(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "SWITCH_5")) return false;
    while (true) {
      int c = current_position_(b);
      if (!CASE(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "SWITCH_5", c)) break;
    }
    return true;
  }

  /* ********************************************************** */
  // 'try' STATBLOCK 'catch' STATBLOCK
  public static boolean TRY(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TRY")) return false;
    if (!nextTokenIs(b, T_TRY)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, TRY, null);
    r = consumeToken(b, T_TRY);
    p = r; // pin = 1
    r = r && report_error_(b, STATBLOCK(b, l + 1));
    r = p && report_error_(b, consumeToken(b, T_CATCH)) && r;
    r = p && STATBLOCK(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // 'const'? SCOPE DATATYPE ('<' TYPE (',' TYPE)* '>')? ( ('[' ']') | ('@' 'const'?) )*
  public static boolean TYPE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, TYPE, "<type>");
    r = TYPE_0(b, l + 1);
    r = r && SCOPE(b, l + 1);
    r = r && DATATYPE(b, l + 1);
    r = r && TYPE_3(b, l + 1);
    r = r && TYPE_4(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // 'const'?
  private static boolean TYPE_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_0")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  // ('<' TYPE (',' TYPE)* '>')?
  private static boolean TYPE_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_3")) return false;
    TYPE_3_0(b, l + 1);
    return true;
  }

  // '<' TYPE (',' TYPE)* '>'
  private static boolean TYPE_3_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_3_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_LESS);
    r = r && TYPE(b, l + 1);
    r = r && TYPE_3_0_2(b, l + 1);
    r = r && consumeToken(b, T_GREATER);
    exit_section_(b, m, null, r);
    return r;
  }

  // (',' TYPE)*
  private static boolean TYPE_3_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_3_0_2")) return false;
    while (true) {
      int c = current_position_(b);
      if (!TYPE_3_0_2_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "TYPE_3_0_2", c)) break;
    }
    return true;
  }

  // ',' TYPE
  private static boolean TYPE_3_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_3_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && TYPE(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ( ('[' ']') | ('@' 'const'?) )*
  private static boolean TYPE_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_4")) return false;
    while (true) {
      int c = current_position_(b);
      if (!TYPE_4_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "TYPE_4", c)) break;
    }
    return true;
  }

  // ('[' ']') | ('@' 'const'?)
  private static boolean TYPE_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_4_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = TYPE_4_0_0(b, l + 1);
    if (!r) r = TYPE_4_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '[' ']'
  private static boolean TYPE_4_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_4_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeTokens(b, 0, T_LBRACK, T_RBRACK);
    exit_section_(b, m, null, r);
    return r;
  }

  // '@' 'const'?
  private static boolean TYPE_4_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_4_0_1")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_AT);
    r = r && TYPE_4_0_1_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // 'const'?
  private static boolean TYPE_4_0_1_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPE_4_0_1_1")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  /* ********************************************************** */
  // 'typedef' PRIMTYPE IDENTIFIER ';'
  public static boolean TYPEDEF(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPEDEF")) return false;
    if (!nextTokenIs(b, T_TYPEDEF)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, TYPEDEF, null);
    r = consumeToken(b, T_TYPEDEF);
    p = r; // pin = 1
    r = r && report_error_(b, PRIMTYPE(b, l + 1));
    r = p && report_error_(b, IDENTIFIER(b, l + 1)) && r;
    r = p && consumeToken(b, T_SEMICOLON) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // ('&' ('in' | 'out' | 'inout')?)?
  public static boolean TYPEMOD(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPEMOD")) return false;
    Marker m = enter_section_(b, l, _NONE_, TYPEMOD, "<typemod>");
    TYPEMOD_0(b, l + 1);
    exit_section_(b, l, m, true, false, null);
    return true;
  }

  // '&' ('in' | 'out' | 'inout')?
  private static boolean TYPEMOD_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPEMOD_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_BIT_AND);
    r = r && TYPEMOD_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // ('in' | 'out' | 'inout')?
  private static boolean TYPEMOD_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPEMOD_0_1")) return false;
    TYPEMOD_0_1_0(b, l + 1);
    return true;
  }

  // 'in' | 'out' | 'inout'
  private static boolean TYPEMOD_0_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "TYPEMOD_0_1_0")) return false;
    boolean r;
    r = consumeToken(b, T_IN);
    if (!r) r = consumeToken(b, T_OUT);
    if (!r) r = consumeToken(b, T_INOUT);
    return r;
  }

  /* ********************************************************** */
  // ('private'|'protected')? TYPE IDENTIFIER (( '=' (INITLIST | CONDITION)) | ARGLIST)? (',' IDENTIFIER (( '=' (INITLIST | CONDITION)) | ARGLIST)?)* ';'
  public static boolean VAR(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, VAR, "<var>");
    r = VAR_0(b, l + 1);
    r = r && TYPE(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && VAR_3(b, l + 1);
    r = r && VAR_4(b, l + 1);
    r = r && consumeToken(b, T_SEMICOLON);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('private'|'protected')?
  private static boolean VAR_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_0")) return false;
    VAR_0_0(b, l + 1);
    return true;
  }

  // 'private'|'protected'
  private static boolean VAR_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_PRIVATE);
    if (!r) r = consumeToken(b, T_PROTECTED);
    return r;
  }

  // (( '=' (INITLIST | CONDITION)) | ARGLIST)?
  private static boolean VAR_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_3")) return false;
    VAR_3_0(b, l + 1);
    return true;
  }

  // ( '=' (INITLIST | CONDITION)) | ARGLIST
  private static boolean VAR_3_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_3_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = VAR_3_0_0(b, l + 1);
    if (!r) r = ARGLIST(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '=' (INITLIST | CONDITION)
  private static boolean VAR_3_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_3_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && VAR_3_0_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // INITLIST | CONDITION
  private static boolean VAR_3_0_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_3_0_0_1")) return false;
    boolean r;
    r = INITLIST(b, l + 1);
    if (!r) r = CONDITION(b, l + 1);
    return r;
  }

  // (',' IDENTIFIER (( '=' (INITLIST | CONDITION)) | ARGLIST)?)*
  private static boolean VAR_4(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4")) return false;
    while (true) {
      int c = current_position_(b);
      if (!VAR_4_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "VAR_4", c)) break;
    }
    return true;
  }

  // ',' IDENTIFIER (( '=' (INITLIST | CONDITION)) | ARGLIST)?
  private static boolean VAR_4_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_COMMA);
    r = r && IDENTIFIER(b, l + 1);
    r = r && VAR_4_0_2(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (( '=' (INITLIST | CONDITION)) | ARGLIST)?
  private static boolean VAR_4_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4_0_2")) return false;
    VAR_4_0_2_0(b, l + 1);
    return true;
  }

  // ( '=' (INITLIST | CONDITION)) | ARGLIST
  private static boolean VAR_4_0_2_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4_0_2_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = VAR_4_0_2_0_0(b, l + 1);
    if (!r) r = ARGLIST(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // '=' (INITLIST | CONDITION)
  private static boolean VAR_4_0_2_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4_0_2_0_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, T_ASSIGN);
    r = r && VAR_4_0_2_0_0_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // INITLIST | CONDITION
  private static boolean VAR_4_0_2_0_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VAR_4_0_2_0_0_1")) return false;
    boolean r;
    r = INITLIST(b, l + 1);
    if (!r) r = CONDITION(b, l + 1);
    return r;
  }

  /* ********************************************************** */
  // SCOPE IDENTIFIER
  public static boolean VARACCESS(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VARACCESS")) return false;
    if (!nextTokenIs(b, "<varaccess>", T_COLONCOLON, T_IDENT)) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, VARACCESS, "<varaccess>");
    r = SCOPE(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // ('private' | 'protected')? TYPE '&'? IDENTIFIER '{' (('get' | 'set') 'const'? FUNCATTR? (STATBLOCK | ';'))* '}'
  public static boolean VIRTPROP(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, VIRTPROP, "<virtprop>");
    r = VIRTPROP_0(b, l + 1);
    r = r && TYPE(b, l + 1);
    r = r && VIRTPROP_2(b, l + 1);
    r = r && IDENTIFIER(b, l + 1);
    r = r && consumeToken(b, T_LBRACE);
    r = r && VIRTPROP_5(b, l + 1);
    r = r && consumeToken(b, T_RBRACE);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ('private' | 'protected')?
  private static boolean VIRTPROP_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_0")) return false;
    VIRTPROP_0_0(b, l + 1);
    return true;
  }

  // 'private' | 'protected'
  private static boolean VIRTPROP_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_0_0")) return false;
    boolean r;
    r = consumeToken(b, T_PRIVATE);
    if (!r) r = consumeToken(b, T_PROTECTED);
    return r;
  }

  // '&'?
  private static boolean VIRTPROP_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_2")) return false;
    consumeToken(b, T_BIT_AND);
    return true;
  }

  // (('get' | 'set') 'const'? FUNCATTR? (STATBLOCK | ';'))*
  private static boolean VIRTPROP_5(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5")) return false;
    while (true) {
      int c = current_position_(b);
      if (!VIRTPROP_5_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "VIRTPROP_5", c)) break;
    }
    return true;
  }

  // ('get' | 'set') 'const'? FUNCATTR? (STATBLOCK | ';')
  private static boolean VIRTPROP_5_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = VIRTPROP_5_0_0(b, l + 1);
    r = r && VIRTPROP_5_0_1(b, l + 1);
    r = r && VIRTPROP_5_0_2(b, l + 1);
    r = r && VIRTPROP_5_0_3(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // 'get' | 'set'
  private static boolean VIRTPROP_5_0_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5_0_0")) return false;
    boolean r;
    r = consumeToken(b, "get");
    if (!r) r = consumeToken(b, "set");
    return r;
  }

  // 'const'?
  private static boolean VIRTPROP_5_0_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5_0_1")) return false;
    consumeToken(b, T_CONST);
    return true;
  }

  // FUNCATTR?
  private static boolean VIRTPROP_5_0_2(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5_0_2")) return false;
    FUNCATTR(b, l + 1);
    return true;
  }

  // STATBLOCK | ';'
  private static boolean VIRTPROP_5_0_3(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "VIRTPROP_5_0_3")) return false;
    boolean r;
    r = STATBLOCK(b, l + 1);
    if (!r) r = consumeToken(b, T_SEMICOLON);
    return r;
  }

  /* ********************************************************** */
  // 'while' '(' ASSIGN ')' STATEMENT
  public static boolean WHILE(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "WHILE")) return false;
    if (!nextTokenIs(b, T_WHILE)) return false;
    boolean r, p;
    Marker m = enter_section_(b, l, _NONE_, WHILE, null);
    r = consumeTokens(b, 1, T_WHILE, T_LPAREN);
    p = r; // pin = 1
    r = r && report_error_(b, ASSIGN(b, l + 1));
    r = p && report_error_(b, consumeToken(b, T_RPAREN)) && r;
    r = p && STATEMENT(b, l + 1) && r;
    exit_section_(b, l, m, r, p, null);
    return r || p;
  }

  /* ********************************************************** */
  // !(';')
  static boolean script_recover(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "script_recover")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NOT_);
    r = !consumeToken(b, T_SEMICOLON);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  /* ********************************************************** */
  // !(';' | TYPE)
  static boolean var_recover(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "var_recover")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NOT_);
    r = !var_recover_0(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // ';' | TYPE
  private static boolean var_recover_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "var_recover_0")) return false;
    boolean r;
    r = consumeToken(b, T_SEMICOLON);
    if (!r) r = TYPE(b, l + 1);
    return r;
  }

}
