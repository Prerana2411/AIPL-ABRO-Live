//
//  OrderHistoryTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

import HCSStarRatingView

class OrderHistoryTableViewCell: UITableViewCell {

    //MARK: outlets
    
    @IBOutlet weak var containerView_View: UIView!
    
    @IBOutlet weak var image_imageView: UIImageView!
   
    @IBOutlet weak var orderTitle_label: UILabel!
    
    @IBOutlet weak var orderDescription_label: UILabel!
    
    @IBOutlet weak var orderQuantity_label: UILabel!
    
    @IBOutlet weak var orderPrice_label: UILabel!
    
    @IBOutlet weak var orderPlaceDate_label: UILabel!
    
    @IBOutlet weak var orderPlaceID_label: UILabel!
    
    @IBOutlet weak var orderDeliveryDate_label: UILabel!
    
    @IBOutlet weak var deliveryStatus_label: UILabel!
        
    @IBOutlet weak var reviewAdded_view: UIView!
    
    @IBOutlet var write_button: UIButton!
    
    @IBOutlet weak var reviewAdded_lbl: UILabel!
    
    @IBOutlet weak var rating_view: HCSStarRatingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
