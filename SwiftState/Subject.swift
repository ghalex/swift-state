import Foundation

public typealias Observer<T> = (_ value: T?) -> Void

public class Subject<T> {
    var observers: [Observer<T>] = []
    
    public func notifyObservers(with data: T?) {
        for observer in observers {
            observer(data)
        }
    }
    
    public func subscribe(_ observer: @escaping Observer<T> ) {
        self.observers.append(observer)
    }
}
