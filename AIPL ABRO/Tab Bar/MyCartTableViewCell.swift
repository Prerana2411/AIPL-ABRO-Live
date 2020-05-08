//
//  MyCartTableViewCell.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {
    
    //Mark: Outlets
    
    @IBOutlet weak var image_imageView: UIImageView!
    
    @IBOutlet weak var productCode_label: UILabel!
    
    @IBOutlet var productName_label: UILabel!
    
    @IBOutlet var quantity_label: UILabel!
    
    @IBOutlet weak var price_label: UILabel!
    
    @IBOutlet weak var reedemOffer_button: UIButton!
    
    @IBOutlet weak var cutView_View: UIView!
    
    @IBOutlet weak var shadow_view: UIView!
    
    @IBOutlet weak var cross_btn: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    
    //    //MARK: Actions
    //
    //    @IBAction func minus_button(_ sender: UIButton) {
    //
    //
    //        var a =  Int(quantity_textField.text!)
    //
    //        if a! > 1{
    //
    //            a! = a! - 1
    //
    //            quantity_textField.text = String(describing : a!)
    //
    //        }
    //    }
    //
    //    @IBAction func plus_button(_ sender: UIButton) {
    //
    //        var a =  Int(quantity_textField.text!)
    //
    //        a! = a! + 1
    //
    //        quantity_textField.text = String(describing : a!)
    //
    //    }
    
    
    
    
    
}
