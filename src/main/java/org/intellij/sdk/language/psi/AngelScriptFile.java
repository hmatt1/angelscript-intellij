package org.intellij.sdk.language.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.intellij.sdk.language.AngelScriptFileType;
import org.intellij.sdk.language.AngelScriptLanguage;
import org.jetbrains.annotations.NotNull;

public class AngelScriptFile extends PsiFileBase {

    public AngelScriptFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, AngelScriptLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return AngelScriptFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "AngelScript File";
    }

}
