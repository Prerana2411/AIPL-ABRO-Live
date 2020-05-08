//
//  PlannerModel.swift
//  AIPL ABRO
//
//  Created by CST on 22/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

struct PlannerModel:Equatable{
    
    var compareDate : String?
    var SalesPersonCode : String?
    var SalesPersonName : String?
    var plannerDate : String?
    var plannerDays : String?
    var Headquarter : String?
    var City : String?
    var remarks : String?
    var salePersonHQ : String?
    var Edited : String?
    var nightHalt : String?
    var beat : String?
    init(compareDate:String,SalesPersonCode:String,SalesPersonName:String,plannerDate:String,plannerDays:String,Headquarter:String,City:String,remarks:String,salePersonHQ:String,Edited:String,nightHalt:String,beat:String) {
        
        self.compareDate = compareDate
        self.SalesPersonCode = SalesPersonCode
        
        self.SalesPersonName = SalesPersonName
        self.plannerDate = plannerDate
        
        self.plannerDays = plannerDays
        self.Headquarter = Headquarter
        
        self.City = City
        self.remarks = remarks
        
        self.salePersonHQ = salePersonHQ
        self.Edited = Edited
        
        self.nightHalt = nightHalt
        self.beat = beat
        
          }
    
}

struct EditPlnnerArrModel:Equatable{
    
    var plannerNo : String?
    var SalesPersonCode : String?
    var SalesPersonName : String?
    var plannerDate : String?
    var plannerDays : String?
    var Headquarter : String?
    var City : String?
    var remarks : String?
    var salePersonHQ : String?
    var Edited : String?
    var nightHalt : String?
    var beat : String?
    var lineNo :String?
    init(plannerNo:String,SalesPersonCode:String,SalesPersonName:String,plannerDate:String,plannerDays:String,Headquarter:String,City:String,remarks:String,salePersonHQ:String,Edited:String,nightHalt:String,beat:String,lineNo:String) {
        
        self.plannerNo = plannerNo
        self.SalesPersonCode = SalesPersonCode
        
        self.SalesPersonName = SalesPersonName
        self.plannerDate = plannerDate
        
        self.plannerDays = plannerDays
        self.Headquarter = Headquarter
        
        self.City = City
        self.remarks = remarks
        
        self.salePersonHQ = salePersonHQ
        self.Edited = Edited
        
        self.nightHalt = nightHalt
        self.beat = beat
        
        self.lineNo = lineNo
        
          }
    
}


class EditPlannerModel{
    
    var PlannerNo : String?
    var SalesPersonCode : String?
    var SalesPersonName : String?
    var SalePersonMobile : String?
    var SalePersonEMail : String?
    var HQ : String?
    var FromDate : String?
    var ToDate : String?
    var CreateDate : String?
    var No_Series : String?
    var Month : String?
    var Year : String?
    var Status : String?
    var plannerModelArr = [EditPlnnerArrModel]()
    init(PlannerNo:String,SalesPersonCode:String,SalesPersonName:String,SalePersonMobile:String,SalePersonEMail:String,HQ:String,FromDate:String,ToDate:String,CreateDate:String,No_Series:String,Month:String,Year:String,Status:String,plannerModelArr:[EditPlnnerArrModel]) {
        
        
        self.PlannerNo = PlannerNo
        self.SalesPersonCode = SalesPersonCode
        self.SalesPersonName = SalesPersonName
        self.SalePersonMobile = SalePersonMobile
        self.SalePersonEMail = SalePersonEMail
        self.HQ = HQ
        self.FromDate = FromDate
        self.ToDate = ToDate
        self.CreateDate = CreateDate
        self.No_Series = No_Series
        self.Month = Month
        self.Year = Year
        self.Status = Status
        self.plannerModelArr = plannerModelArr
    }
    
}
