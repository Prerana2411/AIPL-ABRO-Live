//
//  singleton.swift
//  AIPL ABRO
//
//  Created by promatics on 2/10/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import Foundation

class singleton{
    
    static let sharedInstance = singleton()
    
    var addToCart : Bool = false
    
    var UserData : NSDictionary = [:]
    
    var quantity : NSMutableArray = []
    
    var total_price : NSMutableArray = []
    
    var sub_category : NSArray = []
    
    var subCategoryId = String()
    
    var final_total = ""
    
    var cartCount = 0
    
    var notificationCount = 0
    
    var quantitydetail = ""
    
    var categoryHeading = ""
    
    //order detail
    
    var bookDate = ""
    var deliveryDate = ""
    var deliveryStatus = ""
    
    //write a review
    var reviewProductTitle = ""
    var reviewPackSize = ""
    var reviewQuantityDetail = ""
    var reviewPriceDetail = ""
    var reviewImage = ""
    
    //notification'
    var categoryArr : NSArray = []
}
