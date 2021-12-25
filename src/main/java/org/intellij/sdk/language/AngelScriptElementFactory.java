package org.intellij.sdk.language;

import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiFileFactory;
import org.intellij.sdk.language.psi.AngelScriptFile;
import org.intellij.sdk.language.psi.AngelScriptIdentifier;

public class AngelScriptElementFactory {
    public static AngelScriptIdentifier createIdentifier(Project project, String name) {
        final AngelScriptFile file = createFile(project, name);
        return (AngelScriptIdentifier) file.getFirstChild();
    }

    public static AngelScriptFile createFile(Project project, String text) {
        String name = "dummy.simple";
        return (AngelScriptFile) PsiFileFactory.getInstance(project).
                createFileFromText(name, AngelScriptFileType.INSTANCE, text);
    }
}
