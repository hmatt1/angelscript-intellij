// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static org.intellij.sdk.language.psi.AngelScriptElementTypes.*;
import org.intellij.sdk.language.psi.*;
import com.intellij.navigation.ItemPresentation;

public class AngelScriptVarImpl extends AngelScriptNamedElementImpl implements AngelScriptVar {

  public AngelScriptVarImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitVar(this);
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
  public List<AngelScriptCondition> getConditionList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptCondition.class);
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
  public AngelScriptType getType() {
    return findNotNullChildByClass(AngelScriptType.class);
  }

  @Override
  public String getIdent() {
    return AngelScriptPsiImplUtil.getIdent(this);
  }

  @Override
  public String getName() {
    return AngelScriptPsiImplUtil.getName(this);
  }

  @Override
  public PsiElement setName(String newName) {
    return AngelScriptPsiImplUtil.setName(this, newName);
  }

  @Override
  public PsiElement getNameIdentifier() {
    return AngelScriptPsiImplUtil.getNameIdentifier(this);
  }

  @Override
  public ItemPresentation getPresentation() {
    return AngelScriptPsiImplUtil.getPresentation(this);
  }

}
