//
//  OfferSecondPageTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/2/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OfferSecondPageTableViewCell: UITableViewCell {

    //MARK:Outlets
    
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var container_View: UIView!
    
    @IBOutlet weak var productDescription_label: UILabel!
    
    @IBOutlet weak var oldPrice_label: UILabel!
    
    @IBOutlet weak var newPrice_label: UILabel!
    
    @IBOutlet weak var addToCart_button: UIButton!
    
    @IBOutlet weak var cartImage_ImageView: UIImageView!
    
    @IBOutlet weak var oldPriceView_View: UIView!
    
    @IBOutlet weak var oldPrice_height: NSLayoutConstraint!
    
    @IBOutlet weak var oldPrice_top: NSLayoutConstraint!
    
    @IBOutlet weak var oldPrice_bottom: NSLayoutConstraint!
    
    @IBOutlet weak var offerPrice_label: UILabel!
    
    @IBOutlet weak var offerImageView_ImageView: UIImageView!
    
    @IBOutlet weak var off_label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
