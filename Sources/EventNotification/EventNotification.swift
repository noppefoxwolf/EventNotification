import Foundation
import Combine

extension NotificationCenter {
    public func post<T: EventEncodable>(_ event: T, object: Any? = nil) throws {
        let name = Notification.Name(T.name)
        let userInfo = try event.encode()
        post(name: name, object: object, userInfo: userInfo)
    }
    
    public func publisher<T: EventDecodable>(type: T.Type = T.self, object: AnyObject? = nil) -> AnyPublisher<T, Never> {
        let name = Notification.Name(T.name)
        return publisher(for: name, object: object)
            .compactMap { try? T.init(userInfo: $0.userInfo) }
            .eraseToAnyPublisher()
    }

    @available(iOS 18.0, *)
    public func events<T: EventDecodable>(
        type: T.Type = T.self,
        object: (AnyObject & Sendable)? = nil
    ) -> some AsyncSequence<T, Never> {
        let name = Notification.Name(T.name)
        return notifications(named: name, object: object)
            .compactMap({ try? T.init(userInfo: $0.userInfo) })
    }
}

extension NotificationQueue {
    public func enqueu<T: EventEncodable>(
        _ event: T,
        object: Any? = nil,
        postingStyle: PostingStyle,
        coalesceMask: NotificationCoalescing = .none,
        forModes modes: [RunLoop.Mode]? = nil
    ) throws {
        let name = Notification.Name(T.name)
        let userInfo = try event.encode()
        let notification = Notification(name: name, object: object, userInfo: userInfo)
        enqueue(
            notification,
            postingStyle: postingStyle,
            coalesceMask: coalesceMask,
            forModes: modes
        )
    }
}
