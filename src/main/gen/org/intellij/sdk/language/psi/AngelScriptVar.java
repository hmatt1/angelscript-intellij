// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.intellij.navigation.ItemPresentation;

public interface AngelScriptVar extends AngelScriptNamedElement {

  @NotNull
  List<AngelScriptArglist> getArglistList();

  @NotNull
  List<AngelScriptCondition> getConditionList();

  @NotNull
  List<AngelScriptIdentifier> getIdentifierList();

  @NotNull
  List<AngelScriptInitlist> getInitlistList();

  @NotNull
  AngelScriptType getType();

  String getIdent();

  String getName();

  PsiElement setName(String newName);

  PsiElement getNameIdentifier();

  ItemPresentation getPresentation();

}
