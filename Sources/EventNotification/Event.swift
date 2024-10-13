import Foundation

public protocol Event {
    static var name: String { get }
}

public extension Event {
    static var name: String { "\(type(of: Self.self))" }
}

public protocol EventDecodable: Event {
    init(userInfo: [AnyHashable : Any]?) throws
}

public protocol EventEncodable: Event {
    static var name: String { get }
    func encode() throws -> [AnyHashable : Any]?
}

public typealias EventCodable = EventEncodable & EventDecodable

public extension EventDecodable where Self: Decodable {
    init(userInfo: [AnyHashable : Any]?) throws {
        let data = try JSONSerialization.data(withJSONObject: userInfo as Any)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Self.self, from: data)
        self = entity
    }
}

public extension EventEncodable where Self: Encodable {
    func encode() throws -> [AnyHashable : Any]? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [AnyHashable : Any]
    }
}
