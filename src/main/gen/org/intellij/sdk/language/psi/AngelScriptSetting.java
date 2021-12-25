// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AngelScriptSetting extends PsiElement {

  @NotNull
  List<AngelScriptArglist> getArglistList();

  @NotNull
  List<AngelScriptExpr> getExprList();

  @NotNull
  List<AngelScriptIdentifier> getIdentifierList();

  @NotNull
  List<AngelScriptInitlist> getInitlistList();

  @NotNull
  List<AngelScriptSetting> getSettingList();

  @Nullable
  AngelScriptType getType();

}
