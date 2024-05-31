import org.jetbrains.intellij.platform.gradle.TestFrameworkType

buildscript {
    repositories {
        mavenCentral()
    }
}

plugins {
    id("org.jetbrains.intellij.platform") version "2.0.0-beta5"
    id("java")
    id("idea")
}

repositories {
    mavenCentral()

    intellijPlatform {
        defaultRepositories()
    }
}

idea {
    module {
        generatedSourceDirs.add(file("gen"))
    }
}

group "com.angelscript"
version "1.4.0"

java.sourceCompatibility = JavaVersion.VERSION_17
java.targetCompatibility = JavaVersion.VERSION_17

dependencies {
    intellijPlatform {
        intellijIdeaCommunity("2024.1.2")

        bundledPlugin("com.intellij.java")

        pluginVerifier()
        zipSigner()
        instrumentationTools()

        testFramework(TestFrameworkType.Platform.JUnit4)
        testFramework(TestFrameworkType.Platform.JUnit5)

        testImplementation("org.junit.platform:junit-platform-launcher:1.9.1")
        testImplementation("org.junit.jupiter:junit-jupiter-api:5.8.2")
        testImplementation("org.junit.jupiter:junit-jupiter-params:5.8.2")
        testImplementation("org.hamcrest:hamcrest:2.2")
        testImplementation("org.assertj:assertj-core:3.11.1")
        testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.8.2")
  }
}

// See https://github.com/JetBrains/gradle-intellij-plugin/
intellijPlatform {
    pluginConfiguration {
        version = "1.4.0"
        group = "com.angelscript"
        description = """
        AngelScript is a free, open source, flexible, and cross-platform scripting library meant to be embedded in applications.

        This plugin adds language support for people who are using Intellij to develop with AngelScript. It adds features such as syntax highlighting, code-completion for variables, and allows Intellij to identify AngelScript files using the .as extension.

        To update the syntax highlighting color preferences, go to Settings -> Editor -> Color Scheme -> AngelScript.
        """

        changeNotes = """
      Added support for Intellij 2024.1 and up
      """

        ideaVersion {
            sinceBuild = "241"
        }
    }

    signing {
        certificateChain =  System.getenv("CHAIN_CRT")

        privateKey = System.getenv("PRIVATE_PEM")

        password = System.getenv("PEM_PASSWORD")
    }

    publishing {
        token = System.getenv("INTELLIJ_TOKEN")
    }

    verifyPlugin {
        ides {
            recommended()
        }
    }
}

tasks.test {
    useJUnitPlatform()
}


java.sourceSets["main"].java {
    srcDir("src/main/gen")
}


