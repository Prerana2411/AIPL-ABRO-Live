//
//  NotificationTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 24/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    //MARK: Outlet
    
    @IBOutlet weak var productImage_imageView: UIImageView!
    
    @IBOutlet weak var notificationDescription_label: UILabel!
    
    @IBOutlet weak var notificationTime_label: UILabel!
    
    
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
