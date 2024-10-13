# EventNotification

## Custom Event

### Define Event

```swift
struct CustomEvent: EventCodable, Codable {
    let date: Date
}
```

### Post Event

```swift
try! NotificationCenter.default.post(CustomEvent(date: .now))
```

### Subscribe

```swift
let publisher = NotificationCenter.default.publisher(type: CustomEvent.self)
for await event in publisher.values {
 // ...
}
```

## System Event (Manual Notification Decoding)

```swift
struct KeyboardWillShowEvent: EventDecodable, Sendable {
    static let name: String = UIResponder.keyboardWillShowNotification.rawValue
    let centerBegin: CGPoint
    let bounds: CGRect
    let animationDuration: Double
    let frameEnd: CGRect
    let animationCurve: Int
    let centerEnd: CGPoint
    let frameBegin: CGRect
    let isLocal: Int
    
    init(userInfo: [AnyHashable : Any]?) throws {
        centerBegin = userInfo!["UIKeyboardCenterBeginUserInfoKey"] as! CGPoint
        bounds = userInfo!["UIKeyboardBoundsUserInfoKey"] as! CGRect
        animationDuration = userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        frameEnd = userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        animationCurve = userInfo!["UIKeyboardAnimationCurveUserInfoKey"] as! Int
        centerEnd = userInfo!["UIKeyboardCenterEndUserInfoKey"] as! CGPoint
        frameBegin = userInfo!["UIKeyboardFrameBeginUserInfoKey"] as! CGRect
        isLocal = userInfo!["UIKeyboardIsLocalUserInfoKey"] as! Int
    }
}
```
