//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let BooksKey = "books"

public class ReadingList: ModelObject
{
    enum Keys: String {
        case Title = "title"
        case Books = "books"
        static var allKeys: [String] {
            return [Title.rawValue, Books.rawValue]
        }
    }

    public var title = ""
    public var books = [Book]()
    
    public override var description: String {
        var s = "Title: \(title)\nCount: \(books.count)\nBooks:\n------\n"
        for (index, book) in books.enumerate() {
            s += "\(index + 1). \(book)\n"
        }
        return s
    }
    
    override class func keys() -> [String]
    {
        return [Keys.Title.rawValue, Keys.Books.rawValue]
    }
    
    public override func setValue(var value: AnyObject?, forKey key: String)
    {
        if key == BooksKey, let dicts = value as? [[String: AnyObject]] {
            value = dicts.map { Book.self(dictionary: $0) }
        }
        
        super.setValue(value, forKey: key)
    }
    
    public override func dictionaryRepresentation() -> [String: AnyObject]
    {
        var dict = super.dictionaryRepresentation()

        if let books = dict[BooksKey] as? [ModelObject] {
            dict[BooksKey] = books.map { $0.dictionaryRepresentation() }
        }
        
        return dict
    }
}