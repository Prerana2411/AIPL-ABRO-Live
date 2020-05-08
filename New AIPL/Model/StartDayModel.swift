//
//  StartDayModel.swift
//  AIPL ABRO
//
//  Created by CST on 21/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class StartDayModel {
    
    var dayCode : Int?
    var SalesPersonCode : String?
    var SalesPersonName : String?
    var TransportMode : String?
    var TransportType : String?
    var Headquarter : String?
    var City : String?
    var Image : String?
    var LeaveStatus : String?
    var Edited : String?
    var EndRemarks : String?
    init(dayCode:Int,SalesPersonCode:String,SalesPersonName:String,TransportMode:String,TransportType:String,Headquarter:String,City:String,Image:String,LeaveStatus:String,Edited:String,EndRemarks:String) {
        
        self.dayCode = dayCode
        self.SalesPersonCode = SalesPersonCode
        
        self.SalesPersonName = SalesPersonName
        self.TransportMode = TransportMode
        
        self.TransportType = TransportType
        self.Headquarter = Headquarter
        
        self.City = City
        self.Image = Image
        
        self.LeaveStatus = LeaveStatus
        self.Edited = Edited
        
        self.EndRemarks = EndRemarks
    }
}
