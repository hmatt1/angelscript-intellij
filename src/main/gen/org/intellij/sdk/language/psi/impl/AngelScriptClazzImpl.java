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

public class AngelScriptClazzImpl extends ASTWrapperPsiElement implements AngelScriptClazz {

  public AngelScriptClazzImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitClazz(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<AngelScriptFunc> getFuncList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptFunc.class);
  }

  @Override
  @NotNull
  public List<AngelScriptFuncc> getFunccList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptFuncc.class);
  }

  @Override
  @NotNull
  public List<AngelScriptFuncdef> getFuncdefList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptFuncdef.class);
  }

  @Override
  @Nullable
  public AngelScriptIdentifier getIdentifier() {
    return findChildByClass(AngelScriptIdentifier.class);
  }

  @Override
  @NotNull
  public List<AngelScriptSetting> getSettingList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptSetting.class);
  }

  @Override
  @NotNull
  public List<AngelScriptStatement> getStatementList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptStatement.class);
  }

  @Override
  @NotNull
  public List<AngelScriptStruct> getStructList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptStruct.class);
  }

  @Override
  @NotNull
  public List<AngelScriptVar> getVarList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptVar.class);
  }

  @Override
  @NotNull
  public List<AngelScriptVaraccess> getVaraccessList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptVaraccess.class);
  }

  @Override
  @NotNull
  public List<AngelScriptVirtprop> getVirtpropList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptVirtprop.class);
  }

}
