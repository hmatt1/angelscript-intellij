package org.intellij.sdk.language.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import org.intellij.sdk.language.AngelScriptElementFactory;
import org.intellij.sdk.language.AngelScriptIcons;
import org.intellij.sdk.language.psi.*;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Optional;

import static org.intellij.sdk.language.psi.AngelScriptElementTypes.T_IDENT;

public class AngelScriptPsiImplUtil {


    public static String getIdent(AngelScriptVar element) {
        return element.getText();
    }

    public static String getName(AngelScriptVar element) {
        return "todoname";
//        Optional<AngelScriptExpr> first = element.getExprList().stream().filter(node -> node.getExprtermList().size() > 0).findFirst();
//
//        if (first.isEmpty()) {
//            return null;
//        }
//
//
//        return first.get().getText();
//
//        ASTNode keyNode = first.get().getNode().findChildByType(AngelScriptElementTypes.IDENTIFIER);
//        if (keyNode != null) {
//            // IMPORTANT: Convert embedded escaped spaces to simple spaces
//            return keyNode.getText().replaceAll("\\\\ ", " ");
//        } else {
//            return null;
//        }
    }

     static PsiElement setName(AngelScriptVar element, String newName) {
        ASTNode keyNode = element.getNode().findChildByType(T_IDENT);
        if (keyNode != null) {

            AngelScriptIdentifier property = AngelScriptElementFactory.createIdentifier(element.getProject(), newName);
            ASTNode newKeyNode = property.getFirstChild().getNode();
            element.getNode().replaceChild(keyNode, newKeyNode);
        }
        return element;
    }

    public static PsiElement getNameIdentifier(AngelScriptVar element) {
        return element;
    }

    public static ItemPresentation getPresentation(final AngelScriptVar element) {
        return new ItemPresentation() {
            @Nullable
            @Override
            public String getPresentableText() {
                return element.getIdent();
            }

            @Nullable
            @Override
            public String getLocationString() {
                PsiFile containingFile = element.getContainingFile();
                return containingFile == null ? null : containingFile.getName();
            }

            @Override
            public Icon getIcon(boolean unused) {
                return AngelScriptIcons.FILE;
            }
        };
    }
}
