plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.dr.nadaSalma"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.dr.nadaSalma"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        multiDexEnabled = true

        ndk {
            abiFilters += listOf("x86", "armeabi-v7a")
        }
    }

    signingConfigs {
        create("release") {
            storeFile = file("upload-key.jks")
            storePassword = "drnada12345678"
            keyAlias = "release"
            keyPassword = "drnada12345678"
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true           // ✅ Enable code shrinking & obfuscation
            isShrinkResources = true         // ✅ Remove unused resources
            signingConfig = signingConfigs.getByName("release")

            // Use default ProGuard rules + custom rules
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        getByName("debug") {
            signingConfig = signingConfigs.getByName("release") // Optional: use same keystore for debug if needed
        }
    }
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("com.google.firebase:firebase-analytics")
    implementation(platform("com.google.firebase:firebase-bom:34.5.0"))
}

flutter {
    source = "../.."
}
