
# **SwiftNetSwitch**
如果你的APP在开发测试阶段有多套网络环境，且不想频繁打包，可以使用这个组件很方便的在APP内切换各种配置好的网络环境。
你需要找到一个页面用于添加组件入口：
比如添加到导航栏上

![](Gif/nav.gif)

```
        #if DEBUG
            SwitchManager.shared.configWithNavBar(self) {
                print(“完成”)
            }
        #endif
```
或者直接添加到页面内

![](Gif/view.gif)

```
        SwitchManager.shared.configWithFrame(self, CGRect.init(x: 100, y: 100, width: 100, height: 50)) {
            print("完成")
        }
```
注意仅仅DEBUG阶段加入。

组件引用方式：
`pod ‘SwiftNetSwitch’, :configurations => [‘Debug’]`

环境变量设置：
```
        SwitchManager.shared.defaultSign = .debug
        SwitchManager.shared.configHostDebug = [“aaaDebug”:”111Debug","bbbDebug":"222Debug"]
        SwitchManager.shared.configHostRelease = ["aaaRelease":"111Release","bbbRelease":"222Release"]
        SwitchManager.shared.configHostDev = ["aaaDev":"111Dev","bbbDev":"222Dev"]
        SwitchManager.shared.configHostOther = [“aaaOther”:”111Other”,”bbbOther”:”222Other”,”cccOther”:”333Other","dddOther":"444Other"]
        SwitchManager.shared.setDefaultNetworkConfig()
```

环境变量你可以自建一个私有pod仓库，里边仅有一个类去设置环境变量，也是以`configurations => [‘Debug’]``的方式引入。
