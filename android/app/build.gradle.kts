plugins {
    id("com.android.application")
    // ✅ Firebase
    id("com.google.gms.google-services")
    // ✅ Kotlin
    id("kotlin-android")
    // ✅ Flutter Gradle Plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.solar_clean"
    compileSdk = 34

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.solar_clean"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")  // ✅ غيّر من "release" إلى "debug"
        isMinifyEnabled = false
        isShrinkResources = false
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
    debug {
        signingConfig = signingConfigs.getByName("debug")
    }
}
}

flutter {
    source = "../.."
}