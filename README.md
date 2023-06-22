# MyLibrary

## 概要
SwiftUIアプリ開発で頻繁に使うコードをパッケージにまとめました。
自分用なので中身は少ない。

## 最小対応OS
- iOS 13.0
- macOS 11.0
- tvOS 13.0
- watchOS 6.0
- visionOS(xrOS) 1.0

## 内容
### AppDelegate (macOS)
- 最後のウインドウが閉じられた時アプリを終了する
### PresentedWindowManager (macOS)
- NSWindowを取得する
### VisualEffectView (macOS)
- ウインドウの背景をぼかす
### RoundedIconLabelStyle
- 設定アプリ風のラベルテンプレート
### ColorProgressView
- withAnimationを用いた読み込みインジケータ
### @Preserve
- UserDefaults、FileManagerを用いたデータ永続化をPropertyWrapperにまとめた
