// plugins {
//     id("com.android.application")
//     // START: FlutterFire Configuration
//     id("com.google.gms.google-services")
//     // END: FlutterFire Configuration
//     id("kotlin-android")
//     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//     id("dev.flutter.flutter-gradle-plugin")
// }

// android {
//     namespace = "com.example.groz2"
//     compileSdk = flutter.compileSdkVersion
//     ndkVersion = flutter.ndkVersion

//     compileOptions {
//         sourceCompatibility = JavaVersion.VERSION_11
//         targetCompatibility = JavaVersion.VERSION_11
//     }

//     kotlinOptions {
//         jvmTarget = JavaVersion.VERSION_11.toString()
//     }

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId = "com.example.groz2"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://flutter.dev/to/review-gradle-config.
//         minSdk = flutter.minSdkVersion
//         targetSdk = flutter.targetSdkVersion
//         versionCode = flutter.versionCode
//         versionName = flutter.versionName
//     }

//     buildTypes {
//         release {
//             // TODO: Add your own signing config for the release build.
//             // Signing with the debug keys for now, so `flutter run --release` works.
//             signingConfig = signingConfigs.getByName("debug")
//         }
//     }
// }

// flutter {
//     source = "../.."
// }

// plugins {
//     id("com.android.application")
//     // START: FlutterFire Configuration
//     id("com.google.gms.google-services")
//     // END: FlutterFire Configuration
//     id("kotlin-android")
//     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//     id("dev.flutter.flutter-gradle-plugin")
// }
// android {
//     namespace = "com.example.colaboration"
//     compileSdk = 34
//     ndkVersion = "27.2.12479018"

//     compileOptions {
//         sourceCompatibility = JavaVersion.VERSION_11
//         targetCompatibility = JavaVersion.VERSION_11
//     }

//     kotlinOptions {
//         jvmTarget = JavaVersion.VERSION_11.toString()
//     }

//     defaultConfig {
//         applicationId = "com.example.colaboration"
//         minSdkVersion = "23"
//         targetSdkVersion = "34"
//         versionCode = "2"
//         versionName "1.1.0"
//         multiDexEnabled true // Important for Firebase
//     }

//     buildTypes {
//         release {
//             signingConfig = signingConfigs.getByName("debug")
//             minifyEnabled false
//             shrinkResources false
//         }
//     }
// }

// flutter {
//     source = "../.."
// }

// // Add this at the bottom of the file to apply the Google Services plugin
// // apply plugin: 'com.google.gms.google-services'


plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.groz2"
    compileSdk = 34
    ndkVersion = "27.2.12479018"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.groz2"
        minSdk = 23                    // Use 'minSdk' with Int, no quotes
        targetSdk = 34                 // Use 'targetSdk' with Int, no quotes
        versionCode = 2                // Int, no quotes
        versionName = "1.1.0"          // String with '='
        multiDexEnabled = true         // Boolean with '='
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false      // Use 'isMinifyEnabled' in Kotlin DSL
            isShrinkResources = false    // Use 'isShrinkResources' in Kotlin DSL
        }
    }
}

flutter {
    source = "../.."
}

// Google Services plugin is applied via the plugins block, no need to reapply here.
