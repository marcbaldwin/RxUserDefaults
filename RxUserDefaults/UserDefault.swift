import RxSwift

public final class UserDefault<T>: Default<T> {

    public typealias Getter = (UserDefaults, String) -> T
    public typealias Setter = (UserDefaults, String, T) -> Void

    override public var value: T {
        get {
            return try! subject.value()
        }
        set {
            subject.onNext(newValue)
            setter(userDefaults, key, newValue)
        }
    }

    override public var hasValue: Bool {
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
        setter: @escaping Setter
    ) {
        self.userDefaults = userDefaults
        self.getter = getter
        self.setter = setter
        self.defaultValue = defaultValue
        self.subject = BehaviorSubject(value:
            userDefaults.object(forKey: key) != nil ? getter(userDefaults, key) : defaultValue
        )
        super.init(key: key)
    }

    override public func asObservable() -> Observable<T> {
        return subject.asObservable()
    }

    override public func resetToDefault() {
        userDefaults.removeObject(forKey: key)
        subject.onNext(defaultValue)
    }
}
