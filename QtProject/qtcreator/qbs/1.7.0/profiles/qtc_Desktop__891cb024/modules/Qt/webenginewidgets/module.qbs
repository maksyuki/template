import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "WebEngineWidgets"
    Depends { name: "Qt"; submodules: ["core", "gui", "webenginecore", "widgets", "network", "quick"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5WebEngineCore.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Quick.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Widgets.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Gui.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5WebChannel.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Qml.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Network.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Positioning.so.5.7.1", "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5Core.so.5.7.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5WebEngineWidgets"
    libNameForLinkerRelease: "Qt5WebEngineWidgets"
    libFilePathDebug: ""
    libFilePathRelease: "/opt/Qt5.7.1/5.7/gcc_64/lib/libQt5WebEngineWidgets.so.5.7.1"
    cpp.defines: ["QT_WEBENGINEWIDGETS_LIB"]
    cpp.includePaths: ["/opt/Qt5.7.1/5.7/gcc_64/include", "/opt/Qt5.7.1/5.7/gcc_64/include/QtWebEngineWidgets"]
    cpp.libraryPaths: ["/usr/lib64", "/opt/Qt5.7.1/5.7/gcc_64/lib", "/opt/Qt5.7.1/5.7/gcc_64/lib"]
    
}
