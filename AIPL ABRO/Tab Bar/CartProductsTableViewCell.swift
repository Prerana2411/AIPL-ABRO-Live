//
//  CartProductsTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/27/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class CartProductsTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet var fullView_View: UIView!
    
    @IBOutlet var productCode_label: UILabel!
    
    @IBOutlet var quantity_label: UILabel!
    
    @IBOutlet var price_label: UILabel!
    
    @IBOutlet var date_label: UILabel!
    
    @IBOutlet weak var cross_btn: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

    }

}
