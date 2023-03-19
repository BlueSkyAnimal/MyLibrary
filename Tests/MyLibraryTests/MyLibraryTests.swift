import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testSpeed() throws {
        measure {
            _ = FileManager.libraryDirectory
            _ = FileManager.applicationSupportDirectory
            _ = FileManager.documentDirectory
        }
    }
}
