//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest
@testable import ReadingListModel

class StoreTests: XCTestCase
{
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadStore()
    {
        let store = ReadingListStore("BooksAndAuthors")
        do {
            let readingList = try store.fetchReadingList()
            print("\(readingList)")
            XCTAssert(readingList.books.count > 0, "Fetched reading list's books array should not be empty.")
        }
        catch {
            XCTFail("Fetching should not cause an exception to be thrown.")
        }
    }
    
    func testSaveStore()
    {
        let store = ReadingListStore("BooksAndAuthors")
        do {
            let readingList = try store.fetchReadingList()
            store.saveReadingList(readingList)
            
            // TODO: Add NSFileManager check and assert.
        }
        catch {
            XCTFail("Fetching should not cause an exception to be thrown.")
        }

    }
}
