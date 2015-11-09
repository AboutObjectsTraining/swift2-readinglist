//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let Unknown = "Author Unknown"

public class Book: ModelObject
{
    enum Keys: String {
        case Title = "title"
        case Year = "year"
        case Author = "author"
        static var allKeys: [String] {
            return [Title.rawValue, Year.rawValue, Author.rawValue]
        }
    }
    
    public var title = ""
    public var year = ""
    public var author: Author?
    
    public override var description: String {
        return "\(title), \(year), \(author ?? Unknown)"
    }
    
    override class func keys() -> [String]
    {
        return [Keys.Title.rawValue, Keys.Year.rawValue, Keys.Author.rawValue];
    }
    
    public required init(var dictionary: [String : AnyObject])
    {
        if let dict = dictionary[Keys.Author.rawValue] as? [String: AnyObject] {
            dictionary[Keys.Author.rawValue] = Author(dictionary: dict)
        }
        
        super.init(dictionary: dictionary)
    }
    
    public override func dictionaryRepresentation() -> [String: AnyObject]
    {
        var dict = super.dictionaryRepresentation()
        if let author = dict[Keys.Author.rawValue] as? Author {
            dict[Keys.Author.rawValue] = author.dictionaryRepresentation()
        }
        
        return dict
    }
}