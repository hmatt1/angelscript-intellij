package org.intellij.sdk.language;

import com.intellij.lexer.FlexAdapter;

public class AngelScriptLexerAdapter extends FlexAdapter {
    public AngelScriptLexerAdapter() {
        super(new _AngelScriptLexer(null));
    }
}
