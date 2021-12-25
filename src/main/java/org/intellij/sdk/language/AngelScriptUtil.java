package org.intellij.sdk.language;

import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.PsiManager;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import com.intellij.psi.util.PsiTreeUtil;
import org.intellij.sdk.language.psi.AngelScriptFile;
import org.intellij.sdk.language.psi.AngelScriptIdentifier;
import org.intellij.sdk.language.psi.AngelScriptVar;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class AngelScriptUtil {
    public static List<AngelScriptVar> findVars(Project project, String key) {

        List<AngelScriptVar> result = null;
        Collection<VirtualFile> virtualFiles =
                FileTypeIndex.getFiles(AngelScriptFileType.INSTANCE,
                        GlobalSearchScope.allScope(project));
        for (VirtualFile virtualFile : virtualFiles) {
            AngelScriptFile simpleFile = (AngelScriptFile) PsiManager.getInstance(project).findFile(virtualFile);
            if (simpleFile != null) {
                List<PsiElement> elements = PsiTreeUtil.getChildrenOfTypeAsList(simpleFile, PsiElement.class);
                for (var element : elements) {
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    if (element instanceof AngelScriptVar) {
                        AngelScriptVar elementVar = (AngelScriptVar) element;
//                        if (key.equals(elementVar.getIdent())) {
                            result.add(elementVar);
//                        }
                    }
                }
            }
        }
        return result != null ? result : Collections.emptyList();
    }

    public static List<AngelScriptVar> findVars(Project project) {

        List<AngelScriptVar> result = null;
        Collection<VirtualFile> virtualFiles =
                FileTypeIndex.getFiles(AngelScriptFileType.INSTANCE,
                        GlobalSearchScope.allScope(project));
        for (VirtualFile virtualFile : virtualFiles) {
            AngelScriptFile simpleFile = (AngelScriptFile) PsiManager.getInstance(project).findFile(virtualFile);
            if (simpleFile != null) {

                List<PsiElement> elements = PsiTreeUtil.getChildrenOfTypeAsList(simpleFile, PsiElement.class);
                for (var element : elements) {
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    if (element instanceof AngelScriptVar) {
                        result.add((AngelScriptVar) element);
                    }
                }
            }
        }
        return result != null ? result : Collections.emptyList();
    }

    public static List<String> findVars(PsiFile file) {

        List<String> result = new ArrayList<>();

        if (file instanceof AngelScriptFile) {

            List<PsiElement> elements = PsiTreeUtil.getChildrenOfTypeAsList(file, PsiElement.class);
            for (var element : elements) {
                if (element instanceof AngelScriptVar) {
                    try {
                        String text = element.getFirstChild().getNextSibling().getNextSibling().getText();
                        result.add(text);
                    } catch(Exception ignored){}

                }
            }
        }
        return result;
    }
}
