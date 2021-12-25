// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AngelScriptNamespa extends PsiElement {

  @NotNull
  List<AngelScriptClazz> getClazzList();

  @NotNull
  List<AngelScriptEnum> getEnumList();

  @NotNull
  List<AngelScriptFunc> getFuncList();

  @NotNull
  List<AngelScriptFuncc> getFunccList();

  @NotNull
  List<AngelScriptFuncdef> getFuncdefList();

  @NotNull
  List<AngelScriptIdentifier> getIdentifierList();

  @NotNull
  List<AngelScriptImport> getImportList();

  @NotNull
  List<AngelScriptInterface> getInterfaceList();

  @NotNull
  List<AngelScriptMixin> getMixinList();

  @NotNull
  List<AngelScriptNamespa> getNamespaList();

  @NotNull
  List<AngelScriptSetting> getSettingList();

  @NotNull
  List<AngelScriptStatement> getStatementList();

  @NotNull
  List<AngelScriptStruct> getStructList();

  @NotNull
  List<AngelScriptTypedef> getTypedefList();

  @NotNull
  List<AngelScriptVar> getVarList();

  @NotNull
  List<AngelScriptVirtprop> getVirtpropList();

}
