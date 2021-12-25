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

public class AngelScriptForImpl extends ASTWrapperPsiElement implements AngelScriptFor {

  public AngelScriptForImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitFor(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<AngelScriptAssign> getAssignList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptAssign.class);
  }

  @Override
  @NotNull
  public List<AngelScriptExprstat> getExprstatList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptExprstat.class);
  }

  @Override
  @Nullable
  public AngelScriptStatement getStatement() {
    return findChildByClass(AngelScriptStatement.class);
  }

  @Override
  @Nullable
  public AngelScriptVar getVar() {
    return findChildByClass(AngelScriptVar.class);
  }

}
