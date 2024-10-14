import Foundation

public protocol EventEncodable: Event {
    static var name: String { get }
    func encode() throws -> [AnyHashable : Any]?
}

public extension EventEncodable where Self: Encodable {
    func encode() throws -> [AnyHashable : Any]? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [AnyHashable : Any]
    }
}
