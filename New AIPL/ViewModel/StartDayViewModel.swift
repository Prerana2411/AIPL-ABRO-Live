//
//  StartDayViewModel.swift
//  AIPL ABRO
//
//  Created by CST on 21/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class StartDayViewModel {
    
    var apiHandler = ApiHandler()
    var getDataArr = [StartDayModel]()
    var getCityDataArr = [String]()
    var getBeatDataArr = [String]()
    var getStateDescriptionDataArr = [String]()
    var getStateCodeDataArr = [String]()
    var DictForCityAndBeat = NSMutableDictionary()
    var endTime = String()
    var startTime = String()
    
    func getDataFromApiHandlerClass(url:String,passDict:[String:Any],complitionBlock:@escaping (_ responseMessage:String) ->()){
        
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (reponseJSON) in
            
            let message = reponseJSON["message"].string ?? ""
            
            if reponseJSON["response"].bool == true{

                if let dataObj = reponseJSON["dataObj"].dictionary{

                    if self.getDataArr.count > 0 {
                        
                        self.getDataArr.removeAll()
                    }
                    var dayCodeR = Int()
                    var salesPersonCodeR = String()
                    var salesPersonNameR = String()
                    var transportModeR = String()
                    var transportTypeR = String()
                    var HQR = String()
                    var cityR = String()
                    var imageR = String()
                    var leaveStatusR = String()
                    var EditedR = String()
                    var endRemarks = String()

                    if let dayCode = dataObj["Day Code"]?.int{

                        dayCodeR = dayCode
                    }
                    if let salesPersonCode = dataObj["SalesPerson Code"]?.string{

                        salesPersonCodeR = salesPersonCode
                    }
                    if let salesPersonName = dataObj["SalesPerson Name"]?.string{

                        salesPersonNameR = salesPersonName
                    }
                    if let transportMode = dataObj["Transport Mode"]?.string{

                        transportModeR = transportMode
                    }
                    if let transportType = dataObj["Transport Type"]?.string{

                        transportTypeR = transportType
                    }
                    if let HQ = dataObj["Headquarter"]?.string{

                        HQR = HQ
                    }
                    if let city = dataObj["City"]?.string{

                        cityR = city
                    }
                    if let image = dataObj["Image"]?.string{

                        imageR = image
                    }
                    if let leaveStatus = dataObj["Leave Status"]?.string{

                        leaveStatusR = leaveStatus
                    }
                    if let Edited = dataObj["Edited"]?.string{

                           EditedR = Edited
                    }

                    if let EndRemark = dataObj["End Remarks"]?.string{
                        
                        endRemarks = EndRemark
                    }
                    
                    let arrItem = StartDayModel(dayCode: dayCodeR, SalesPersonCode: salesPersonCodeR, SalesPersonName: salesPersonNameR, TransportMode: transportModeR, TransportType: transportTypeR, Headquarter: HQR, City: cityR, Image: imageR, LeaveStatus: leaveStatusR, Edited: EditedR, EndRemarks: endRemarks)

                    self.getDataArr.append(arrItem)

                   
                }
 
            }
            complitionBlock(message)
        }
        
    }
    
    func getBeatDataFromApiHandlerClass(url:String,passDict:[String:Any],complitionBlock:@escaping ([String]) ->()){
        
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if message == "data found"{
                    
                    if let cityArr = responseJSON["dataArray"].arrayObject{
                        
                        if self.getBeatDataArr.count > 0 {
                            self.getBeatDataArr.removeAll()
                        }
                        
                        for item in cityArr{
                            
                            if let itemDict = item as? NSDictionary{
                                
                                var city = String()
                                var beat = String()
                                var stateDescription = String()
                                var stateCode = String()
                                
                                if let City = itemDict.value(forKey: "City") as? String{
                                    
                                    city = City
                                }
                                
                                if let Beat = itemDict.value(forKey: "Beat") as? String{
                                    
                                    beat = Beat
                                }
                                if let statedescription = itemDict.value(forKey: "State Description") as? String{
                                    
                                    stateDescription = statedescription
                                }
                                if let statecode = itemDict.value(forKey: "State Code") as? String{
                                    
                                    stateCode = statecode
                                }
                                self.getBeatDataArr.append(beat)
                                self.getCityDataArr.append(city)
                                self.getStateCodeDataArr.append(stateCode)
                                self.getStateDescriptionDataArr.append(stateDescription)
                            }
                            
                        }
                        
                        self.DictForCityAndBeat.addEntries(from: ["city": self.getCityDataArr])
                        self.DictForCityAndBeat.addEntries(from: ["beat" : self.getBeatDataArr])
                        self.DictForCityAndBeat.addEntries(from: ["stateCode" :self.getStateCodeDataArr ])
                        self.DictForCityAndBeat.addEntries(from: ["stateDescription" :self.getStateDescriptionDataArr])
                        
                        complitionBlock(self.getBeatDataArr)
                    }else{
                        
                        complitionBlock([String]())
                    }
                    
                }
                
            }
        }
    }
    
    func getDataFromApiHandlerClassForStartDay(url:String,passDict:[String:Any],imageData:NSData,message:@escaping (String) ->()){
        
        apiHandler.getDataFromApiWithImageData(withUrl: url, passDict: passDict, imageData: imageData, complitionBlock: { (reponseJSON) in
            
            Indicator.shared.hideProgressView()
                           
            print(reponseJSON)
            let message1 = reponseJSON["message"].string ?? ""
            if reponseJSON["response"].bool == true{
                
                if let dataObj = reponseJSON["dataObj"].dictionary{
                    
                    if self.getDataArr.count > 0 {
                        
                        self.getDataArr.removeAll()
                    }
                    var dayCodeR = Int()
                    var salesPersonCodeR = String()
                    var salesPersonNameR = String()
                    var transportModeR = String()
                    var transportTypeR = String()
                    var HQR = String()
                    var cityR = String()
                    var imageR = String()
                    var leaveStatusR = String()
                    var EditedR = String()
                    var endRemarks = String()
                    if let dayCode = dataObj["Day Code"]?.int{
                        
                        dayCodeR = dayCode
                    }
                    if let salesPersonCode = dataObj["SalesPerson Code"]?.string{
                        
                        salesPersonCodeR = salesPersonCode
                    }
                    if let salesPersonName = dataObj["SalesPerson Name"]?.string{
                        
                        salesPersonNameR = salesPersonName
                    }
                    if let transportMode = dataObj["Transport Mode"]?.string{
                        
                        transportModeR = transportMode
                    }
                    if let transportType = dataObj["Transport Type"]?.string{
                        
                        transportTypeR = transportType
                    }
                    if let HQ = dataObj["Headquarter"]?.string{
                        
                        HQR = HQ
                    }
                    if let city = dataObj["City"]?.string{
                        
                        cityR = city
                    }
                    if let image = dataObj["Image"]?.string{
                        
                        imageR = image
                    }
                    if let leaveStatus = dataObj["Leave Status"]?.string{
                        
                        leaveStatusR = leaveStatus
                    }
                    if let Edited = dataObj["Edited"]?.string{

                           EditedR = Edited
                    }
                    if let EndRemark = dataObj["End Remarks"]?.string{
                        
                        endRemarks = EndRemark
                    }
                    
                    let arrItem = StartDayModel(dayCode: dayCodeR, SalesPersonCode: salesPersonCodeR, SalesPersonName: salesPersonNameR, TransportMode: transportModeR, TransportType: transportTypeR, Headquarter: HQR, City: cityR, Image: imageR, LeaveStatus: leaveStatusR, Edited: EditedR, EndRemarks: endRemarks)
                    
                    self.getDataArr.append(arrItem)
                    
                }
                
            }
            message(message1)
            
        }) { (failureMessage) in
            
            message(failureMessage)
        }
        
        
        
    }
    
    func getDataFromApiHandlerGetTypeApi(strUrl:String,responseMessage:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromGetTypeApi(withUrl: strUrl) { (responseData) in
            
            print(responseData)
            
            let message = responseData["message"].string ?? ""
            
            if responseData["response"].int == 1{
                
                if let dataObjDict = responseData["dataObj"].dictionary{
                    
                    self.startTime = dataObjDict["Start Time"]?.string ?? ""
                    self.endTime = dataObjDict["End Time"]?.string ?? ""
                    
                }
            }
            
            responseMessage(message)
        }
        
    }
    
    
    func setDataOnScreen(index:Int) -> StartDayModel{
        
        let startDayData = getDataArr[index]
        
        return startDayData
    }
    
    
}
