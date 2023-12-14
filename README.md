# Awesome-SwiftUI-Library-For-Beginners
[「做个应用」](https://apps.apple.com/cn/app/%E5%81%9A%E4%B8%AA%E5%BA%94%E7%94%A8-swiftui-0-%E5%9F%BA%E7%A1%80%E5%BC%80%E5%8F%91%E5%BA%94%E7%94%A8/id1578873606)是一款教 O 基础的用户使用 SwiftUI 开发应用的 App，在这里我们将介绍作为初学者会使用到的第三方库，可以更简单便捷的帮助你开发应用。
![做个应用商店截图](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/assets/3838258/6db4e5b3-dac0-40e9-82b3-087904497049)

关于[「做个应用」](https://apps.apple.com/cn/app/%E5%81%9A%E4%B8%AA%E5%BA%94%E7%94%A8-swiftui-0-%E5%9F%BA%E7%A1%80%E5%BC%80%E5%8F%91%E5%BA%94%E7%94%A8/id1578873606)更多的详细介绍，可以[查看文章](https://juejin.cn/post/7308676997051072551).

# 目录
[1. 数据存储](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#1-%E6%95%B0%E6%8D%AE%E5%AD%98%E5%82%A8)

[2. 浮层](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#2-%E6%B5%AE%E5%B1%82)

[3. Toast](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#3-toast)

[4. 日期](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#4-%E6%97%A5%E6%9C%9F)

[5. 网络请求](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#5-%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82)

[6. Markdown](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#6-markdown)

[7. 布局样式](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#7-%E5%B8%83%E5%B1%80%E6%A0%B7%E5%BC%8F)

[8. Bug 追踪](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#8-bug-%E8%BF%BD%E8%B8%AA)

[9. Mac 常用](https://github.com/xiaoxidong/Awesome-Library-For-SwiftUI-Beginners/blob/main/README.md#9-mac-%E5%B8%B8%E7%94%A8)

# 1. 数据存储
<details>
<summary>1. Keychain</summary>

### 简介
如果我们希望保存一些数据，在用户删除应用之后依然可以保存在设备上，我们可以选择 Keychain，比如我们的应用会保存用户的下载时间，比如有些应用会提示一个新下载的用户上次登陆的账号，这些信息都可以保存在 Keychain 里，即使用户删除设备之后，信息依然存在。

需要注意的时候，只能保存一些简单的数据。

### 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

### 基础使用
- 保存一个字符串
```swift
let keychain = Keychain(service: "com.example.github-token")
keychain["kishikawakatsumi"] = "01234567-89ab-cdef-0123-456789abcdef"
```

- 保存 Data 数据
```swift
keychain[data: "secret"] = NSData(contentsOfFile: "secret.bin")
```

- 获取数据
```swift
let token = keychain["kishikawakatsumi"]
let token = keychain[string: "kishikawakatsumi"]
let secretData = keychain[data: "secret"]
```
需要注意获取到的可能为 nil 需要处理判断。

- 删除数据
```swift
keychain["kishikawakatsumi"] = nil
```
```swift
do {
    try keychain.remove("kishikawakatsumi")
} catch let error {
    print("error: \(error)")
}
```

还有一些其他的操作，可以查看链接。

</details>

<details>
<summary>2. Defaults</summary>

### 简介
当我们希望存储一些用户基础数据的时候，比如是否查看了某个新手引导，我们可以选择将数据存储在 UserDefaults 里，这里的数据会随着用户删除应用的时候被删除，同样也只能存储一些小量的数据。

UserDefaults 的另外一个很重要的作用是多 Target 的数据同步，比如小组件，Apple 并没有提供一个直接的数据交流，我们可以通过 UserDefaults 来传递小组件需要的数据，具体的内容可以查看我们应用里的小组件章节。

### 链接
Defaults 是一个开源的 UserDefaults 第三方库，可以更加简单的便捷的设置数据存储和读取。

[Defaults](https://github.com/sindresorhus/Defaults)

### 基础使用
- 自定义存储的 Key 类型
```swift
import Defaults

extension Defaults.Keys {
	static let quality = Key<Double>("quality", default: 0.8)
	//            ^            ^         ^                ^
	//           Key          Type   UserDefaults name   Default value
}
```
- 存储数据
```swift
Defaults[.quality]
//=> 0.8

Defaults[.quality] = 0.5
//=> 0.5

Defaults[.quality] += 0.1
//=> 0.6

Defaults[.quality] = "🦄"
//=> [Cannot assign value of type 'String' to type 'Double']
```

- 读取数据
```swift
extension Defaults.Keys {
	static let name = Key<Double?>("name")
}

if let name = Defaults[.name] {
	print(name)
}
```

- 对 SwiftUI 的支持
```swift
extension Defaults.Keys {
	static let showAllDayEvents = Key<Bool>("showAllDayEvents", default: false)
}

struct ShowAllDayEventsSetting: View {
	var body: some View {
		Defaults.Toggle("Show All-Day Events", key: .showAllDayEvents)
	}
}
```

更多的内容，可以查看 Github 链接。

- 支持 Group
当我们的应用支持 Group 的时候，比如小组件里，我们也可以设置存储在 Group 里，关于 Group 具体可以查看我们的应用里的章节。
```swift
let extensionDefaults = UserDefaults(suiteName: "com.unicorn.app")!

extension Defaults.Keys {
	static let isUnicorn = Key<Bool>("isUnicorn", default: true, suite: extensionDefaults)
}

Defaults[.isUnicorn]
//=> true

// Or

extensionDefaults[.isUnicorn]
//=> true
```

suiteName 即为我们设置的 Group 名称。

</details>

# 2. 浮层
<details>
<summary>1. SlideOverCard</summary>

### 简介
这个是我们最常用的底部出现的浮层样式设置，我们做了一些简单的修改。

### 链接
[SlideOverCard](https://github.com/kishikawakatsumi/KeychainAccess)

### 基础使用
```swift
.bottomSlideOverCard(isPresented: $elementVM.newViewShowWechat) {
    WeiChatView(wechat: $elementVM.newViewShowWechat) { }
}
```
</details>

<details>
<summary>2. BottomSheet</summary>

### 简介
在我们的做个应用来，iPhone 上底部的预览窗口，使用的开源库是 BottomSheet，效果也比较好。

### 链接
[BottomSheet](https://github.com/lucaszischka/BottomSheet)

### 基础使用
```swift
.bottomSheet(
    bottomSheetPosition: Binding<BottomSheetPosition>,
    switchablePositions: [BottomSheetPosition],
    title: String?,
    content: () -> MContent
)
```
</details>

<details>
<summary>3. SwiftUIOverlayContainer</summary>

### 简介
肘子老师开源的浮层库，样式比较多，且可以在任意地方直接打开，不需要像我们之前一样，需要使用 Bool 值来控制打开，方便很多。

### 链接
[SwiftUIOverlayContainer](https://github.com/fatbobman/SwiftUIOverlayContainer)

### 基础使用
```swift
struct ContentView1: View {
    @Environment(\.overlayContainerManager) var manager
    var body: some View {
        VStack {
            Button("push view in containerB") {
                manager.show(view: MessageView(), in: "containerB", using: ViewConfiguration())
            }
        }
    }
}
```
</details>

# 3. Toast
<details>
<summary>1. AlertToast</summary>

### 简介
在我们的各个应用来，这个开源库是最推荐使用的，你在提示里看到的中间显示的背景模糊样式的就是，样式精美且可以自定义内容。

### 链接
[AlertToast](https://github.com/elai950/AlertToast)

### 基础使用
- 直接使用
```swift
import AlertToast
import SwiftUI

struct ContentView: View{

    @State private var showToast = false

    var body: some View{
        VStack{

            Button("Show Toast"){
                 showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast){

            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: "Message Sent!")

            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")

            //Choose .banner to slide/pop alert from the bottom of the screen
            //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
        }
    }
}
```

- Toast 事件

```swift
.toast(isPresenting: $showAlert, duration: 2, tapToDismiss: true, alert: {
   //AlertToast goes here
}, onTap: {
   //onTap would call either if `tapToDismis` is true/false
   //If tapToDismiss is true, onTap would call and then dismis the alert
}, completion: {
   //Completion block after dismiss
})
```

- Toast 样式
```swift
AlertToast(displayMode: DisplayMode,
           type: AlertType,
           title: Optional(String),
           subTitle: Optional(String),
           style: Optional(AlertStyle))

//This is the available customizations parameters:
AlertStyle(backgroundColor: Color?,
            titleColor: Color?,
            subTitleColor: Color?,
            titleFont: Font?,
            subTitleFont: Font?)
```

</details>

# 4. 日期
<details>
<summary>1. SwiftDate</summary>

### 简介
日期在应用开发里是一个相对比较繁琐的内容，我们获取的时间是 0 时区的时间，要转换为当地时区的时间进行显示和操作，SwiftDate 提供了一些关于日期常用的操作，可以大大简化我们对 Date 的操作，对于新手比较有用。

### 链接
[SwiftDate](https://github.com/malcommac/SwiftDate)

### 基础使用
- 转化为日期
- ```swift
// All default datetime formats (15+) are recognized automatically
let _ = "2010-05-20 15:30:00".toDate()
// You can also provide your own format!
let _ = "2010-05-20 15:30".toDate("yyyy-MM-dd HH:mm")
// All ISO8601 variants are supported too with timezone parsing!
let _ = "2017-09-17T11:59:29+02:00".toISODate()
// RSS, Extended, HTTP, SQL, .NET and all the major variants are supported!
let _ = "19 Nov 2015 22:20:40 +0100".toRSS(alt: true)
```

- 日期计算
```swift
// Math operations support time units
let _ = ("2010-05-20 15:30:00".toDate() + 3.months - 2.days)
let _ = Date() + 3.hours
let _ = date1 + [.year:1, .month:2, .hour:5]
let _ = date1 + date2
// extract single time unit components from date manipulation
let over1Year = (date3 - date2).year > 1
```

- 日期比较
```swift
// Standard math comparison is allowed
let _ = dateA >= dateB || dateC < dateB

// Complex comparisons includes granularity support
let _ = dateA.compare(toDate: dateB, granularity: .hour) == .orderedSame
let _ = dateA.isAfterDate(dateB, orEqual: true, granularity: .month) // > until month granularity
let _ = dateC.isInRange(date: dateA, and: dateB, orEqual: true, granularity: .day) // > until day granularity
let _ = dateA.earlierDate(dateB) // earlier date
let _ = dateA.laterDate(dateB) // later date

// Check if date is close to another with a given precision
let _ = dateA.compareCloseTo(dateB, precision: 1.hours.timeInterval

// Compare for relevant events:
// .isToday, .isYesterday, .isTomorrow, .isWeekend, isNextWeek
// .isSameDay, .isMorning, .isWeekday ...
let _ = date.compare(.isToday)
let _ = date.compare(.isNight)
let _ = date.compare(.isNextWeek)
let _ = date.compare(.isThisMonth)
let _ = date.compare(.startOfWeek)
let _ = date.compare(.isNextYear)
// ...and MORE THAN 30 OTHER COMPARISONS BUILT IN

// Operation in arrays (oldestIn, newestIn, sortedByNewest, sortedByOldest...)
let _ = DateInRegion.oldestIn(list: datesArray)
let _ = DateInRegion.sortedByNewest(list: datesArray)
```

更多的操作可以查看 [Github](https://github.com/malcommac/SwiftDate) 说明文档。

</details>

# 5. 网络请求
<details>
<summary>1. Alamofire</summary>

### 简介
Alamofire 是一个老牌的网络请求开源库，比较稳定易用。在我们的开源项目 [Shoots](https://github.com/xiaoxidong/Shoots) 里我们使用了这个库来进行网络请求数据。

### 链接
[Alamofire](https://github.com/Alamofire/Alamofire)

### 基础使用
- 下面的代码是我们使用 Alamofire 来请求应用商店，根据应用的 ID 来获取应用的 Icon 图片。
```swift
func logo(app: AppInfo, _ success: @escaping (String?) -> Void) async {
    if let id = app.appStoreId {
        if !apps.contains(app) {}
        AF.request("https://itunes.apple.com/us/lookup?id=\(id)", method: .get, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseDecodable(of: AppDetailInfo.self) { response in
            switch response.result {
            case let .success(object):
                success(object.results.first?.artworkUrl512)
            case let .failure(error):
                print(error)
            }
        }
    } else {
        success(nil)
    }
}
```
</details>

<details>
<summary>2. Kingfisher</summary>

### 简介
很多时候我们需要根据 URL 来请求网络图片显示，Kingfisher 是喵神开源的一个图片请求的第三方库。

### 链接
[Kingfisher](https://github.com/onevcat/Kingfisher)

### 基础使用
- 直接使用
```swift
var body: some View {
    KFImage(URL(string: "https://example.com/image.png")!)
}
```

- 更多的设置选择
```swift
struct ContentView: View {
    var body: some View {
        KFImage.url(url)
          .placeholder(placeholderImage)
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .lowDataModeSource(.network(lowResolutionURL))
          .onProgress { receivedSize, totalSize in  }
          .onSuccess { result in  }
          .onFailure { error in }
    }
}
```
</details>

<summary>3. SDWebImageSwiftUI</summary>

### 简介
另外一个网络图片请求的开源库是 SDWebImageSwiftUI，在我们的开源项目 [Shoots](https://github.com/xiaoxidong/Shoots) 里我们使用了这个库来进行图片的网络请求显示。

### 链接
[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)

### 基础使用
```swift
var body: some View {
    WebImage(url: URL(string: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic")) { image in
        image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
    } placeholder: {
            Rectangle().foregroundColor(.gray)
    }
    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
    .onSuccess { image, data, cacheType in
        // Success
        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
    }
    .indicator(.activity) // Activity Indicator
    .transition(.fade(duration: 0.5)) // Fade Transition with duration
    .scaledToFit()
    .frame(width: 300, height: 300, alignment: .center)
}
```
</details>


# 6. Markdown
<details>
<summary>1. Parma</summary>

### 简介
在我们的 SwiftUI 应用里，我们显示的内容都是 Markdown 文件，其中用到的 Markdown 解析使用的是 Parma 这个开源库。

### 链接
[Parma](https://github.com/dasautoooo/Parma)

### 基础使用
- 解析内容
```swift
import Parma

struct ContentView: View {
    var markdown = "I'm **Strong**."

    var body: some View {
        Parma(markdown, render: MyRender())
    }
}

struct MyRender: ParmaRenderable {
    ...
}
```
- 自定义样式
```swift
/// Define the heading text style.
/// - Parameters:
///   - level: The level of heading.
///   - textView: The textView generated from captured heading string.
func heading(level: HeadingLevel?, textView: Text) -> Text

/// Define the paragraph text style.
/// - Parameter text: The text string captured from paragraph.
func paragraph(text: String) -> Text

/// Define the text style for plain text. Do NOT recommend to alter this if there's no special purpose.
/// - Parameter text: The text string captured from markdown.
func plainText(_ text: String) -> Text

/// Define the strong text style.
/// - Parameter textView: The textView generated from captured strong string.
func strong(textView: Text) -> Text

/// Define the emphasis text style.
/// - Parameter textView: The textView generated from captured emphasis string.
func emphasis(textView: Text) -> Text

/// Define the link text style.
/// - Parameters:
///   - textView: The textView generated from captured link string.
///   - destination: The destination of the link.
func link(textView: Text, destination: String?) -> Text

/// Define the code text style.
/// - Parameter text: The text string captured from code.
func code(_ text: String) -> Text

/// Define the style of heading view.
/// - Parameters:
///   - level: The level of heading.
///   - view: The view contains heading text.
func headingBlock(level: HeadingLevel?, view: AnyView) -> AnyView

/// Define the style of paragraph view.
/// - Parameter view: The view contains view(s) which belong(s) to this paragraph.
func paragraphBlock(view: AnyView) -> AnyView

/// Define the style of list item.
/// - Parameter attributes: Attributes of the list containing the item. Those must be considered for proper item rendering.
/// - Parameter index: Normalized index of the list item. For exemple, the index of the third item of a one level list would be `[2]` and the second item of a sublist appearing fourth in it's parent list would be `[3, 1]`.
/// - Parameter view: The view contains view(s) which belong(s) to this item.
func listItem(attributes: ListAttributes, index: [Int], view: AnyView) -> AnyView

/// Define the style of image view.
/// - Parameter urlString: The url string for this image view.
/// - Parameter altTextView: The view contains alt text.
func imageView(with urlString: String, altTextView: AnyView?) -> AnyView
```

- 我们使用的样式
在我们的做个应用里，样式上做了很多的修改，包括支持本地图片的显示等，后续我们整理好之后会开源出来。

</details>


# 7. 布局样式
<details>
<summary>1. Keychain</summary>

### 简介

### 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

### 基础使用

</details>


# 8. Bug 追踪
<details>
<summary>1. Bugsnag</summary>

### 简介
当我们的应用上线之后，我们需要添加 Bug 的追踪服务来检测是否有问题，现在我们整个在用的是 Bugsnag，免费的情况够用，且操作相对简单。

### 链接
[Bugsnag](https://app.bugsnag.com/)

### 基础使用
- 直接注册账号，按照用户添加相关的内容即可。
- 上传 dSYMs，否则无法显示出是哪行代码出现问题。在我们打包成功之后，可以选择应用，右键在文件夹显示，右键文件显示包内容，在里面会看到 dSYMs 文件；
- 在 Terminal 这个文件里，输入 bugsnag-dsym-upload 然后将 dSYMs 文件拖拽到 Terminal 里，回车上传。
</details>



# 9. Mac 常用
<details>
<summary>1. StatusBar 应用下拉关闭</summary>

### 简介

MenuBarExtra 可以帮助我们在状态栏里设置一个应用的入口，但是现在 SwiftUI 暂时没有提供一个可以自动关闭状态栏下拉的方法，之后点击外部区域隐藏下拉应用，很多时候我们希望在下拉里点击操作之后直接自动关闭，因此我们可以使用下面的方法来控制状态栏应用的显示和隐藏。


### 链接
[MenuBarExtraAccess](https://github.com/orchetect/MenuBarExtraAccess)

### 基础使用
- 下拉 Menu 样式
```swift
@main struct MyApp: App {
    @State var isMenuPresented: Bool = false

    var body: some Scene {
        WindowGroup {
            Button("Show Menu") { isMenuPresented = true }
        }

        MenuBarExtra("MyApp Menu", systemImage: "folder") {
            Button("Menu Item 1") { print("Menu Item 1") }
            Button("Menu Item 2") { print("Menu Item 2") }
        }
        .menuBarExtraStyle(.menu)
        .menuBarExtraAccess(isPresented: $isMenuPresented) { statusItem in // <-- the magic ✨
             // access status item or store it in a @State var
        }
    }
}
```

- Window 样式
```swift
@main struct MyApp: App {
    @State var isMenuPresented: Bool = false

    var body: some Scene {
        MenuBarExtra("MyApp Menu", systemImage: "folder") {
            MyMenu(isMenuPresented: $isMenuPresented)
            	.introspectMenuBarExtraWindow { window in // <-- the magic ✨
                    window.animationBehavior = .alertPanel
                }
        }
        .menuBarExtraStyle(.window)
        .menuBarExtraAccess(isPresented: $isMenuPresented) { statusItem in // <-- the magic ✨
             // access status item or store it in a @State var
        }
    }
}

struct MyMenu: View {
    @Binding var isMenuPresented: Bool

    var body: some View {
        Button("Perform Action") {
            isMenuPresented = false
            performSomeAction()
        }
    }
}
```
- 多个入口
```swift
var body: some Scene {
    MenuBarExtra("MyApp Menu A", systemImage: "folder") {
        MyMenu(isMenuPresented: $isMenuPresented)
            .introspectMenuBarExtraWindow(index: 0) { window in // <-- add index 0
                // ...
            }
    }
    .menuBarExtraStyle(.window)
    .menuBarExtraAccess(index: 0, isPresented: $isMenuPresented) // <-- add index 0

    MenuBarExtra("MyApp Menu B", systemImage: "folder") {
        MyMenu(isMenuPresented: $isMenuPresented)
            .introspectMenuBarExtraWindow(index: 1) { window in // <-- add index 1
                // ...
            }
    }
    .menuBarExtraStyle(.window)
    .menuBarExtraAccess(index: 1, isPresented: $isMenuPresented) // <-- add index 1
}
```
</details>


<details>

<summary>2. 开机启动</summary>

### 简介

在 Mac 应用里一个很常用的设计是开机启动，当用户开机之后，我们的应用程序自动启动，可以使用 LaunchAtLogin 来进行设置。


### 链接
[LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin)

### 基础使用

- 检测是否开启和设置开启
```swift
import LaunchAtLogin

print(LaunchAtLogin.isEnabled)
//=> false

LaunchAtLogin.isEnabled = true

print(LaunchAtLogin.isEnabled)
//=> true
```

- SwiftUI 里使用
```swift
struct ContentView: View {
	var body: some View {
		LaunchAtLogin.Toggle {
			Text("Launch at login")
		}
	}
}
```

- 自定义设置
```swift
import SwiftUI
import LaunchAtLogin

struct ContentView: View {
	@ObservedObject private var launchAtLogin = LaunchAtLogin.observable

	var body: some View {
		Toggle("Launch at login", isOn: $launchAtLogin.isEnabled)
	}
}
```

</details>

<summary>3. 设置全局快捷键</summary>

### 简介

在 Mac 应用里我们会经常需要设置一些全局的快捷键，即使用户不处于当前应用的时候也可以打开应用，比如我们的应用里，可以在任何时候使用 Shift + Command + F 打开应用内的搜索框，进行搜索。我们可以使用 MASShortcut 这个开源库来设置我们应用的全局快捷键。


### 链接
[MASShortcut](https://github.com/cocoabits/MASShortcut)

### 基础使用
在我们的应用初始化的时候，调用下的方法。
```swift
private func configureShortcuts() {
    // 打开通知内容
    let push = MASShortcut(keyCode: kVK_ANSI_P, modifierFlags: [.command, .shift])

    MASShortcutMonitor.shared().register(push, withAction: {
        // 快捷键触发操作
    })
}
```swift
- kVK_ANSI_P 是我们触发的键，只需要修改后面的 P 即可，上面代码是使用 Command + Shift + P 触发快捷操作。

</details>
