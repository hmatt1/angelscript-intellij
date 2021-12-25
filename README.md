# angelscript-intellij
AngelScript Intellij Plugin Language Support

## Color Settings

![](./assets/Intellij%20AngelScript%20Color%20Settings.png)

## Test cases sources
 
Scripts for test scenarios are located in [scripts](./src/test/testData/scripts)

I downloaded the test cases from [svn](http://svn.code.sf.net/p/angelscript/code/trunk/sdk/tests/test_feature/)
and parsed them into separate files using the [run.sh](./util/run.sh) to get the test cases.

Additionally, I downloaded sources for various [OpenPlanet plugins](https://openplanet.nl/files) and added them to the test scenarios.

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