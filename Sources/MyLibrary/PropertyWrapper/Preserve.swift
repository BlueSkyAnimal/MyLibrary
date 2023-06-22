//
//  PropertyWrapper.swift
//
//
//  Created by 千葉和義 on 2023/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
@propertyWrapper
public struct Preserve<Value: Codable>: DynamicProperty {
    public enum Store {
        case userDefaults(UserDefaults = .standard)
        case fileManager(FileManager.SearchPathDirectory = .documentDirectory)
    }
    
    private let key: String
    private let defaultValue: Value
    private let store: Store
    
    init(_ key: String, defaultValue: Value, store: Store = .userDefaults(.standard)) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }
    
    public var wrappedValue: Value {
        get {
            var data: Data? {
                switch store {
                    case .userDefaults(let store):
                        store.data(forKey: key)
                    case .fileManager(let directory):
                        FileManager.read(key, directory: directory)
                }
            }
            guard let data,
                  let decoded = data.decoded(Value.self) else {
                return defaultValue
            }
            return decoded
        }
        nonmutating set {
            guard let encoded = newValue.encoded() else { return }
            
            switch store {
                case .userDefaults(let store):
                    store.set(encoded, forKey: key)
                case .fileManager(let directory):
                    FileManager.save(key, data: encoded, directory: directory)
            }
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding {
            self.wrappedValue
        } set: {
            self.wrappedValue = $0
        }
    }
}
