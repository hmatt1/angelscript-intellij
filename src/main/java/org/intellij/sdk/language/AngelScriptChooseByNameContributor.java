package org.intellij.sdk.language;

import com.intellij.navigation.ChooseByNameContributor;
import com.intellij.navigation.ItemPresentation;
import com.intellij.navigation.NavigationItem;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.NlsSafe;
import org.intellij.sdk.language.psi.AngelScriptVar;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AngelScriptChooseByNameContributor implements ChooseByNameContributor {

  @NotNull
  @Override
  public String @NotNull [] getNames(Project project, boolean includeNonProjectItems) {
    List<AngelScriptVar> properties = AngelScriptUtil.findVars(project);
    List<String> names = new ArrayList<>();
    for (AngelScriptVar property : properties) {
      if (property.getIdent() != null && property.getIdent().length() > 0) {
        names.add(property.getIdent());
      }
    }

    return names.toArray(new String[0]);
  }

  @NotNull
  @Override
  public NavigationItem @NotNull [] getItemsByName(String name, String pattern, Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    List<AngelScriptVar> properties = AngelScriptUtil.findVars(project, name);

    List<NavigationItem> items = new ArrayList<>();

    for (AngelScriptVar angelScriptVar : properties) {
      NavigationItem item = (NavigationItem) angelScriptVar.getNavigationElement();
      items.add(item);
    }


    return items.toArray(new NavigationItem[0]);
  }

}