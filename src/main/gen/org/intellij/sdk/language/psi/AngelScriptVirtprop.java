// This is a generated file. Not intended for manual editing.
package org.intellij.sdk.language.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AngelScriptVirtprop extends PsiElement {

  @NotNull
  List<AngelScriptFuncattr> getFuncattrList();

  @NotNull
  AngelScriptIdentifier getIdentifier();

  @NotNull
  List<AngelScriptStatblock> getStatblockList();

  @NotNull
  AngelScriptType getType();

}
