//
//  CustomProtocols.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

protocol StartYourDayDelegate {
    
    func startYourDay(btnTitle:String)
    
}

protocol SelectAddressVCDelegate {
    
    func address(text:String,lat:String,long:String)
    
}

protocol NewRetailerVCDelegate {
    
    func index(index:Int,text:String)
    
}

@objc protocol RemarkVCDelegate {
    
    func remark(endDay remarks:String)
    @objc optional func callCheckDayStartApi()
}

protocol PostedPlannerCellDelegate {
    
    func itemCategory(text:String,index:Int,btnTag:Int)
    func item(text:String,index:Int)
    func quantity(text:String,index:Int)
    
}

protocol NoOrderPopupVCDelegate {
    
    func value(OrderNotRec_Reason:String,OrderNotRec_Remarks:String)
}

protocol ValueDelegate {
    
    func getValue(text:String,index:Int)
    
}

protocol retailerNameTypeDelegate {
    
    func retailerName(index:Int,type:String,text:String,indexPath:Int)
    
}

protocol ReloadTableView {
    
    func reloadTable()
    
}
