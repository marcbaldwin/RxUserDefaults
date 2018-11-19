import Foundation

extension UserDefaults {

    public func bool(key: String, defaultValue: Bool) -> Default<Bool> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.bool(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func double(key: String, defaultValue: Double) -> Default<Double> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.double(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func int(key: String, defaultValue: Int) -> Default<Int> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.integer(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func string(key: String, defaultValue: String?) -> Default<String?> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.string(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func type<T>(key: String, defaultValue: T, encode: @escaping (T) -> String, decode: @escaping (String) -> T) -> Default<T> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in
                decode(userDefaults.string(forKey: key)!)
            },
            setter: { userDefaults, key, value in
                userDefaults.set(encode(value), forKey: key)
            }
        )
    }

    public func type<T>(key: String, defaultValue: T?, encode: @escaping (T?) -> String?, decode: @escaping (String?) -> T?) -> Default<T?> {
        return Default(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in
                decode(userDefaults.string(forKey: key)!)
            },
            setter: { userDefaults, key, value in
                userDefaults.set(encode(value), forKey: key)
            }
        )
    }
}
