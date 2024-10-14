import Testing
@testable import EventNotification

@Suite
struct DecodeTests {
    @Test
    func decodeNil() async throws {
        _ = try CustomEvent(userInfo: nil)
    }

    @Test
    func decodeEmpty() async throws {
        _ = try CustomEvent(userInfo: [:])
    }
    
    @Test
    func decodeCorruptedUserInfo() async throws {
        struct CorruptedData {}
        _ = try CustomEvent(userInfo: ["1" : CorruptedData()])
    }
    
    @Test
    func decodeNoisyData() async throws {
        _ = try CustomEvent(userInfo: ["data" : "0xff"])
    }
}

struct CustomEvent: EventCodable, Codable {}
