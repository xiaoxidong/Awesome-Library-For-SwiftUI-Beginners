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

# 简介
如果我们希望保存一些数据，在用户删除应用之后依然可以保存在设备上，我们可以选择 Keychain，比如我们的应用会保存用户的下载时间，比如有些应用会提示一个新下载的用户上次登陆的账号，这些信息都可以保存在 Keychain 里，即使用户删除设备之后，信息依然存在。

需要注意的时候，只能保存一些简单的数据。

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用
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
<summary>2. UserDefaults</summary>

  # 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>

# 2. 浮层
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>


# 3. Toast
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>

# 4. 日期
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>

# 5. 网络请求
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>


# 6. Markdown
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>


# 7. 布局样式
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>


# 8. Bug 追踪
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>



# 9. Mac 常用
<details>
<summary>1. Keychain</summary>

# 简介

# 链接
[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)

# 基础使用

</details>
