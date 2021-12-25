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

public class AngelScriptExprvalueImpl extends ASTWrapperPsiElement implements AngelScriptExprvalue {

  public AngelScriptExprvalueImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitExprvalue(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public AngelScriptAssign getAssign() {
    return findChildByClass(AngelScriptAssign.class);
  }

  @Override
  @Nullable
  public AngelScriptCast getCast() {
    return findChildByClass(AngelScriptCast.class);
  }

  @Override
  @Nullable
  public AngelScriptConstructcall getConstructcall() {
    return findChildByClass(AngelScriptConstructcall.class);
  }

  @Override
  @Nullable
  public AngelScriptFunccall getFunccall() {
    return findChildByClass(AngelScriptFunccall.class);
  }

  @Override
  @Nullable
  public AngelScriptLambda getLambda() {
    return findChildByClass(AngelScriptLambda.class);
  }

  @Override
  @Nullable
  public AngelScriptLiteral getLiteral() {
    return findChildByClass(AngelScriptLiteral.class);
  }

  @Override
  @Nullable
  public AngelScriptVaraccess getVaraccess() {
    return findChildByClass(AngelScriptVaraccess.class);
  }

}
