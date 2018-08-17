# scannermodule

Android Doc Scanner Setup:

MainApplication.java
in function getPackages():
new RNScannerModulePackage(),

build.gradle
implementation project(':reactscanner')

settings.gradle
include ':reactscanner'
project(':reactscanner').projectDir = new File(rootProject.projectDir, '../node_modules/scannermodule/android/reactscanner')
include ':scanlibrary'
project(':scanlibrary').projectDir = new File(rootProject.projectDir, '../node_modules/scannermodule/android/scanlibrary')

iOS Doc Scanner TODO:

Finish integrating WeScan
Finish implementing WeScan delegate functions (included the swift version as ViewController.swift)
Use the logic from pageSnapped in WeScan's delegate function for when the image is captured and cropped 
