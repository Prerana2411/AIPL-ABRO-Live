//
//  SpecialDiscountView.swift
//  AIPL ABRO
//
//  Created by promatics on 30/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SpecialDiscountView: UIView {

    @IBOutlet weak var carouselFrontView_View: UIView!
    
    @IBOutlet weak var carouselCornerRadiusView_View: UIView!
    
    @IBOutlet weak var carouselImageView_View: UIView!
    @IBOutlet weak var offerType_label: UILabel!
    
    @IBOutlet weak var offerCategory_label: UILabel!
    
    @IBOutlet weak var offerProductImage_ImageView: UIImageView!
    
    @IBOutlet weak var offerViewAll_button: UIButton!
        
    @objc required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
       
    }
    
    @objc override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
    
}
