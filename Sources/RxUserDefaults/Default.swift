import RxSwift

public class Default<T> {

    public let key: String

    public var value: T {
        get { fatalError() }
        set { fatalError() }
    }

    public var hasValue: Bool { fatalError() }

    init(key: String) {
        self.key = key
    }

    public func asObservable() -> Observable<T> {
        fatalError()
    }

    public func resetToDefault() {
        fatalError()
    }
}
