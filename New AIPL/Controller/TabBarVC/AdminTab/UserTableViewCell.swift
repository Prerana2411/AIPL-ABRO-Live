//
//  UserTableViewCell.swift
//  AIPL ABRO
//
//  Created by call soft on 28/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }

}
