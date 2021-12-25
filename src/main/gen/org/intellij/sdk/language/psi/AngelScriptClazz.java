// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AngelScriptClazz extends PsiElement {

  @NotNull
  List<AngelScriptFunc> getFuncList();

  @NotNull
  List<AngelScriptFuncc> getFunccList();

  @NotNull
  List<AngelScriptFuncdef> getFuncdefList();

  @Nullable
  AngelScriptIdentifier getIdentifier();

  @NotNull
  List<AngelScriptSetting> getSettingList();

  @NotNull
  List<AngelScriptStatement> getStatementList();

  @NotNull
  List<AngelScriptStruct> getStructList();

  @NotNull
  List<AngelScriptVar> getVarList();

  @NotNull
  List<AngelScriptVaraccess> getVaraccessList();

  @NotNull
  List<AngelScriptVirtprop> getVirtpropList();

}
