extension UserDefaults {

    public func bool(key: String, defaultValue: Bool) -> Default<Bool> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.bool(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func double(key: String, defaultValue: Double) -> Default<Double> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.double(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func int(key: String, defaultValue: Int) -> Default<Int> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.integer(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func string(key: String, defaultValue: String?) -> Default<String?> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.string(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func date(key: String, defaultValue: Date?) -> Default<Date?> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.object(forKey: key) as? Date },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func stringArray(key: String, defaultValue: [String]) -> Default<[String]> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.object(forKey: key) as? [String] ?? [] },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func type<T>(key: String, defaultValue: T, encode: @escaping (T) -> String, decode: @escaping (String) -> T) -> Default<T> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in
                decode(userDefaults.string(forKey: key)!)
            },
            setter: { userDefaults, key, value in
                userDefaults.set(encode(value), forKey: key)
            }
        )
    }

    public func type<T>(key: String, defaultValue: T, encode: @escaping (T) -> Int, decode: @escaping (Int) -> T) -> Default<T> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in
                decode(userDefaults.integer(forKey: key))
            },
            setter: { userDefaults, key, value in
                userDefaults.set(encode(value), forKey: key)
            }
        )
    }

    public func type<T>(key: String, defaultValue: T?, encode: @escaping (T?) -> String?, decode: @escaping (String?) -> T?) -> Default<T?> {
        return UserDefault(
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
