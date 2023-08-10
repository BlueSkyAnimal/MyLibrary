//
//  CodableExtension.swift
//  
//
//  Created by 千葉和義 on 2023/04/03.
//

import SwiftUI

public extension Data {
    func decoded<T: Codable>(_ type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T? {
        return try decoder.decode(T.self, from: self)
    }
}

public extension Encodable {
    func encoded(encoder: JSONEncoder = JSONEncoder()) throws -> Data? {
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

