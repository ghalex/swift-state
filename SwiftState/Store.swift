import Foundation

public typealias Reducer<State, Payload> = (_ state: State, _ playload: Payload?) -> State

public class Store<State> {
    
    private var state: State
    private var subject = Subject<State>()
    
    init(initialState: State) {
        self.state = initialState
    }
    
    public func watch(_ observer: @escaping Observer<State> ) {
        self.subject.subscribe(observer)
    }
    
    public func on<Payload>(_ event: Event<Payload>, reducer: @escaping Reducer<State, Payload>) {
        event.watch { [weak self] (payload: Payload?) in
            if let state = self?.state {
                let newState = reducer(state, payload)
                
                self?.state = newState
                self?.subject.notifyObservers(with: newState)
            }
        }
    }
    
    public func getState() -> State {
        return self.state
    }
}
