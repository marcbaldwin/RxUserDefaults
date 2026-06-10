import RxSwift

public class StubDefault<T>: Default<T> {

    override public var value: T {
        get { return try! valueSubject.value() }
        set { valueSubject.onNext(newValue) }
    }

    private let valueSubject: BehaviorSubject<T>
    private let defaultValue: T

    public init(key: String, value: T) {
        self.defaultValue = value
        self.valueSubject = BehaviorSubject(value: value)
        super.init(key: key)
    }

    override public func asObservable () -> Observable<T> {
        return valueSubject.asObservable()
    }

    override public func resetToDefault() {
        value = defaultValue
    }
}
