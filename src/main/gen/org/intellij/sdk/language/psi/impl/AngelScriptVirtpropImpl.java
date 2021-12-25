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

public class AngelScriptVirtpropImpl extends ASTWrapperPsiElement implements AngelScriptVirtprop {

  public AngelScriptVirtpropImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitVirtprop(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<AngelScriptFuncattr> getFuncattrList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptFuncattr.class);
  }

  @Override
  @NotNull
  public AngelScriptIdentifier getIdentifier() {
    return findNotNullChildByClass(AngelScriptIdentifier.class);
  }

  @Override
  @NotNull
  public List<AngelScriptStatblock> getStatblockList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptStatblock.class);
  }

  @Override
  @NotNull
  public AngelScriptType getType() {
    return findNotNullChildByClass(AngelScriptType.class);
  }

}
