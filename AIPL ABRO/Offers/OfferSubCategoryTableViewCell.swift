//
//  OfferSubCategoryTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/23/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OfferSubCategoryTableViewCell: UITableViewCell {
    
    //right
    @IBOutlet weak var rightSideImageView_View: UIView!

    @IBOutlet weak var rightProductDescription_label: UILabel!
    
    @IBOutlet weak var rightProductDiscount_label: UILabel!

    @IBOutlet weak var rightProductViewAll_button: UIButton!

    @IBOutlet weak var rightProductImage_ImageView: UIImageView!

    @IBOutlet weak var rightCornerRadiusView_View: UIView!

    //left

    @IBOutlet weak var leftSideImageView_View: UIView!

    @IBOutlet weak var leftProductImage_ImageView: UIImageView!

    @IBOutlet weak var leftProductViewAll_button: UIButton!

    @IBOutlet weak var leftProductDiscount_label: UILabel!

    @IBOutlet weak var leftProductDescription_label: UILabel!

    @IBOutlet weak var leftCornerRadiusView_View: UIView!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    
    }

}
