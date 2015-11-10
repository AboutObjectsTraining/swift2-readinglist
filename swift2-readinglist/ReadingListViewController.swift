//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

let ReadingListFileName = "BooksAndAuthors"
let WebServiceURLString = "http://www.mocky.io/v2/564117c91100005e06578a92"

class ReadingListViewController: UITableViewController
{
    private var objectStore: ReadingListStore!
    private var readingList: ReadingList!
    
    private func loadReadingList()
    {
        objectStore = ReadingListStore(ReadingListFileName)
        
        do {
            try readingList = objectStore.fetchReadingList()
            title = readingList.title
        }
        catch (let error) {
            print("Unable to load file named: \(ReadingListFileName); error was: \(error)")
        }
    }
    
    private func configureNavigationController()
    {
        navigationController?.toolbarHidden = false
        
//        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    
    private func performWebServiceCall()
    {
        guard let URL = NSURL(string: WebServiceURLString) else {
            print("Malformed URL: \(WebServiceURLString)")
            abort() // TODO: throw an error here...
        }
        
        let session = NSURLSession.sharedSession().dataTaskWithURL(URL) { data, response, error in
            self.handleWebResponse(data, response: response as? NSHTTPURLResponse, error: error)
        }
        
        session.resume()
    }
    
    private func handleWebResponse(data: NSData?, response: NSHTTPURLResponse?, error: NSError?)
    {
        if error != nil {
            abort() // TODO: throw an error here...
        }
        
        guard let JSONData = data where response?.statusCode == 200 else {
            abort() // TODO: throw an error here...
        }
        
        do {
            guard let dict = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .AllowFragments) as? [String: AnyObject] else {
                abort() // TODO: throw an error here...
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.updateReadingList(dict)
            })
        }
        catch {
            
        }
    }
    
    private func updateReadingList(dictionary: [String: AnyObject])
    {
        readingList = ReadingList(dictionary: dictionary)
        print("\(readingList)")
        tableView.reloadData()
    }
    
    // MARK: Action Methods
    
    @IBAction func revert(sender: AnyObject)
    {
        // TODO: Present action sheet to confirm
        
        performWebServiceCall()
    }
    
    
    // MARK: UIViewController Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadReadingList()
        configureNavigationController()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            print("Can't perform segue without a selected row")
            abort()
        }
        
        let controller = segue.destinationViewController as! BookDetailViewController
        controller.book = readingList.books[indexPath.row]
    }
    
    
    // MARK: UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String?
    {
        return "Nuke"
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let rate = UITableViewRowAction(style: .Normal, title: "👍🏻\nRate") { action, indexPath in
            print("Rate selected")
            tableView.setEditing(false, animated: true)
        }
        rate.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 1.0)
        
        let share = UITableViewRowAction(style: .Normal, title: "❤️\nShare") { action, indexPath in
            print("Share selected")
            tableView.setEditing(false, animated: true)
        }
        
        let delete = UITableViewRowAction(style: .Destructive, title: "⛔️\nDelete") { action, indexPath in
            print("Delete selected")
            self.confirmDeleteRow(indexPath)
        }
        
        return [delete, rate, share];
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.tableRowColor : UIColor.evenTableRowColor
    }
    
    
    // MARK: TableView Row Actions
    
    func confirmDeleteRow(indexPath: NSIndexPath)
    {
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { action in
            self.deleteRow(indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { action in
            self.tableView.setEditing(false, animated: true)
        }
        
        let book = self.readingList.books[indexPath.row]
        let alertController = UIAlertController(
            title: "Delete Book",
            message: "Are you sure you want to delete \(book.title)?",
            preferredStyle: .ActionSheet)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func deleteRow(indexPath: NSIndexPath)
    {
        readingList.books.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.performSelector(Selector("reloadData"), withObject: self, afterDelay: 0.2)
    }
    
    // MARK: UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return readingList.books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookSummaryCell") as! BookSummaryCell
        let book = readingList.books[indexPath.row]
        
        cell.bookTitleLabel.text = book.title
        cell.bookInfoLabel.text = book.author?.fullName
        cell.authorImageView.image = UIImage(named: book.author?.lastName ?? "NoImage")
        
        return cell
    }
    
}

