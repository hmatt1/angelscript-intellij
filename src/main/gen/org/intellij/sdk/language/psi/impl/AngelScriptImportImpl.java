// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static org.intellij.sdk.language.psi.AngelScriptElementTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import org.intellij.sdk.language.psi.*;

public class AngelScriptImportImpl extends ASTWrapperPsiElement implements AngelScriptImport {

  public AngelScriptImportImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitImport(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public AngelScriptFuncattr getFuncattr() {
    return findChildByClass(AngelScriptFuncattr.class);
  }

  @Override
  @Nullable
  public AngelScriptIdentifier getIdentifier() {
    return findChildByClass(AngelScriptIdentifier.class);
  }

  @Override
  @Nullable
  public AngelScriptParamlist getParamlist() {
    return findChildByClass(AngelScriptParamlist.class);
  }

  @Override
  @Nullable
  public AngelScriptString getString() {
    return findChildByClass(AngelScriptString.class);
  }

  @Override
  @Nullable
  public AngelScriptType getType() {
    return findChildByClass(AngelScriptType.class);
  }

}
