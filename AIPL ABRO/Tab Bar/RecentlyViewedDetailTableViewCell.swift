//
//  RecentlyViewedDetailTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/8/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class RecentlyViewedDetailTableViewCell: UITableViewCell {

    //MARK: Variables productTitle_label oldPrice_label  newPrice_label productImage_ImageView
    
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var productTitle_label: UILabel!
    
    @IBOutlet weak var oldPrice_label: UILabel!
    
    @IBOutlet weak var newPrice_label: UILabel!
    
    @IBOutlet weak var cutView_View: UIView!
    
    @IBOutlet weak var offerPrice_label: UILabel!
    
    @IBOutlet weak var oldPrice_height: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

}
