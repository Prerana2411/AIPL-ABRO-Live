//
//  RecentlyViewedTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 24/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class RecentlyViewedTableViewCell: UITableViewCell {
    
    //MARK: outlets
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var productTitle_label: UILabel!
    
    @IBOutlet weak var oldPrice_label: UILabel!
    
    @IBOutlet weak var newPrice_label: UILabel!
    
    @IBOutlet weak var cutView_View: UIView!
    
    @IBOutlet weak var offerPrice_label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
