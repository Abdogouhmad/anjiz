allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// TEMPORARY: workmanager_android 0.9.x skips kotlin-android on AGP 9+ and relies on
// built-in Kotlin, but android.builtInKotlin=false means nothing compiles its Kotlin.
// Remove once workmanager_android >= 0.10.5 is used.
subprojects {
    if (name == "workmanager_android") {
        pluginManager.withPlugin("com.android.library") {
            pluginManager.apply("org.jetbrains.kotlin.android")
        }
    }
}

// Force every plugin subproject to compile against JVM 17 so bytecode matches the app.
subprojects {
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    plugins.withId("com.android.library") {
        afterEvaluate {
            tasks.withType<JavaCompile>().configureEach {
                sourceCompatibility = JavaVersion.VERSION_17.toString()
                targetCompatibility = JavaVersion.VERSION_17.toString()
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    configurations.configureEach {
        resolutionStrategy {
            force(
                "androidx.glance:glance:1.1.1",
                "androidx.glance:glance-appwidget:1.1.1",
                "androidx.glance:glance-material:1.1.1",
                "androidx.glance:glance-material3:1.1.1",
                "androidx.glance:glance-template:1.1.1"
            )
        }
    }
}
