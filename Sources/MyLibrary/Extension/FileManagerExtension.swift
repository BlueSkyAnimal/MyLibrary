//
//  FileManagerExtension.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

public extension FileManager {
    static var libraryDirectory: URL? {
        FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    }
    
    static var applicationSupportDirectory: URL? {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
    }
    
    static var documentDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func save(_ name: String, data: Data, directory: URL? = FileManager.documentDirectory) {
        guard let directory = directory else { return }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        
        guard let file = file else { return }
        
        do {
            try data.write(to: file, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func read(_ name: String, directory: URL? = FileManager.documentDirectory) -> Data? {
        guard let directory = directory else { return nil }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        
        guard let file = file else { return nil }
        
        do {
            return try Data(contentsOf: file)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func remove(_ name: String, directory: URL? = FileManager.documentDirectory) {
        guard let directory = directory else { return }
        
        var file: URL? {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                return directory.appending(component: name)
            } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                return directory.appendingPathComponent(name, conformingTo: .data)
            } else {
                return URL(string: name, relativeTo: directory)
            }
        }
        
        guard let file = file else { return }
        
        do {
            try self.default.removeItem(at: file)
        } catch {
            print(error.localizedDescription)
        }
    }
}

