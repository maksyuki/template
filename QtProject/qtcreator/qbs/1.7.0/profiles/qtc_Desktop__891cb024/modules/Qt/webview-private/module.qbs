import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "WebView"
    Depends { name: "Qt"; submodules: ["webview", "quick-private", "gui-private"]}

    hasLibrary: false
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: ""
    libNameForLinkerRelease: ""
    libFilePathDebug: ""
    libFilePathRelease: ""
    cpp.defines: []
    cpp.includePaths: ["/opt/Qt5.7.1/5.7/gcc_64/include/QtWebView/5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/include/QtWebView/5.7.1/QtWebView"]
    cpp.libraryPaths: []
    
}
