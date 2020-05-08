//
//  SignUpTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {

    //MARK: Outlet
    
    @IBOutlet weak var user_Label: UILabel!
    
    @IBOutlet weak var userTick_ImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
