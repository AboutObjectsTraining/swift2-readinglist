//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

let ReadingListFileName = "BooksAndAuthors"

class ReadingListViewController: UITableViewController
{
    private var objectStore: ReadingListStore!
    private var readingList: ReadingList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        objectStore = ReadingListStore(ReadingListFileName)
        
        do {
            try readingList = objectStore.fetchReadingList()
            title = readingList.title
        }
        catch (let error) {
            print("Unable to load file named: \(ReadingListFileName); error was: \(error)")
        }
        
//        navigationItem.leftBarButtonItem = editButtonItem()
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

