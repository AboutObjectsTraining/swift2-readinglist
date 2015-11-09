//
// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit

class BookSummaryCell: UITableViewCell
{
    @IBOutlet var authorImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        authorImageView.layer.cornerRadius = 5
        authorImageView.layer.masksToBounds = true
    }
}
