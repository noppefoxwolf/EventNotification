@preconcurrency import Combine

public final class EventQueue<E: Event & Sendable>: Sendable {
    public init() {}

    let latestEvent = CurrentValueSubject<Optional<E>, Never>(.none)
    
    @available(iOS 18.0, *)
    public var events: some AsyncSequence<E, Never> {
        publisher().values
    }
    
    public func publisher() -> some Publisher<E, Never> {
        latestEvent.compactMap({ $0 }).share()
    }

    public func enqueue(_ event: E) {
        latestEvent.send(event)
    }
}

