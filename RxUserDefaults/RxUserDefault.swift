import RxSwift

public final class Default<T>: ReactiveCompatible {

    public typealias Getter = (UserDefaults, String) -> T
    public typealias Setter = (UserDefaults, String, T) -> Void

    public let key: String

    public var value: T {
        get {
            return try! subject.value()
        }
        set {
            subject.onNext(newValue)
            setter(userDefaults, key, newValue)
        }
    }

    public var hasValue: Bool {
        return userDefaults.object(forKey: key) != nil
    }

    private let userDefaults: UserDefaults
    private let getter: Getter
    private let setter: Setter
    private let defaultValue: T
    private let subject: BehaviorSubject<T>

    public init(
        key: String,
        defaultValue: T,
        userDefaults: UserDefaults = UserDefaults.standard,
        getter: @escaping Getter,
        setter: @escaping Setter) {
        self.key = key
        self.userDefaults = userDefaults
        self.getter = getter
        self.setter = setter
        self.defaultValue = defaultValue
        self.subject = BehaviorSubject(value:
            userDefaults.object(forKey: key) != nil ? getter(userDefaults, key) : defaultValue
        )
    }

    public func asObservable() -> Observable<T> {
        return subject.asObservable()
    }

    public func resetToDefault() {
        value = defaultValue
    }
}
