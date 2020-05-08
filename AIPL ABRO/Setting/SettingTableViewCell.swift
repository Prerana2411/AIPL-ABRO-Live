//
//  SettingTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/5/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    //MARK: outlets
    
    @IBOutlet var settingLabel_label: UILabel!
    
    @IBOutlet var arrowImage_ImageView: UIImageView!
    
    @IBOutlet var notification_Switch: UISwitch!
    
    @IBOutlet var status_label: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
