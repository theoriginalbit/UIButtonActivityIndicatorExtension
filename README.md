# UIButton Extension – UIActivityIndicatorView 

A very simple library that provides a `UIButton` extension that enables use of `UIActivityIndicatorView` that replaces the title when enabled.

To enable the activity indicator it is as simple as the following

```swift
let button = UIButton()

button.activityIndicatorEnabled = true
```

You may also access the `UIActivityIndicatorView` to customise it under the read-only `activityIndicatorView` property.

### Default configuration

For iOS 12 and below the activity indicator will be initialized with the `UIActivityIndicatorView.Style.white` style. For iOS 13 and higher it will be initialized with the  `UIActivityIndicatorView.Style.medium` style.

Any time that `activityIndicatorEnabled` is set to `true` prior to display the activity indicator's color will be set to `activityIndicatorColor` – or `titleColor(for: .normal)` if that property is `nil`.
