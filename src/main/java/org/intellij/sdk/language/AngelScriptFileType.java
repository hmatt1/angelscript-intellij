package org.intellij.sdk.language;

import com.intellij.openapi.fileTypes.LanguageFileType;
import com.intellij.openapi.util.NlsContexts;
import com.intellij.openapi.util.NlsSafe;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class AngelScriptFileType extends LanguageFileType {

    public static final AngelScriptFileType INSTANCE = new AngelScriptFileType();

    public AngelScriptFileType() {
       super(AngelScriptLanguage.INSTANCE);
    }

    @Override
    public @NonNls @NotNull String getName() {
        return "AngelScript File";
    }

    @Override
    public @NlsContexts.Label @NotNull String getDescription() {
        return "AngelScript Language File";
    }

    @Override
    public @NlsSafe @NotNull String getDefaultExtension() {
        return "as";
    }

    @Override
    public @Nullable Icon getIcon() {
        return AngelScriptIcons.FILE;
    }
}
