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

public class AngelScriptTypeImpl extends ASTWrapperPsiElement implements AngelScriptType {

  public AngelScriptTypeImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitType(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public AngelScriptDatatype getDatatype() {
    return findNotNullChildByClass(AngelScriptDatatype.class);
  }

  @Override
  @NotNull
  public AngelScriptScope getScope() {
    return findNotNullChildByClass(AngelScriptScope.class);
  }

  @Override
  @NotNull
  public List<AngelScriptType> getTypeList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptType.class);
  }

}
