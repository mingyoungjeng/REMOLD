//
//  JournalTableViewCell.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/19/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        entryField.isScrollEnabled = false // Allows for infinite scroll
        entryField.textContainerInset = UIEdgeInsets.zero
        entryField.textContainer.lineFragmentPadding = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
