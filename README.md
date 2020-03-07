# UIButton Extension – UIActivityIndicatorView 

A very simple library that provides a `UIButton` extension that enables use of `UIActivityIndicatorView` that replaces the title when enabled.

To enable the activity indicator it is as simple as the following

```swift
let button = UIButton()

button.activityIndicatorEnabled = true
```

You may also access the `UIActivityIndicatorView` to customise it under the read-only `activityIndicatorView` property.

