//
//  DistributedChainModel.swift
//  AIPL ABRO
//
//  Created by CST on 10/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

struct DistributedChainModel:Codable {
    
    
    var Item = String()
    var retailerName = String()
    var plannerLineNo = String()
    var plannerNo = String()
    var plannerCity = String()
    
    var plannerDate = String()
    var retailerCode = String()
    var createDate = String()
    var orderStatus = String()
    var itemCategory = String()
    var actualQuantity = String()
    
    var orderQuantity = String()
    var tagedCustomerCode = String()
    var month = String()
    var year = String()
    
    
    init(year:String,month:String,tagedCustomerCode:String,orderQuantity:String,actualQuantity:String,itemCategory:String,orderStatus:String,createDate:String,retailerCode:String,plannerDate:String,plannerCity:String,plannerNo:String,plannerLineNo:String,retailerName:String,Item:String) {
        
        
        self.year = year
        self.month = month
        self.itemCategory = itemCategory
        self.Item = Item
        
        self.tagedCustomerCode = tagedCustomerCode
        self.orderQuantity = orderQuantity
        self.actualQuantity = actualQuantity
        self.orderStatus = orderStatus
        
        self.createDate = createDate
        self.retailerCode = retailerCode
        self.plannerDate = plannerDate
        self.plannerCity = plannerCity
        
        self.plannerNo = plannerNo
        self.plannerLineNo = plannerLineNo
        self.retailerName = retailerName
        
    }
}

struct distributorSecondarySalesModel:Codable,Equatable {
    
    var retailerCode = String()
    var retailerName = String()
    var createDate = String()
    var quantity = String()
    var month = String()
    var year = String()
    
    init(retailerCode:String,retailerName:String,createDate:String,quantity:String,month:String,year:String) {
        
        self.retailerCode = retailerCode
        self.retailerName = retailerName
        
        self.createDate = createDate
        self.quantity = quantity
        
        self.month = month
        self.year = year
        
    }
    
}
