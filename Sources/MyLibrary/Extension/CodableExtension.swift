//
//  CodableExtension.swift
//  
//
//  Created by 千葉和義 on 2023/04/03.
//

import SwiftUI

public extension Data {
    func decoded<T: Codable>(_ type: T.Type = T.self) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

public extension Encodable {
    func encoded() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
