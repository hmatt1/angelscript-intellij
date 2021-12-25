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

public class AngelScriptStatementImpl extends ASTWrapperPsiElement implements AngelScriptStatement {

  public AngelScriptStatementImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitStatement(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public AngelScriptBreak getBreak() {
    return findChildByClass(AngelScriptBreak.class);
  }

  @Override
  @Nullable
  public AngelScriptContinue getContinue() {
    return findChildByClass(AngelScriptContinue.class);
  }

  @Override
  @Nullable
  public AngelScriptDowhile getDowhile() {
    return findChildByClass(AngelScriptDowhile.class);
  }

  @Override
  @Nullable
  public AngelScriptExprstat getExprstat() {
    return findChildByClass(AngelScriptExprstat.class);
  }

  @Override
  @Nullable
  public AngelScriptFor getFor() {
    return findChildByClass(AngelScriptFor.class);
  }

  @Override
  @Nullable
  public AngelScriptIf getIf() {
    return findChildByClass(AngelScriptIf.class);
  }

  @Override
  @Nullable
  public AngelScriptReturn getReturn() {
    return findChildByClass(AngelScriptReturn.class);
  }

  @Override
  @Nullable
  public AngelScriptStatblock getStatblock() {
    return findChildByClass(AngelScriptStatblock.class);
  }

  @Override
  @Nullable
  public AngelScriptSwitch getSwitch() {
    return findChildByClass(AngelScriptSwitch.class);
  }

  @Override
  @Nullable
  public AngelScriptTry getTry() {
    return findChildByClass(AngelScriptTry.class);
  }

  @Override
  @Nullable
  public AngelScriptWhile getWhile() {
    return findChildByClass(AngelScriptWhile.class);
  }

}
