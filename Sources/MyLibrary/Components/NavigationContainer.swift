//
//  NavigationContainer.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *)
public struct NavigationContainer<Item, Label, Content>: View
where Item: CaseIterable & Hashable & RawRepresentable<LocalizedStringKey>, Item.AllCases: RandomAccessCollection,
      Label: View,
      Content: View
{
    @Binding var sidebar: Item?
    var layout: NavigationLayoutCategory
    var item: Item.Type
    var filter: [Item]?
    var label: (Item) -> Label
    var content: (Item) -> Content
    
    public init(
        sidebar: Binding<Item?>,
        layout: NavigationLayoutCategory,
        item: Item.Type,
        filter: [Item]? = nil,
        @ViewBuilder label: @escaping (Item) -> Label,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self._sidebar = sidebar
        self.layout = layout
        self.item = item
        self.filter = filter
        self.label = label
        self.content = content
    }
    
    var filtered: [Item] {
        guard let filter else { return item.allCases as! [Item] }
        return item.allCases.filter { filter.contains($0) }
    }
    
    public var body: some View {
        switch layout {
            case .stack(let path):
                List {
                    ForEach(filtered, id: \.self) { item in
                        NavigationLink(value: item) { label(item) }
                    }
                }
                .navigationDestination(for: item) { content($0) }
                .withNavigationStack(title: sidebar?.rawValue ?? .appName, path: path)
            case .tab:
                TabView(selection: $sidebar) {
                    ForEach(filtered, id: \.self) { item in
                        content(item).tabItem { label(item) }
                    }
                    .withNavigationStack(title: sidebar?.rawValue ?? .appName)
                }
            case .split:
                NavigationSplitView {
                    List(selection: $sidebar) {
                        ForEach(filtered, id: \.self) { label($0) }
                    }
                    .withNavigationStack(title: .appName)
                } detail: {
                    sidebar.compactView { content($0) }
                        .withNavigationStack(title: sidebar?.rawValue ?? .appName)
                }
                
        }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *)
public enum NavigationLayoutCategory {
    case stack(path: Binding<NavigationPath>), tab, split
}

public extension LocalizedStringKey {
    static var appName: LocalizedStringKey {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            fatalError()
        }
        return .init(appName)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public extension CaseIterable where Self: Hashable, AllCases: RandomAccessCollection {
    @ViewBuilder
    static func allCasesView(@ViewBuilder content: @escaping (Self) -> some View) -> some View {
        ForEach(allCases, id: \.self) {
            content($0)
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public extension Optional {
    @ViewBuilder
    func compactView(@ViewBuilder content: (Wrapped) -> some View) -> some View {
        if let self = self {
            content(self)
        }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, xrOS 1.0, *)
public extension View {
    @ViewBuilder
    func withNavigationStack(title: LocalizedStringKey) -> some View {
        NavigationStack {
            self.navigationTitle(title)
        }
    }
    
    @ViewBuilder
    func withNavigationStack(title: LocalizedStringKey, path: Binding<NavigationPath>) -> some View {
        NavigationStack(path: path) {
            self.navigationTitle(title)
        }
    }
}
