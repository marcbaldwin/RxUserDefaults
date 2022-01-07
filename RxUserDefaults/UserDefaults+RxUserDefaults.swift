extension UserDefaults {

    public func bool(key: String, defaultValue: Bool) -> UserDefault<Bool> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.bool(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func double(key: String, defaultValue: Double) -> UserDefault<Double> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.double(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func int(key: String, defaultValue: Int) -> UserDefault<Int> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.integer(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func string(key: String, defaultValue: String?) -> UserDefault<String?> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.string(forKey: key) },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

    public func date(key: String, defaultValue: Date?) -> UserDefault<Date?> {
        return UserDefault(
            key: key, defaultValue: defaultValue, userDefaults: self,
            getter: { userDefaults, key in userDefaults.object(forKey: key) as? Date },
            setter: { userDefaults, key, value in userDefaults.set(value, forKey: key) }
        )
    }

	public func type<T>(key: String, defaultValue: T, encode: @escaping (T) -> String, decode: @escaping (String) -> T) -> UserDefault<T> where T: Equatable {
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

    public func type<T>(key: String, defaultValue: T, encode: @escaping (T) -> Int, decode: @escaping (Int) -> T) -> UserDefault<T> where T: Equatable {
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

    public func type<T>(key: String, defaultValue: T?, encode: @escaping (T?) -> String?, decode: @escaping (String?) -> T?) -> UserDefault<T?> where T: Equatable {
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
