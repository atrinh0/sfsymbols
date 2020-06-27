<p align="center"><img src="images/sfsymbols-logo.png"></p>

<p align="center">
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/Xcode-12.0+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" />
    <img src="https://img.shields.io/badge/SF Symbols (last exported)-Version 2.0 (34) beta-lightgray.svg" />
</p>
 
 
<h1>SF Symbols (SwiftUI App)</h1>
> Experimenting with SwiftUI whilst creating a practical app to browse the SF Symbols via an iOS/iPadOS app.

### Grid
<img src="images/grid.png" width="60%">

### Filter
<img src="images/filter.png" width="60%">

### Show only multicolored symbols
<img src="images/colors.png" width="60%">
<img src="images/colors2.png" width="60%">

### Enlarge
<img src="images/enlarge.png" width="60%">


### Known issues

**Limited support**

According to an Apple Frameworks Engineer, multicolor symbols are not supported on iOS yet.
[https://developer.apple.com/forums/thread/651671?answerId=616617022#616617022](https://developer.apple.com/forums/thread/651671?answerId=616617022#616617022)

**Dynamic text sizing affects colors**

<img src="images/bug.gif" width="60%">

**First enlarge is empty**

Tapping a symbol to enlarge is not working for the very first time.

**Multicolor symbols appear fuzzy**

Altering the symbols via `font` or `resizable` loses the colors, `scaleEffect` is used for now until there is official support for iOS.


### Disclaimer

> This is posted as a way to share SwiftUI learnings (and is not production level code). Use it at your own risk.

> It is your responsibility to make sure you are following the terms and conditions of using Apple's symbols. For more information, see [https://developer.apple.com/sf-symbols/](https://developer.apple.com/sf-symbols/). Read the Human Interface Guidelines to learn how to make the most of SF Symbols, [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/).
