package org.intellij.sdk.language;

import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;

import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.HighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;

import java.util.List;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTempTextAttributesKey;
import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;
import static org.intellij.sdk.language.psi.AngelScriptElementTypes.*;

public class AngelScriptSyntaxHighlighter extends SyntaxHighlighterBase {


    public static final TextAttributesKey BLOCK_COMMENT =
            createTextAttributesKey("ANGELSCRIPT_BLOCK_COMMENT", DefaultLanguageHighlighterColors.BLOCK_COMMENT);
    public static final TextAttributesKey LINE_COMMENT =
            createTextAttributesKey("ANGELSCRIPT_LINE_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
    public static final TextAttributesKey OPERATION_SIGN =
            createTextAttributesKey("ANGELSCRIPT_OPERATION_SIGN", DefaultLanguageHighlighterColors.OPERATION_SIGN);
    public static final TextAttributesKey BRACES =
            createTextAttributesKey("ANGELSCRIPT_BRACES", DefaultLanguageHighlighterColors.BRACES);
    public static final TextAttributesKey SEMICOLON =
            createTextAttributesKey("ANGELSCRIPT_SEMICOLON", DefaultLanguageHighlighterColors.SEMICOLON);
    public static final TextAttributesKey COMMA =
            createTextAttributesKey("ANGELSCRIPT_COMMA", DefaultLanguageHighlighterColors.COMMA);
    public static final TextAttributesKey PARENTHESES =
            createTextAttributesKey("ANGELSCRIPT_PARENTHESES", DefaultLanguageHighlighterColors.PARENTHESES);
    public static final TextAttributesKey BRACKETS =
            createTextAttributesKey("ANGELSCRIPT_BRACKETS", DefaultLanguageHighlighterColors.BRACKETS);
    public static final TextAttributesKey IDENTIFIER =
            createTextAttributesKey("ANGELSCRIPT_IDENTIFIER", DefaultLanguageHighlighterColors.IDENTIFIER);
    public static final TextAttributesKey STRING =
            createTextAttributesKey("ANGELSCRIPT_STRING", DefaultLanguageHighlighterColors.STRING);
    public static final TextAttributesKey NUMBER =
            createTextAttributesKey("ANGELSCRIPT_NUMBER", DefaultLanguageHighlighterColors.NUMBER);
    public static final TextAttributesKey KEYWORD =
            createTextAttributesKey("ANGELSCRIPT_KEYWORD", DefaultLanguageHighlighterColors.KEYWORD);
    public static final TextAttributesKey DOT =
            createTextAttributesKey("ANGELSCRIPT_DOT", DefaultLanguageHighlighterColors.DOT);
    public static final TextAttributesKey BAD_CHARACTER =
            createTextAttributesKey("ANGELSCRIPT_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);

    private static final TextAttributesKey[] DOT_KEYS = new TextAttributesKey[]{DOT};
    private static final TextAttributesKey[] IDENTIFIER_KEYS = new TextAttributesKey[]{IDENTIFIER};
    private static final TextAttributesKey[] PARENTHESES_KEYS = new TextAttributesKey[]{PARENTHESES};
    private static final TextAttributesKey[] COMMA_KEYS = new TextAttributesKey[]{COMMA};
    private static final TextAttributesKey[] SEMICOLON_KEYS = new TextAttributesKey[]{SEMICOLON};
    private static final TextAttributesKey[] BRACES_KEYS = new TextAttributesKey[]{BRACES};
    private static final TextAttributesKey[] BRACKETS_KEYS = new TextAttributesKey[]{BRACKETS};
    private static final TextAttributesKey[] OPERATION_SIGN_KEYS = new TextAttributesKey[]{OPERATION_SIGN};
    private static final TextAttributesKey[] LINE_COMMENT_KEYS = new TextAttributesKey[]{LINE_COMMENT};
    private static final TextAttributesKey[] BLOCK_COMMENT_KEYS = new TextAttributesKey[]{BLOCK_COMMENT};
    private static final TextAttributesKey[] STRING_KEYS = new TextAttributesKey[]{STRING};
    private static final TextAttributesKey[] NUMBER_KEYS = new TextAttributesKey[]{NUMBER};
    private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[]{BAD_CHARACTER};
    private static final TextAttributesKey[] KEYWORD_KEYS = new TextAttributesKey[]{KEYWORD};
    private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];

    @NotNull
    @Override
    public Lexer getHighlightingLexer() {
        return new AngelScriptLexerAdapter();
    }

    @NotNull
    @Override
    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
        if (List.of(
                T_FUNCTION,
                T_FALSE,
                T_TRUE,
                T_ABSTRACT,
                T_AND_TEXT,
                T_AUTO,
                T_BOOL,
                T_BREAK,
                T_CASE,
                T_CAST,
                T_CLASS,
                T_CONST,
                T_CONTINUE,
                T_DEFAULT,
                T_DO,
                T_DOUBLE,
                T_ELSE,
                T_ENUM,
                T_EXPLICIT,
                T_EXTERNAL,
                T_FALSE,
                T_FINAL,
                T_FLOAT,
                T_FOR,
                T_FROM,
                T_FUNCDEF,
                T_FUNCTION,
                T_IF,
                T_IMPORT,
                T_IN,
                T_INOUT,
                T_INT,
                T_INT8,
                T_INT16,
                T_INT32,
                T_INT64,
                T_INTERFACE,
                T_IS,
                T_MIXIN,
                T_NAMESPACE,
                T_NULL,
                T_OR_TEXT,
                T_OUT,
                T_OVERRIDE,
                T_PRIVATE,
                T_PROPERTY,
                T_PROTECTED,
                T_RETURN,
                T_SHARED,
                T_STRUCT,
                T_SWITCH,
                T_TRUE,
                T_TRY,
                T_TYPEDEF,
                T_UINT,
                T_UINT8,
                T_UINT16,
                T_UINT32,
                T_UINT64,
                T_VOID,
                T_WHILE,
                T_XOR_TEST
        ).contains(tokenType)) {
            return KEYWORD_KEYS;
        } else if (tokenType.equals(T_IDENT)) {
            return IDENTIFIER_KEYS;
        } else if (tokenType.equals(T_RPAREN) || tokenType.equals(T_LPAREN)) {
            return PARENTHESES_KEYS;
        } else if (tokenType.equals(T_COMMA)) {
            return COMMA_KEYS;
        } else if (tokenType.equals(T_SEMICOLON)) {
            return SEMICOLON_KEYS;
        } else if (tokenType.equals(T_LBRACE) || tokenType.equals(T_RBRACE)) {
            return BRACES_KEYS;
        } else if (tokenType.equals(T_LBRACK) || tokenType.equals(T_RBRACK)) {
            return BRACKETS_KEYS;
        } else if (List.of(
                T_ASSIGN,
                T_AT,
                T_BIT_AND,
                T_BIT_AND_ASSIGN,
                T_BIT_CLEAR,
                T_BIT_CLEAR_ASSIGN,
                T_BIT_OR,
                T_BIT_OR_ASSIGN,
                T_BIT_XOR,
                T_BIT_XOR_ASSIGN,
                T_COND_AND,
                T_COND_OR,
                T_EQ,
                T_EXPONENT,
                T_EXP_ASSIGN,
                T_GREATER,
                T_GREATER_OR_EQUAL,
                T_LESS,
                T_LESS_OR_EQUAL,
                T_LOGIC_XOR,
                T_MINUS,
                T_MINUS_ASSIGN,
                T_MINUS_MINUS,
                T_MUL,
                T_MUL_ASSIGN,
                T_NOT,
                T_NOT_EQ,
                T_PLUS,
                T_PLUS_ASSIGN,
                T_PLUS_PLUS,
                T_QUEST,
                T_QUOTIENT,
                T_QUOTIENT_ASSIGN,
                T_REMAINDER,
                T_REMAINDER_ASSIGN,
                T_SEND_CHANNEL,
                T_SHIFT_LEFT_ASSIGN,
                T_SHIFT_RIGHT_ASSIGN,
                T_SHIFT_SHIFT_RIGHT_ASSIN,
                T_TILDE,
                T_TRIPLE_DOT,
                T_VAR_ASSIGN
            ).contains(tokenType)) {
            return OPERATION_SIGN_KEYS;
        } else if (tokenType.equals(T_LINE_COMMENT) || tokenType.equals(T_PRE_COMMENT)) {
            return LINE_COMMENT_KEYS;
        } else if (tokenType.equals(T_ELIF_COMMENT) || tokenType.equals(T_BLOCK_COMMENT)) {
            return BLOCK_COMMENT_KEYS;
        } else if (tokenType.equals(T_STRING_BLOCK) || tokenType.equals(T_STRING_SINGLE) || tokenType.equals(T_STRING_DOUBLE)) {
            return STRING_KEYS;
        } else if (tokenType.equals(T_COLON) || tokenType.equals(T_COLONCOLON) || tokenType.equals(T_DOT)) {
            return DOT_KEYS;
        } else if (tokenType.equals(T_NUMB) || tokenType.equals(T_BITS) || tokenType.equals(T_NUMB_2)) {
            return NUMBER_KEYS;
        } else if (tokenType.equals(TokenType.BAD_CHARACTER)) {
            return BAD_CHAR_KEYS;
        } else {
            return EMPTY_KEYS;
        }
    }
    }
