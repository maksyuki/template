import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "PlatformSupport"
    Depends { name: "Qt"; submodules: ["core-private", "gui-private"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: ["/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Gui.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5DBus.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Core.so.5.7.1", "pthread", "dl", "gthread-2.0", "rt", "glib-2.0", "Xrender", "Xext", "X11", "m", "fontconfig", "freetype", "EGL", "GL"]
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: ["-pthread"]
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5PlatformSupport"
    libNameForLinkerRelease: "Qt5PlatformSupport"
    libFilePathDebug: ""
    libFilePathRelease: "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5PlatformSupport.a"
    cpp.defines: ["QT_PLATFORMSUPPORT_LIB"]
    cpp.includePaths: ["/opt/Qt5.7.1/5.7/gcc_64/include", "/opt/Qt5.7.1/5.7/gcc_64/include/QtPlatformSupport", "/opt/Qt5.7.1/5.7/gcc_64/include/QtPlatformSupport/5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/include/QtPlatformSupport/5.7.1/QtPlatformSupport"]
    cpp.libraryPaths: ["/usr/lib64", "/opt/Qt5.7.1/5.7/gcc_64/lib"]
    isStaticLibrary: true
}
