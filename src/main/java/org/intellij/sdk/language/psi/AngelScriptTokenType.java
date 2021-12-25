package org.intellij.sdk.language.psi;

import com.intellij.psi.tree.IElementType;
import org.intellij.sdk.language.AngelScriptLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class AngelScriptTokenType extends IElementType {
    public AngelScriptTokenType(@NotNull @NonNls String debugName) {
        super(debugName, AngelScriptLanguage.INSTANCE);
    }

    @Override
    public String toString() {
        return "AngelScriptTokenType." + super.toString();
    }
}
