import Foundation

final class Observable<ObserberValue> {
    
    struct Observer<ObserberValue> {
        weak var observer: AnyObject?
        let block: (ObserberValue) -> Void
    }
    
    private var observers = [Observer<ObserberValue>]()
    
    var value: ObserberValue {
        didSet { notifyObservers() }
    }
    
    init(_ value: ObserberValue) {
        self.value = value
    }
    
    func observe(on observer: AnyObject, observerBlock: @escaping (ObserberValue) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.block(self.value)
        }
    }
}
