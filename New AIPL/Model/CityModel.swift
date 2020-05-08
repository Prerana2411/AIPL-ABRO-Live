//
//  CityModel.swift
//  
//
//  Created by apple on 14/01/20.
//

import Foundation

class CityModel{
    
    var City = String()
    var Beat = String()
    
    init(City:String,Beat:String) {
       
        self.City = City
        self.Beat = Beat
        
    }
}

class retailerListHQwiseModel{
    
    var RetailerName = String()
    var RetailerAddress = String()
    var Zone = String()
    var HQ = String()
    var No = String()
   
    init(RetailerName:String,RetailerAddress:String,Zone:String,HQ:String,No:String) {
       
        self.RetailerName = RetailerName
        self.RetailerAddress = RetailerAddress
        self.Zone = Zone
        self.HQ = HQ
        self.No = No
        
    }
    
}
