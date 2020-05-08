//
//  ProductDescriptionTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 25/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

import HCSStarRatingView

class ProductReviewTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    
    @IBOutlet weak var starRating_View: HCSStarRatingView!
        
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var description_label: UILabel!
    
    //
    @IBOutlet weak var featured_descLbl: UILabel!
    //
    @IBOutlet weak var appli_descLbl: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }

}
