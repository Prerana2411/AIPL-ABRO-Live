//
//  ProductCategoriesTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ProductCategoriesTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var productName_label: UILabel!
    
    @IBOutlet weak var productSubCategory_label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
