//
//  HardwareProductsCollectionViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 25/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class HardwareProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    
    //first CollectionView - productSubCategory
    
    @IBOutlet weak var subCategory_Button: UILabel!
    
    //collection view - h/w product
    
    @IBOutlet weak var containerView_View: UIView!
    
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var productTitle_label: UILabel!
    
    @IBOutlet weak var productPrice_label: UILabel!
    
    @IBOutlet weak var addToCart_button: UIButton!
    
    @IBOutlet weak var cartImage_ImageView: UIImageView!
    
}
