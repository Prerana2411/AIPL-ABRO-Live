//
//  SizeChildTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/24/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SizeChildTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var heading_label: UILabel!
    
    @IBOutlet weak var description_label: UILabel!
    
    @IBOutlet weak var oldPrice_label: UILabel!
    
    @IBOutlet weak var oldPriceCut_View: UIView!
    
    @IBOutlet weak var cutView_View: UIView!
    
  //  @IBOutlet weak var readMore_button: UIButton!
    
    @IBOutlet weak var read_button: UIButton!
    
    
    
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }


    
    
    
    
}
