//
//  FileManagerExtension.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

public extension FileManager {
    static func filePath(_ name: String, directory: SearchPathDirectory = .documentDirectory) -> URL? {
        let directory = FileManager.default.urls(for: directory, in: .userDomainMask).first
        guard let directory else { return nil }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        
        return file
    }
    
    static func save(_ name: String, data: Data, directory: SearchPathDirectory = .documentDirectory) throws {
        let directory = FileManager.default.urls(for: directory, in: .userDomainMask).first
        guard let directory else { return }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        guard let file = file else { return }
        
        try data.write(to: file, options: .atomic)
    }
    
    static func item(_ name: String, directory: SearchPathDirectory = .documentDirectory) throws -> Data? {
        let directory = FileManager.default.urls(for: directory, in: .userDomainMask).first
        guard let directory = directory else { return nil }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        guard let file = file else { return nil }
        
        return try Data(contentsOf: file)
    }
    
    static func remove(_ name: String, directory: SearchPathDirectory = .documentDirectory) throws {
        let directory = FileManager.default.urls(for: directory, in: .userDomainMask).first
        guard let directory = directory else { return }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        guard let file = file else { return }
        
        try self.default.removeItem(at: file)
    }
}

