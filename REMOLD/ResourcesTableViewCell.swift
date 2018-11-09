//
//  ResourcesTableViewCell.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/7/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {

    // Properties
    @IBOutlet weak var Label: UILabel!
    
    var link = URL(string: "")
    var number = URL(string: "")
    @IBAction func CallButton(_ sender: UIButton) {
        UIApplication.shared.open(number!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {UIApplication.shared.open(link!)}
    }

}
