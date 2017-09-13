# SwiftHUD
HUD Tip Label  For Swift

### Preview

![](https://github.com/15038777234/SwiftHUD/blob/master/111.gif)

### Install

1. Down This Demo,Dray SwiftHUD File to your project

2. use Cocoapods 

   ```ruby
   pod 'ZSwiftHUD'
   ```

### Show

* Show Default Text

```swift
SwiftHUD.show()
```

* Show Custom Text

```swift
SwiftHUD.show("Show Custom Text")
```

* Show Long Lenght Custom Text

```swift
SwiftHUD.show("Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text")
```

* Show Custom Text In Custom View

```swift
SwiftHUD.show("Show Custom Text In Custom View", view: self.view)
```

* Show Default Text Loading Style

```swift
SwiftHUD.show("Show Default Text Loading Style", view: self.view, style: SwiftHUDStyle.Loading)
```

* Show Default Text Error Style

```swift
SwiftHUD.show("Show Default Text Error Style", view: self.view, style: SwiftHUDStyle.Error)
```

* Show Default Text Success Style

```swift
SwiftHUD.show("Show Default Text Success Style", view: self.view, style: SwiftHUDStyle.Success)
```

* Show Default Text Info Style

```swift
SwiftHUD.show("Show Default Text Info Style", view: self.view, style: SwiftHUDStyle.Info)
```

* Show Default Text After Dismiss Complete

```swift
SwiftHUD.show("Show Default Text After Complete", view: self.view, style: SwiftHUDStyle.None, after: 2, complete: { (hud) in
                UIAlertView(title: "This is Alert", message: nil, delegate: nil, cancelButtonTitle: "OK").show()

            })

```

### Hide

* Hide No Text

```swift
self.hud?.hide()
```

* Hide Show Text After Dismiss Default

```swift
 self.hud?.hide("Hide Show Text After Dismiss Default ")
```

* Hide Show Text After Dismiss Custom 3 second

```swift
self.hud?.hide("Hide Show Text After Dismiss Custom 3 second", after: 3)
```

* Hide Show Text After Dismiss Custom 3 second After Complete

```swift
self.hud?.hide("Hide Show Text After Dismiss Custom 3 second After Complete", after: 3, complete: { (hud) in
                UIAlertView(title: "This is Alert", message: nil, delegate: nil, cancelButtonTitle: "OK").show()
            })
```
