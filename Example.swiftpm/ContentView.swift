import SwiftUI
import EventNotification

struct ContentView: View {
    
    @State
    var text: String = ""
    
    @State
    var notificationCenter = NotificationCenter.default
    
    var body: some View {
        VStack {
            TextField("text", text: $text)
            Button {
                try! notificationCenter.post(CustomEvent(date: .now))
            } label: {
                Text("Post Event")
            }

        }
        .task {
            for await event in notificationCenter.publisher(type: KeyboardWillShowEvent.self).values {
                print(event)
            }
        }
        .task {
            for await event in notificationCenter.publisher(type: CustomEvent.self).values {
                print(event)
            }
        }
    }
}

struct CustomEvent: EventCodable, Codable {
    let date: Date
}

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
