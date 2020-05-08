//
//  RetailerModel.swift
//  AIPL ABRO
//
//  Created by CST on 24/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class RetailerModel{
    
    var No = String()
    var RetailerName = String()
    var RetailerAddress = String()
    var DSRCity = String()
    var PostCode = String()
    var StateCode = String()
    var EMail = String()
    var MobileNo = String()
    var ContactPerson = String()
    var Zone = String()
    var HQ = String()
    var Segment = String()
    var CustomerType = String()
    var CreateDate = String()
    var NoSeries = String()
    var SegmentName = String()
    var CustomerTypeName = String()
    var TaggedCustomerCode = String()
    var TaggedCustomerName = String()
    var Beat = String()
    var PhoneNo = String()
    var Classification = String()
    var Potential = String()
    var GSTNumber = String()
    var CompBrand = String()
    var lat = String()
    var Long = String()
    var UserType = String()
    var Image = String()
    var TelexNo = String()
    var stateDiscription = String()
   
    init(No:String,RetailerName:String,RetailerAddress:String,DSRCity:String,PostCode:String,StateCode:String,EMail:String,MobileNo:String,ContactPerson:String,Zone:String,HQ:String,Segment:String,CustomerType:String,CreateDate:String,NoSeries:String,SegmentName:String,CustomerTypeName:String,TaggedCustomerCode:String,TaggedCustomerName:String,Beat:String,PhoneNo:String,Classification:String,Potential:String,GSTNumber:String,CompBrand:String,lat:String,Long:String,UserType:String,Image:String,TelexNo:String,stateDiscription:String) {
        
        self.No = No
        self.RetailerName = RetailerName
        self.RetailerAddress = RetailerAddress
        self.DSRCity = DSRCity
        self.PostCode = PostCode
        self.StateCode = StateCode
        self.EMail = EMail
        self.MobileNo = MobileNo
        self.ContactPerson = ContactPerson
        self.Zone = Zone
        self.HQ = HQ
        self.Segment = Segment
        self.CustomerType = CustomerType
        self.CreateDate = CreateDate
        self.NoSeries = NoSeries
        self.SegmentName = SegmentName
        self.CustomerTypeName = CustomerTypeName
        self.TaggedCustomerCode = TaggedCustomerCode
        self.TaggedCustomerName = TaggedCustomerName
        self.Beat = Beat
        self.PhoneNo = PhoneNo
        self.Classification = Classification
        self.Potential = Potential
        self.GSTNumber = GSTNumber
        self.CompBrand = CompBrand
        self.lat = lat
        self.Long = Long
        self.UserType = UserType
        self.Image = Image
        self.TelexNo = TelexNo
        self.stateDiscription = stateDiscription
    }
    
}

struct DailyRegisterModel: Equatable,Codable {
    
    var itemCategory = String()
    var Item = String()
    var Quantity = String()
    
    init(itemCategory:String,Item:String,Quantity:String) {
        
        self.itemCategory = itemCategory
        self.Item = Item
        self.Quantity = Quantity
        
    }
    
}
