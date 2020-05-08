//
//  HardwareProductsTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 25/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class HardwareProductsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var fullView_View: UIView!
    
    @IBOutlet weak var productImage_imageView: UIImageView!
    
    @IBOutlet weak var productDescription_label: UILabel!
    
    @IBOutlet weak var oldPrice_label: UILabel!
    
    @IBOutlet weak var newPrice_label: UILabel!
    
    @IBOutlet weak var addToCart_button: UIButton!
    
    @IBOutlet weak var cartImage_ImageView: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
