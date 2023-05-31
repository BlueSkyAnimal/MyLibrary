//
//  CodableExtension.swift
//  
//
//  Created by 千葉和義 on 2023/04/03.
//

import SwiftUI

public extension Data {
    func decoded<T: Codable>(_ type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) -> T? {
        do {
            return try decoder.decode(T.self, from: self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

public extension Encodable {
    func encoded(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        encoder.outputFormatting = .prettyPrinted
        do {
            return try encoder.encode(self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveToFileManager(_ name: String) {
        guard let data = encoded() else { return }
        FileManager.save(name, data: data)
    }
}

public func readFromFileManager<T: Codable>(_ name: String) -> T? {
    guard let data = FileManager.read(name),
          let decoded = data.decoded(T.self) else { return nil }
    return decoded
}

