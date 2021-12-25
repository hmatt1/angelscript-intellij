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

public class AngelScriptLiteralImpl extends ASTWrapperPsiElement implements AngelScriptLiteral {

  public AngelScriptLiteralImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitLiteral(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public AngelScriptBits getBits() {
    return findChildByClass(AngelScriptBits.class);
  }

  @Override
  @Nullable
  public AngelScriptNumber getNumber() {
    return findChildByClass(AngelScriptNumber.class);
  }

  @Override
  @Nullable
  public AngelScriptString getString() {
    return findChildByClass(AngelScriptString.class);
  }

}
