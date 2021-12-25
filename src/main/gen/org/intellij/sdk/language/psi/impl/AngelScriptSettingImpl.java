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

public class AngelScriptSettingImpl extends ASTWrapperPsiElement implements AngelScriptSetting {

  public AngelScriptSettingImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitSetting(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<AngelScriptArglist> getArglistList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptArglist.class);
  }

  @Override
  @NotNull
  public List<AngelScriptExpr> getExprList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptExpr.class);
  }

  @Override
  @NotNull
  public List<AngelScriptIdentifier> getIdentifierList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptIdentifier.class);
  }

  @Override
  @NotNull
  public List<AngelScriptInitlist> getInitlistList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptInitlist.class);
  }

  @Override
  @NotNull
  public List<AngelScriptSetting> getSettingList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptSetting.class);
  }

  @Override
  @Nullable
  public AngelScriptType getType() {
    return findChildByClass(AngelScriptType.class);
  }

}
