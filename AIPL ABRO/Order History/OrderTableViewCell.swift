//
//  OrderTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/23/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    //MARK: outlets
    
    @IBOutlet weak var oderView_View: UIView!
    
    @IBOutlet weak var orderId_label: UILabel!
    
    @IBOutlet weak var orderDate_label: UILabel!
    
    @IBOutlet weak var orderStatus_label: UILabel!
    
    @IBOutlet weak var ordre_priceLbl: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

    }

}
