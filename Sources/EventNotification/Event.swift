import Foundation

public protocol Event {
    static var name: String { get }
}

public extension Event {
    static var name: String { "\(type(of: Self.self))" }
}

public typealias EventCodable = EventEncodable & EventDecodable

