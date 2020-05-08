//
//  ItemDetailsViewModel.swift
//  AIPL ABRO
//
//  Created by CST on 27/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class ItemDetailsViewModel{
    
    let tableArr1 = ["Item","Belt","Tape","CR INAB","Cut of Wheel",""]
    let tableArr2 = ["","Non Moving Amount(120 days)","Customer Overdue Amount","Customer Outstanding","Order in Progress","Order on Hold(Credit Control)","Order on Hold(Account Confirmation)","Order on Hold(In-credit Limit)"]
    
    
    func noOfRowInSection(arr:NSArray) -> Int {
        
        return arr.count
    }
    
    func lblFontColor(lbl:UILabel,text:String, textColor: UIColor, font: String, size: CGFloat){
        
        lbl.setFontAndColor(lbl: lbl, text: text, textColor: textColor, font: font, size: size)
        
    }
}

class DailyRegisterSalesViewModel {
    
   var apiHandler = ApiHandler()
   var plannerArr = [String]()
   var cityArr = [String]()
   var lineNoArr = [String]()
    
    func getDaliyRegisterDataFromApiHandler(strUrl:String,passDict:[String:Any],complition:@escaping (_ responseMessage:String)->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataArray"].arrayObject{
                    
                    var plannerNO = String()
                    var city = String()
                    var lineNo = String()
                    
                    for item in dataArray{
                        
                        if let plannerDict = item as? NSDictionary{
                            
                            if let plannerNo = plannerDict.value(forKey: "Planner No") as? String{
                                
                                plannerNO = plannerNo
                                
                            }
                            
                            if let City = plannerDict.value(forKey: "City") as? String{
                                
                                city = City
                            }
                            
                            if let LineNo = plannerDict.value(forKey: "Line No") as? Int{
                                
                                lineNo = String(LineNo)
                            }
                            
                            self.plannerArr.append(plannerNO)
                            self.cityArr.append(city)
                            self.lineNoArr.append(lineNo)
                        }
                        
                    }
                    
                }
                complition(message)
                
            }else if responseJSON["response"].bool == false{
                
                complition(message)
                
            }
            
        }
        
    }
    
    
    func getDataFromApiHandlerForsecondrySalesCreate(strUrl:String,passDict:[String : Any],responseMessage:@escaping (_ message:String) ->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseData) in
            
            print(responseData)
            responseMessage((responseData["message"].string ?? ""))
            
        }
        
    }
}
