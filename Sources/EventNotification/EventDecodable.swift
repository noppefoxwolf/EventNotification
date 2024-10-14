import Foundation

public protocol EventDecodable: Event {
    init(userInfo: [AnyHashable : Any]?) throws
}

public extension EventDecodable where Self: Decodable {
    init(userInfo: [AnyHashable : Any]?) throws {
        let jsonObject = userInfo
        let isValidJSONObject = JSONSerialization.isValidJSONObject(jsonObject as Any)
        let validJSONObject = isValidJSONObject ? jsonObject : [:]
        let data = try JSONSerialization.data(withJSONObject: validJSONObject as Any)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Self.self, from: data)
        self = entity
    }
}
