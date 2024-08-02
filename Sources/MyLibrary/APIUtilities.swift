//
//  APIUtilities.swift
//
//
//  Created by BlueSkyAnimal on 2024/02/13.
//

import Foundation

@dynamicCallable
public struct URLQueryItemsGenerator {
    public init() {}
    
    public static var shared = URLQueryItemsGenerator()
    
    public func dynamicallyCall(
        withKeywordArguments pairs: KeyValuePairs<String, CustomStringConvertible>
    ) -> [URLQueryItem] {
        pairs.map { (key, value)  in
            URLQueryItem(name: key, value: value.description)
        }
    }
}

@dynamicCallable
public struct DictionaryGenerator {
    public init() {}
    
    public func dynamicallyCall(
        withKeywordArguments pairs: KeyValuePairs<String, Any>
    ) -> [String : Any] {
        var dictionary = [String : Any]()
        pairs.forEach { (key, value) in
            dictionary.updateValue(value, forKey: key)
        }
        return dictionary
    }
}

@dynamicCallable
public struct JSONDataGenerator {
    public init() {}
    
    public func dynamicallyCall(
        withKeywordArguments pairs: KeyValuePairs<String, Any>
    ) throws -> Data {
        let generator = DictionaryGenerator()
        let dictionary = generator.dynamicallyCall(withKeywordArguments: pairs)
        return try JSONSerialization.data(withJSONObject: dictionary)
    }
}

enum JSONError: Error, LocalizedError {
    case cannotParse
}

@dynamicMemberLookup
public enum JSON {
    case dictionaryValue(Dictionary<String, JSON>)
    case arrayValue(Array<JSON>)
    case numberValue(NSNumber)
    case stringValue(String)
    case boolValue(Bool)
    case nullValue
    
    public var objectValue: Dictionary<String, JSON>? {
        if case .dictionaryValue(let dictionary) = self {
            return dictionary
        }
        return nil
    }
    
    public var arrayValue: Array<JSON>? {
        if case .arrayValue(let array) = self {
            return array
        }
        return nil
    }
    
    public var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    public var numberValue: NSNumber? {
        if case .numberValue(let number) = self {
            return number
        } else if case .boolValue(let b) = self {
            return NSNumber(value: b)
        }
        return nil
    }
    
    public var boolValue: Bool? {
        if case .boolValue(let bool) = self {
            return bool
        }
        return nil
    }
    
    public var nullValue: NSNull? {
        if case .nullValue = self {
            return NSNull()
        }
        return nil
    }
    
    public subscript(index: Int) -> JSON? {
        if case .arrayValue(let array) = self {
            return index < array.count ? array[index] : nil
        }
        return nil
    }
    
    public subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
    
    private init(_ object: Any) {
        switch object {
        case let boolValue as Bool: self = .boolValue(boolValue)
        case let numberValue as NSNumber: self = .numberValue(numberValue)
        case let stringValue as String: self = .stringValue(stringValue)
        case let dictionaryValue as Dictionary<String, Any>: self = JSON.dictionaryValue(
            dictionaryValue.mapValues { JSON($0) }
        )
        case let arrayValue as Array<Any>: self = .arrayValue(arrayValue.map { JSON($0)} )
        default: self = .nullValue
        }
    }
    
    public init(data: Data) throws {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        self = .init(jsonObject)
    }
    
    public func raw() -> Any {
        switch self {
        case .dictionaryValue(let dictionary):
            var updated = [String : Any]()
            dictionary.forEach {
                updated.updateValue($0.value.raw(), forKey: $0.key)
            }
            return updated
        case .arrayValue(let array):
            return array.compactMap { $0.raw() }
        case .numberValue(let number):
            return number
        case .stringValue(let string):
            return string
        case .boolValue(let bool):
            return bool
        case .nullValue:
            fatalError()
        }
    }
    
    public func jsonData() throws -> Data? {
        let raw = raw()
        return try JSONSerialization.data(withJSONObject: raw, options: .prettyPrinted)
    }
}
