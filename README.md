> [!TIP]
> Did you know Apple introduced [`UIButton.Configuration`](https://developer.apple.com/documentation/uikit/uibutton/configuration) in iOS 15?
>
> Using the new Configuration API you can create a button like this library achieves. Simply set `showsActivityIndicator` to show the indicator. You can do this and more in the `configurationUpdateHandler`:
> ```swift
> let button = UIButton(configuration: .filled())
> 
> button.configurationUpdateHandler = { button in
>     var currentConfig = button.configuration
>     
>     if isLoading {
>         currentConfig?.baseBackgroundColor = .systemOrange
>         currentConfig?.title = nil
>     } else {
>         currentConfig?.baseBackgroundColor = .systemGreen
>         currentConfig?.title = "Click me!"
>     }
>     currentConfig?.buttonSize = .medium
>     currentConfig?.showsActivityIndicator = isLoading
>     
>     button.configuration = currentConfig
> }
> ```

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
