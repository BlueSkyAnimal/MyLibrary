//
//  ArrayExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/23.
//

public extension Array {
    func select<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    func select<T>(_ keyPath: KeyPath<Element, T?>, defaultValue: T) -> [T] {
        map { $0[keyPath: keyPath] ?? defaultValue }
    }
    
    func compactSelect<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }
}
