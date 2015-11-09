//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

enum FileError: ErrorType {
    case NullPath
    case NotFound(pathName: String)
    case NotFoundInBundle(fileName: String, bundle: NSBundle)
    case Unreadable(fileURL: NSURL)
}


// MARK: - File Utilities

let DocumentsURLs = NSFileManager.defaultManager().URLsForDirectory(
    NSSearchPathDirectory.DocumentDirectory, inDomains:
    NSSearchPathDomainMask.UserDomainMask)

func FileURLForDocument(name: String, type: String) -> NSURL
{
    precondition(!DocumentsURLs.isEmpty, "Document directory appears to be missing.")
    
    let fileURL = DocumentsURLs.first!
    return fileURL.URLByAppendingPathComponent(name).URLByAppendingPathExtension(type)
}


// MARK: - ReadingListStore

public class ReadingListStore : NSObject
{
    let storeName: String
    let documentURL: NSURL
    
    public init(_ storeName: String)
    {
        self.storeName = storeName
        documentURL = FileURLForDocument(storeName, type: "plist")
        super.init()
    }
    
    public func fetchReadingList() throws -> ReadingList
    {
        var fileURL = documentURL
        
        if !NSFileManager.defaultManager().fileExistsAtPath(documentURL.path!)
        {
            let bundle = NSBundle(forClass: ReadingListStore.self)
            guard let URL = bundle.URLForResource(storeName, withExtension: "plist") else {
                print("\n*** WARNING: Unable to locate \(storeName) in app bundle. ***\n\n")
                throw FileError.NotFoundInBundle(fileName: storeName, bundle: bundle)
            }
            
            fileURL = URL
        }
        
        guard let dict = NSDictionary(contentsOfURL: fileURL) as? [String: AnyObject] else {
            print("\n*** WARNING: Unable to read file with URL \(fileURL). ***\n\n")
            throw FileError.Unreadable(fileURL: fileURL)
        }
        
        return ReadingList(dictionary: dict)
    }
    
    public func saveReadingList(readingList: ReadingList)
    {
        let dict = readingList.dictionaryRepresentation() as NSDictionary
        dict.writeToURL(documentURL, atomically: true)
    }
}