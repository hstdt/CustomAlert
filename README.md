# CustomAlert

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FCustomAlert%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/divadretlaw/CustomAlert)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FCustomAlert%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/divadretlaw/CustomAlert)

## Why

In iOS Alerts cannot contain Images or anything other than Text. This allows you to easily customize the message part with any custom view.

While the alert is completely rebuilt in SwiftUI, it has been designed to look and behave exactly like a native alert. The alert uses it's own window to be displayed and utilizes accessibility scaling but with the advantage of a custom view.

If the content is too large because the text is too long or the text doesn't fit because of accessibility scaling the content will scroll just like in a SwiftUI Alert.

## Usage

| iOS | SwiftUI Alert | Custom Alert |
|:---:|:-------------:|:------------:|
| iOS 26+ | ![Native Alert](Sources/CustomAlert/Documentation.docc/Resources/SwiftUI_liquidGlass.png) | ![Custom Alert](Sources/CustomAlert/Documentation.docc/Resources/Custom_liquidGlass.png) |
| iOS 15 - iOS 18 | ![Native Alert](Sources/CustomAlert/Documentation.docc/Resources/SwiftUI_classic.png) | ![Custom Alert](Sources/CustomAlert/Documentation.docc/Resources/Custom_classic.png) |

On iOS 26, the default configuration is based on `CustomAlertConfiguration.liquidGlass` and on previous iOS versions `CustomAlertConfiguration.classic`.

You can easily add an Image or change the Font used in the alert, or anything else to your imagination.

Something simple with an image and a text field

<img src="Sources/CustomAlert/Documentation.docc/Resources/Fancy.png" width="300">

Or more complex layouts

<img src="Sources/CustomAlert/Documentation.docc/Resources/Complex.png" width="300">

The API is very similar to SwiftUI alerts. Model-driven presentation is recommended so the
alert is only presented after all of its content is available.

```swift
struct FancyAlert: Identifiable {
    let id = UUID()
    let message: String
}

@State private var fancyAlert: FancyAlert?

// Present only after the complete payload is ready.
fancyAlert = FancyAlert(message: "I'm a custom Message")

.customAlert("Some Fancy Alert", item: $fancyAlert) { alert in
    Text(alert.message)
        .font(.custom("Noteworthy", size: 24))
    Image(systemName: "swift")
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 100)
        .foregroundColor(.blue)
} actions: { _ in
    Button {
        // some Action
    } label: {
        Label("Swift", systemImage: "swift")
    }
    
    Button(role: .cancel) {
        // some Action
    } label: {
        Text("Cancel")
    }
}
```

You can create Side by Side Buttons using `ActionHStack`

```swift
.customAlert("Alert with Side by Side Buttons", item: $fancyAlert) { _ in
    Text("Choose left or right")
} actions: { _ in
    ActionHStack {
        Button {
            // some Action
        } label: {
            Text("Left")
        }

        Button {
            // some Action
        } label: {
            Text("Right")
        }
    }
}
```

The Boolean `isPresented:` overloads remain available for source compatibility, but are
deprecated. Use `item:` whenever the alert reads dynamic presentation data.

The alert is customizable via the `Environment`

<img src="Sources/CustomAlert/Documentation.docc/Resources/CustomConfiguration.png" width="300">

```swift
.configureCustomAlert { configuration in
    // Adapt the default configuration
}
```

You can also display an Alert inline, within a `List` for example

<img src="Sources/CustomAlert/Documentation.docc/Resources/InlineAlert.png" width="300">

```swift
CustomAlertRow {
    // Content
} actions: {
    // Actions
}
```

## Install

### SwiftPM

```
https://github.com/divadretlaw/CustomAlert.git
```

## License

See [LICENSE](LICENSE)
