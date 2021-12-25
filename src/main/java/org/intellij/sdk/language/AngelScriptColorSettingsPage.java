package org.intellij.sdk.language;

import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class AngelScriptColorSettingsPage implements ColorSettingsPage {

  private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{
          new AttributesDescriptor("Bad character", AngelScriptSyntaxHighlighter.BAD_CHARACTER),
          new AttributesDescriptor("Dot", AngelScriptSyntaxHighlighter.DOT),
          new AttributesDescriptor("Identifier", AngelScriptSyntaxHighlighter.IDENTIFIER),
          new AttributesDescriptor("Parentheses", AngelScriptSyntaxHighlighter.PARENTHESES),
          new AttributesDescriptor("Comma", AngelScriptSyntaxHighlighter.COMMA),
          new AttributesDescriptor("Semicolon", AngelScriptSyntaxHighlighter.SEMICOLON),
          new AttributesDescriptor("Braces", AngelScriptSyntaxHighlighter.BRACES),
          new AttributesDescriptor("Brackets", AngelScriptSyntaxHighlighter.BRACKETS),
          new AttributesDescriptor("Operation", AngelScriptSyntaxHighlighter.OPERATION_SIGN),
          new AttributesDescriptor("Line comment", AngelScriptSyntaxHighlighter.LINE_COMMENT),
          new AttributesDescriptor("Block comment", AngelScriptSyntaxHighlighter.BLOCK_COMMENT),
          new AttributesDescriptor("String", AngelScriptSyntaxHighlighter.STRING),
          new AttributesDescriptor("Number", AngelScriptSyntaxHighlighter.NUMBER),
          new AttributesDescriptor("Keyword", AngelScriptSyntaxHighlighter.KEYWORD),
  };

  @Nullable
  @Override
  public Icon getIcon() {
    return AngelScriptIcons.FILE;
  }

  @NotNull
  @Override
  public SyntaxHighlighter getHighlighter() {
    return new AngelScriptSyntaxHighlighter();
  }

  @NotNull
  @Override
  public String getDemoText() {
    return "// line comment\n" +
            "/*\n" +
            "    Block comment\n" +
            "*/\n" +
            "[Setting foo = \"abc123\"]\n" +
            "class MyClass {\n" +
            "  void myMethod() {\n" +
            "    print(\"In MyClass::myMethod()\\n\");\n" +
            "    array<string> @args = myUtil.getCommandLineArgs();\n" +
            "    bool bar = (a || b) >>> c + Foo::doBaz(5.0, 3.0);\n" +
            "  }\n" +
            "}\n";
  }

  @Nullable
  @Override
  public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
    return null;
  }

  @Override
  public AttributesDescriptor @NotNull [] getAttributeDescriptors() {
    return DESCRIPTORS;
  }

  @Override
  public ColorDescriptor @NotNull [] getColorDescriptors() {
    return ColorDescriptor.EMPTY_ARRAY;
  }

  @NotNull
  @Override
  public String getDisplayName() {
    return "AngelScript";
  }

}