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

public class AngelScriptNamespaImpl extends ASTWrapperPsiElement implements AngelScriptNamespa {

  public AngelScriptNamespaImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull AngelScriptVisitor visitor) {
    visitor.visitNamespa(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof AngelScriptVisitor) accept((AngelScriptVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<AngelScriptClazz> getClazzList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptClazz.class);
  }

  @Override
  @NotNull
  public List<AngelScriptEnum> getEnumList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptEnum.class);
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
  @NotNull
  public List<AngelScriptIdentifier> getIdentifierList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptIdentifier.class);
  }

  @Override
  @NotNull
  public List<AngelScriptImport> getImportList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptImport.class);
  }

  @Override
  @NotNull
  public List<AngelScriptInterface> getInterfaceList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptInterface.class);
  }

  @Override
  @NotNull
  public List<AngelScriptMixin> getMixinList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptMixin.class);
  }

  @Override
  @NotNull
  public List<AngelScriptNamespa> getNamespaList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptNamespa.class);
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
  public List<AngelScriptTypedef> getTypedefList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptTypedef.class);
  }

  @Override
  @NotNull
  public List<AngelScriptVar> getVarList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptVar.class);
  }

  @Override
  @NotNull
  public List<AngelScriptVirtprop> getVirtpropList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, AngelScriptVirtprop.class);
  }

}
