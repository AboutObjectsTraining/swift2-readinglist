//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class BookDetailViewController: UITableViewController
{
    var book: Book!
    
    @IBOutlet var titleCell: UITableViewCell!
    @IBOutlet var yearCell: UITableViewCell!
    @IBOutlet var firstNameCell: UITableViewCell!
    @IBOutlet var lastNameCell: UITableViewCell!
    @IBOutlet weak var authorImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureViews()
        populateViews()
    }
    
    func configureViews()
    {
        authorImageView.layer.cornerRadius = 7
        authorImageView.layer.masksToBounds = true
    }
    
    func populateViews()
    {
        titleCell.detailTextLabel?.text = book.title
        yearCell.detailTextLabel?.text = book.year
        firstNameCell.detailTextLabel?.text = book.author?.firstName
        lastNameCell.detailTextLabel?.text = book.author?.lastName
        authorImageView.image = UIImage(named: book.author?.lastName ?? "NoImage")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {

    }
}
