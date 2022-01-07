import Foundation
import RxSwift
import RxCocoa

/// You need to maintain this object yourself. You can use the deallocWith(_:) funciton to bind its lifecycle with other object
public final class UserDefault<T>: Default<T> where T: Equatable {

    public typealias Getter = (UserDefaults, String) -> T
    public typealias Setter = (UserDefaults, String, T) -> Void

	public let subject: BehaviorSubject<T>
	
    override public var value: T {
        get {
            return try! subject.value()
        }
        set {
            subject.onNext(newValue)
        }
    }

    override public var hasValue: Bool {
        return userDefaults.object(forKey: key) != nil
    }

    private let userDefaults: UserDefaults
    private let getter: Getter
    private let setter: Setter
    private let defaultValue: T
	private let disposeBag = DisposeBag()

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
		setup()
    }
	
	private func setup() {
		userDefaults.rx.observe(T.self, key)
			.distinctUntilChanged()
			.map { [unowned self] newValue in newValue ?? defaultValue }
			.bind(onNext: { [unowned self] newValue in
				guard let oldValue = try? subject.value(), newValue != oldValue else { return }
				subject.onNext(newValue)
			})
			.disposed(by: disposeBag)
		subject
			.skip(1)
			.distinctUntilChanged()
			.subscribe(onNext: { [unowned self] newValue in
				guard !hasValue || newValue != getter(userDefaults, key) else { return }
				print("『UserDefault set』key:\(key) value:\(newValue)")
				setter(userDefaults, key, newValue)
			}).disposed(by: disposeBag)
	}
	
	public func asObserver() -> BehaviorSubject<T> {
		return subject
	}

    override public func asObservable() -> Observable<T> {
        return subject.asObservable()
    }

    override public func resetToDefault() {
        userDefaults.removeObject(forKey: key)
        subject.onNext(defaultValue)
    }
	
	/// Set this object as a property of "obj". This can help keep this object alive as the same as "obj".
	/// - Parameter obj: 对象
	/// - Returns: self
	public func deallocWith(_ obj: NSObject) -> Self {
		var array = [UserDefault]()
		if let oldArray = objc_getAssociatedObject(obj, &UserDefaultAssociatedArrayKey) as? [UserDefault] {
			array = oldArray
		}
		array.append(self)
		objc_setAssociatedObject(obj, &UserDefaultAssociatedArrayKey, array, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return self
	}
}

private var UserDefaultAssociatedArrayKey = ""
