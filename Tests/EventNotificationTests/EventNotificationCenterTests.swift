import Testing
import Combine

@Suite
struct EventQueueTests {
    @Test
    func sinkした時点のイベントが取れる() async throws {
        let a = CurrentValueSubject<Int, Never>(1)
        a.send(2)
        var iterator = a.values.makeAsyncIterator()
        
        await #expect(iterator.next() == 2)
    }
}
