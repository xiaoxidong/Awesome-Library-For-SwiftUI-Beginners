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

## 简介
当我们希望存储一些用户基础数据的时候，比如是否查看了某个新手引导，我们可以选择将数据存储在 UserDefaults 里，这里的数据会随着用户删除应用的时候被删除，同样也只能存储一些小量的数据。

UserDefaults 的另外一个很重要的作用是多 Target 的数据同步，比如小组件，Apple 并没有提供一个直接的数据交流，我们可以通过 UserDefaults 来传递小组件需要的数据，具体的内容可以查看我们应用里的小组件章节。

## 链接
Defaults 是一个开源的 UserDefaults 第三方库，可以更加简单的便捷的设置数据存储和读取。

[Defaults](https://github.com/sindresorhus/Defaults)

## 基础使用
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
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>


# 3. Toast
<details>
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>

# 4. 日期
<details>
<summary>1. SwiftDate</summary>

## 简介
日期在应用开发里是一个相对比较繁琐的内容，我们获取的时间是 0 时区的时间，要转换为当地时区的时间进行显示和操作，SwiftDate 提供了一些关于日期常用的操作，可以大大简化我们对 Date 的操作，对于新手比较有用。

## 链接
[SwiftDate](https://github.com/malcommac/SwiftDate)

## 基础使用
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
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>


# 6. Markdown
<details>
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>


# 7. 布局样式
<details>
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>


# 8. Bug 追踪
<details>
<summary>1. Bugsnag</summary>

## 简介
当我们的应用上线之后

## 链接
[Bugsnag](https://app.bugsnag.com/)

## 基础使用

</details>



# 9. Mac 常用
<details>
<summary>1. Keychain</summary>

## 简介

## 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

## 基础使用

</details>
