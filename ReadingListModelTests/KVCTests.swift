//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest
@testable import ReadingListModel

let FName = "First"
let LName = "Last"
let AuthorDict = [
    "firstName": FName,
    "lastName": LName
]


let BookTitle = "Book Title"
let Year = "1999"

class KVCTests: XCTestCase
{
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testPopulateAuthor()
    {
        let author = Author(dictionary: AuthorDict)
        print("\(author)")
        
        XCTAssertEqual(FName, author.firstName)
        XCTAssertEqual(LName, author.lastName)
    }
    
    func testAuthorDictionaryRepresentation()
    {
        let author = Author(dictionary: AuthorDict)
        let dict = author.dictionaryRepresentation()
        print("\(dict)")
        XCTAssertEqual(author.firstName, dict[Author.Keys.FirstName.rawValue] as? String)
        XCTAssertEqual(author.lastName, dict[Author.Keys.LastName.rawValue] as? String)
    }
    
    func testPopulateBook()
    {
        let book = Book(dictionary: [
            Book.Keys.Title.rawValue: BookTitle,
            Book.Keys.Year.rawValue : Year,
            Book.Keys.Author.rawValue: Author(dictionary: AuthorDict)
            ])
        print("\(book)")
        
        XCTAssertEqual(BookTitle, book.title)
        XCTAssertEqual(Year, book.year)
        XCTAssertEqual(FName, book.author?.firstName)
        XCTAssertEqual(LName, book.author?.lastName)
    }
    
    func testBookDictionaryRepresentation()
    {
        let book = Book(dictionary: [
            Book.Keys.Title.rawValue: BookTitle,
            Book.Keys.Year.rawValue : Year,
            Book.Keys.Author.rawValue: Author(dictionary: AuthorDict)
            ])
        let bookDict = book.dictionaryRepresentation()
        print("\(bookDict)")
        
        XCTAssertEqual(book.title, bookDict[Book.Keys.Title.rawValue] as? String)
        XCTAssertEqual(book.year, bookDict[Book.Keys.Year.rawValue] as? String)
        
        let authorDict = bookDict[Book.Keys.Author.rawValue] as! [String: AnyObject]
        XCTAssertEqual(book.author?.firstName, authorDict[Author.Keys.FirstName.rawValue] as? String)
        XCTAssertEqual(book.author?.lastName, authorDict[Author.Keys.LastName.rawValue] as? String)
    }
}
