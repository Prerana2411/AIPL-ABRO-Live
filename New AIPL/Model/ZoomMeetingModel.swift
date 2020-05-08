//
//  ZoomMeetingModel.swift
//  AIPL ABRO
//
//  Created by call soft on 28/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class zoomMeetListModel{
    
    var Description = String()
    var MeetingId = String()
    var MeetingPass = String()
    var scheduleBy = String()
    var MeetingTime = String()
    var MeetingDate = String()
    var MeetingCode = String()
    
    init(Description:String,MeetingId:String,MeetingPass:String,scheduleBy:String,MeetingTime:String,MeetingDate:String,MeetingCode:String) {
        
        self.Description = Description
        self.MeetingId = MeetingId
        self.MeetingPass = MeetingPass
        self.MeetingTime = MeetingTime
        self.MeetingDate = MeetingDate
        self.scheduleBy = scheduleBy
        self.MeetingCode = MeetingCode
    }
    
}

class UserListModel{
    
    var Name = String()
    var EmpCode = String()
    var EmployeeLevel = Int()
    var isSelected = Bool()
    init(Name:String,EmpCode:String,EmployeeLevel:Int,isSelected:Bool) {
        
        self.Name = Name
        self.EmpCode = EmpCode
        self.EmployeeLevel = EmployeeLevel
        self.isSelected = isSelected
    }
    
}
