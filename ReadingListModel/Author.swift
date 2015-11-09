//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

public class Author: ModelObject
{
    enum Keys: String {
        case FirstName = "firstName"
        case LastName = "lastName"
        static var allKeys: [String] {
            return [FirstName.rawValue, LastName.rawValue]
        }
    }
    
    public var firstName = ""
    public var lastName = ""
    public var fullName: String {
        return (firstName + " " + lastName).stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceCharacterSet())
    }
    
    
    override class func keys() -> [String]
    {
        return [Keys.FirstName.rawValue, Keys.LastName.rawValue]
    }
    
    public override var description: String {
        return fullName
    }
}