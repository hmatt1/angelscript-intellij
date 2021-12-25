// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AngelScriptFor extends PsiElement {

  @NotNull
  List<AngelScriptAssign> getAssignList();

  @NotNull
  List<AngelScriptExprstat> getExprstatList();

  @Nullable
  AngelScriptStatement getStatement();

  @Nullable
  AngelScriptVar getVar();

}
