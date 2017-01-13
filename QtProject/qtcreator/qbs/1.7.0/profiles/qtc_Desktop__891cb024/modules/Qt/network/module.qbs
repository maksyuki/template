import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "Network"
    Depends { name: "Qt"; submodules: ["core"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Core.so.5.7.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5Network"
    libNameForLinkerRelease: "Qt5Network"
    libFilePathDebug: ""
    libFilePathRelease: "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Network.so.5.7.1"
    cpp.defines: ["QT_NETWORK_LIB"]
    cpp.includePaths: ["/opt/Qt5.7.1/5.7/gcc_64/include", "/opt/Qt5.7.1/5.7/gcc_64/include/QtNetwork"]
    cpp.libraryPaths: ["/opt/Qt5.7.1/5.7/gcc_64/lib"]
    
}
