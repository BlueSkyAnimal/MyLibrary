//
//  PropertyWrapper.swift
//
//
//  Created by 千葉和義 on 2023/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public class Preserve {
    public enum Store {
        case userDefaults(UserDefaults = .standard)
        case fileManager(FileManager.SearchPathDirectory = .documentDirectory)
    }
    
    public static func save(_ value: Encodable, key name: String, to store: Store = .fileManager(.documentDirectory)) {
        guard let data = value.encoded() else { return }
        switch store {
            case .userDefaults(let store):
                store.set(data, forKey: name)
            case .fileManager(let directory):
                FileManager.save(name, data: data, directory: directory)
        }
    }
    
    public static func get<T: Codable>(key name: String, from store: Store = .fileManager(.documentDirectory)) -> T? {
        var data: Data? {
            switch store {
                case .userDefaults(let store):
                    store.data(forKey: name)
                case .fileManager(let directory):
                    FileManager.read(name, directory: directory)
            }
        }
        
        return data?.decoded(T.self)
    }
}
