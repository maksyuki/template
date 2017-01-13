import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "MultimediaQuick_p"
    Depends { name: "Qt"; submodules: ["core", "quick", "multimedia-private"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Multimedia.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Quick.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Gui.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Qml.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Network.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Core.so.5.7.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5MultimediaQuick_p"
    libNameForLinkerRelease: "Qt5MultimediaQuick_p"
    libFilePathDebug: ""
    libFilePathRelease: "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5MultimediaQuick_p.so.5.7.1"
    cpp.defines: ["QT_QTMULTIMEDIAQUICKTOOLS_LIB"]
    cpp.includePaths: ["/opt/Qt5.7.1/5.7/gcc_64/include", "/opt/Qt5.7.1/5.7/gcc_64/include/QtMultimediaQuick_p", "/opt/Qt5.7.1/5.7/gcc_64/include/QtMultimediaQuick_p/5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/include/QtMultimediaQuick_p/5.7.1/QtMultimediaQuick_p"]
    cpp.libraryPaths: ["/usr/lib64", "/opt/Qt5.7.1/5.7/gcc_64/lib", "/opt/Qt5.7.1/5.7/gcc_64/lib"]
    
}
