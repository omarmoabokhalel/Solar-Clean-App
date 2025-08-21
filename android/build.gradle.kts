import org.gradle.api.tasks.Delete
import org.gradle.api.tasks.compile.JavaCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ إخفاء تحذيرات Java قديمة و deprecated APIs
tasks.withType<JavaCompile>().configureEach {
    options.compilerArgs.add("-Xlint:-options")       // يخفي تحذير Java 8
    options.compilerArgs.add("-Xlint:-deprecation")   // يخفي تحذير استخدام APIs قديمة
}

// ✅ مهمة التنظيف
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
