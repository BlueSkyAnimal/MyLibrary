//
//  AsyncButton.swift
//  MyLibrary
//
//  Created by BlueSkyAnimal on 2024/01/06.
//

import SwiftUI

public protocol ErrorHandlingMethod {}

public struct DoCatchHandling: ErrorHandlingMethod {}

public struct OptionalHandling: ErrorHandlingMethod {}

public struct ForcedHandling: ErrorHandlingMethod {}

public extension ErrorHandlingMethod where Self == DoCatchHandling {
    static var doCatch: DoCatchHandling { DoCatchHandling() }
}

public extension ErrorHandlingMethod where Self == OptionalHandling {
    static var optional: OptionalHandling { OptionalHandling() }
}

public extension ErrorHandlingMethod where Self == ForcedHandling {
    static var forced: ForcedHandling { ForcedHandling() }
}

public extension Button where Label : View {
    init(_ errorHandling: DoCatchHandling,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label,
         error: @escaping (Error) -> Void
    ) {
        self.init {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        } label: {
            label()
        }
    }
    
    init(_ errorHandling: OptionalHandling,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label
    ) {
        self.init {
            Task { try? await action() }
        } label: {
            label()
        }
    }
    
    init(_ errorHandling: ForcedHandling,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label
    ) {
        self.init {
            Task { try! await action() }
        } label: {
            label()
        }
    }
}

public extension Button where Label == Text {
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void) {
        self.init(titleKey) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         action: @escaping () async throws -> Void) {
        self.init(titleKey) {
            Task { try? await action() }
        }
    }
    
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         action: @escaping () async throws -> Void) {
        self.init(titleKey) {
            Task { try! await action() }
        }
    }
    
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void
    ) where S : StringProtocol {
        self.init(title) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title) {
            Task { try? await action() }
        }
    }
    
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title) {
            Task { try! await action() }
        }
    }
}

public extension Button where Label == SwiftUI.Label<Text, Image> {
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void
    ) {
        self.init(titleKey, systemImage: systemImage) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         action: @escaping () async throws -> Void
    ) {
        self.init(titleKey, systemImage: systemImage) {
            Task { try? await action() }
        }
    }
    
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         action: @escaping () async throws -> Void
    ) {
        self.init(titleKey, systemImage: systemImage) {
            Task { try! await action() }
        }
    }
    
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            systemImage: String,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void
    ) where S : StringProtocol {
        self.init(title, systemImage: systemImage) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            systemImage: String,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, systemImage: systemImage) {
            Task { try? await action() }
        }
    }
    
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            systemImage: String,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, systemImage: systemImage) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void) {
        self.init(titleKey, image: image) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, image: image) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, image: image) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            image: ImageResource,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void
    ) where S : StringProtocol {
        self.init(title, image: image) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            image: ImageResource,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, image: image) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            image: ImageResource,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, image: image) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: DoCatchHandling,
         _ role: ButtonRole?,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label,
         error: @escaping (Error) -> Void) {
        self.init(role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        } label: {
            label()
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: OptionalHandling,
         _ role: ButtonRole?,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label) {
        self.init(role: role) {
            Task { try? await action() }
        } label: {
            label()
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: ForcedHandling,
         _ role: ButtonRole?,
         action: @escaping () async throws -> Void,
         @ViewBuilder label: () -> Label) {
        self.init(role: role) {
            Task { try! await action() }
        } label: {
            label()
        }
    }
}

public extension Button where Label == Text {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         role: ButtonRole?,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void) {
        self.init(titleKey, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, role: role) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            role: ButtonRole?,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void
    ) where S : StringProtocol {
        self.init(title, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, role: role) {
            Task { try! await action() }
        }
    }
}

public extension Button where Label == SwiftUI.Label<Text, Image> {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         role: ButtonRole?,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void) {
        self.init(titleKey, systemImage: systemImage, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, systemImage: systemImage, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, systemImage: systemImage, role: role) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            systemImage: String,
            role: ButtonRole?,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void) where S : StringProtocol {
        self.init(title, systemImage: systemImage, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            systemImage: String,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, systemImage: systemImage, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            systemImage: String,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, systemImage: systemImage, role: role) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: DoCatchHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         role: ButtonRole?,
         action: @escaping () async throws -> Void,
         error: @escaping (Error) -> Void) {
        self.init(titleKey, image: image, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: OptionalHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, image: image, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init(_ errorHandling: ForcedHandling,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         role: ButtonRole?,
         action: @escaping () async throws -> Void) {
        self.init(titleKey, image: image, role: role) {
            Task { try! await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: DoCatchHandling,
            _ title: S,
            image: ImageResource,
            role: ButtonRole?,
            action: @escaping () async throws -> Void,
            error: @escaping (Error) -> Void
    ) where S : StringProtocol {
        self.init(title, image: image, role: role) {
            Task {
                do {
                    try await action()
                } catch let _error {
                    error(_error)
                }
            }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: OptionalHandling,
            _ title: S,
            image: ImageResource,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, image: image, role: role) {
            Task { try? await action() }
        }
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    init<S>(_ errorHandling: ForcedHandling,
            _ title: S,
            image: ImageResource,
            role: ButtonRole?,
            action: @escaping () async throws -> Void
    ) where S : StringProtocol {
        self.init(title, image: image, role: role) {
            Task { try! await action() }
        }
    }
}
