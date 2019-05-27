import Foundation

public typealias UseCallback<Args, Payload, Error> = (_ args: Args?, _ done:  @escaping (_ payload: Payload?) -> Void, _ fail:  @escaping (_ err: Error?) -> Void) -> Void

public class Effect<Args, Payload, Error> {
    private var name: String
    private var use: UseCallback<Args, Payload, Error>?
    public let done: Event<Payload>
    public let fail: Event<Error>
    
    public init(name: String) {
        self.name = name
        self.done = Event<Payload>(name: name + " done")
        self.fail = Event<Error>(name: name + " fail")
    }
    
    public func use(callback: @escaping UseCallback<Args, Payload, Error>) {
        self.use = callback
    }
    
    public func run(_ args: Args? = nil) {
        if let use = self.use {
            use(
                args,
                { [weak self] payload in
                    self?.done.run(payload)
                },
                { [weak self] error in
                    self?.fail.run(error)
                }
            )
        }
    }
}
