import Foundation

public class Event<Payload> {
    private var name: String
    private var payload: Payload? = nil
    private var subject = Subject<Payload>()
    
    public init(name: String) {
        self.name = name
    }
    
    public func run(_ payload: Payload? = nil) {
        self.payload = payload
        self.subject.notifyObservers(with: self.payload)
    }
    
    public func watch(_ observer: @escaping Observer<Payload> ) {
        self.subject.subscribe(observer)
    }
}
