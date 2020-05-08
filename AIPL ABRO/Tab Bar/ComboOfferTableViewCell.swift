//
//  ComboOfferTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/28/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ComboOfferTableViewCell: UITableViewCell {

    //MARK: comboOffer_TableView
    
    @IBOutlet var fullView_View: UIView!
    
    @IBOutlet var productimage_ImageView: UIImageView!
    
    @IBOutlet var title_label: UILabel!
    
    @IBOutlet var price_label: UILabel!
    
    @IBOutlet var quantity_label: UILabel!
    
    @IBOutlet var viewOffer_button: UIButton!
    
    //MARK: offerProduct_TableView
    
    @IBOutlet var freeFullView_View: UIView!
    
    @IBOutlet var freeProductimage_ImageView: UIImageView!
    
    @IBOutlet var freeTitle_label: UILabel!
    
    @IBOutlet var freePrice_label: UILabel!
    
    @IBOutlet var freeQuantity_label: UILabel!
    
    @IBOutlet var freeViewOffer_button: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

    }
    
    
    
    
}
