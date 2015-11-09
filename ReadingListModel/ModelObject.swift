//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

enum BindingError: ErrorType {
    case InvalidKey
}

public class ModelObject: NSObject
{
    enum Keys: String {
        case Default
        static var allKeys: [String] {
            return []
        }
    }

    // TODO: Ideally, keys would be a class variable, but that feature
    // isn't yet supported in the current version of Swift.
    //
    //     class let keys = []
    //
    class func keys() -> [String]
    {
        return []
    }

    public required init(dictionary: [String: AnyObject])
    {
        super.init()
        self.setValuesForKeysWithDictionary(dictionary)
    }
    
    public func dictionaryRepresentation() -> [String: AnyObject]
    {
        return self.dictionaryWithValuesForKeys(self.dynamicType.keys())
    }
}