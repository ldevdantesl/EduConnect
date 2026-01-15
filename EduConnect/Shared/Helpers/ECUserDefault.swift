//
//  ECUserDefaultHelper.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 14.01.2026.
//

import UIKit

struct ECUserDefaults {

    private static let defaults = UserDefaults.standard

    static func save<T: Encodable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }

    static func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    static func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
