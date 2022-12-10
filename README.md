# AngelScript Intellij Plugin Language Support

For people who want to use Intellij to develop with AngelScript.

## Available soon!

Here is the preview page on the [Intellij Plugins Marketplace](https://plugins.jetbrains.com/plugin/18276-angelscript-language-support?preview=true)

## Features

### Token Highlighting

Currently all tokens can have syntax highlighting, such as `==`, `;`, keywords, etc. Identifier highlighting such as function names is not yet implemented.

### Color Settings

All highlighter colors can be changed on the settings page.

![](./assets/Intellij%20AngelScript%20Color%20Settings.png)

### Variable Name Code-completion

Only variable names are currently implemented. For example, if you have a script such as:

```as
int foo = 1;
int bar = 3 + f
```

As soon as you type the `f`, the option to auto-complete `foo` will pop up.

### Limitations

When using `#if`, `#elif`, etc, anything in the `#elif` block is treated as a comment. This is because I couldn't figure out how to get it working with mismatched braces.

## Contributing

Contributions are welcome!!!!! 😄

### Open an issue

Feel free to [open an issue](https://github.com/hmatt1/angelscript-intellij/issues/new) to report bugs, request features, or ask for help with contributing.

### Adding a Test Case
 
Scripts for test scenarios are located in [scripts](./src/test/testData/scripts). New script files can be added there, and then the file name needs to be added to [file_names.csv](./src/test/resources/file_names.csv]).

Most of the test cases are from the AngelScript [svn repository](http://svn.code.sf.net/p/angelscript/code/trunk/sdk/tests/test_feature/)
and parsed them into separate files using the [run.sh](./util/run.sh) to get the test cases, and then manually cleaned them up.

Additionally, I downloaded sources for various [OpenPlanet plugins](https://openplanet.nl/files) and added them to a seperate test scenario, with the file names in [ops.csv](./src/test/resources/ops.csv) and the scripts stored under [opscripts](./src/test/testData/opscripts).

## Publishing the Plugin

1. Update the plugin version in [build.gradle](https://github.com/hmatt1/angelscript-intellij/blob/main/build.gradle#L21)
2. Manually run the [Plugin Publishing Workflow](https://github.com/hmatt1/angelscript-intellij/actions/workflows/publish.yml)

## Resource

- https://www.angelcode.com/angelscript/sdk/docs/manual/doc_script_bnf.html
- https://plugins.jetbrains.com/docs/intellij/prerequisites.html
- https://plugins.jetbrains.com/docs/intellij/custom-language-support.html
- https://cs.au.dk/~amoeller/RegAut/JavaBNF.html
- https://github.com/JetBrains/intellij-community/blob/0e2aa4030ee763c9b0c828f0b5119f4cdcc66f35/plugins/sh/grammar/sh.bnf
- https://github.com/JetBrains/intellij-community/blob/a0d08b06cf01ecc2ac7e4f39e3c1a63b6bcca455/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/parser/groovy.bnf
- https://github.com/JetBrains/Grammar-Kit/blob/master/grammars/Grammar.bnf
- https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin
- https://github.com/ignatov/intellij-erlang/blob/macros-support/grammars/erlang.bnf
