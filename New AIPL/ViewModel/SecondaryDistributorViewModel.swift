//
//  File.swift
//  AIPL ABRO
//
//  Created by CST on 07/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class SecondaryDistributorViewModel{
    
    var apiHandler = ApiHandler()
    var getDistributorArr = [String]()
    var getDistributorCode = [String]()
    var getRetailerArr = [String]()
    var getRetailerCode = [String]()
    var getdistributedchaintModel = [DistributedChainModel]()
    var getdistributorSecSalesModel = [distributorSecondarySalesModel]()
    
    func getDistributorListDataFormApiHandler(strUrl:String,passDict:[String:Any],responseMessage:@escaping (_ message:String) -> ()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseData) in
            
            print(responseData)
            
            let message = responseData["message"].string ?? ""
            
            if responseData["response"].bool ?? false == true{
                
                if let dataArray = responseData["dataArray"].arrayObject {
                    
                    if self.getDistributorArr.count > 0{
                        
                        self.getDistributorArr.removeAll()
                        self.getDistributorCode.removeAll()
                        
                    }
                    
                    for item in dataArray{
                        
                        if let itemDict = item as? NSDictionary{
                            
                            let name = itemDict.value(forKey: "Name") as? String ?? ""
                            let code = itemDict.value(forKey: "No_") as? String ?? ""
                            
                            self.getDistributorArr.append(name)
                            self.getDistributorCode.append(code)
                        }
                        
                    }
                }
                
            }
            
            responseMessage(message)
            
        }
        
    }
    
    func getRetailerListDataFormApiHandler(strUrl:String,passDict:[String:Any],responseMessage:@escaping (_ message:String) -> ()){
           
           apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseData) in
               
               print(responseData)
               
               let message = responseData["message"].string ?? ""
               
               if responseData["response"].bool ?? false == true{
                   
                   if let dataArray = responseData["dataArray"].arrayObject {
                       
                       if self.getRetailerArr.count > 0{
                           
                           self.getRetailerArr.removeAll()
                           self.getRetailerCode.removeAll()
                           
                       }
                       
                       for item in dataArray{
                           
                           if let itemDict = item as? NSDictionary{
                               
                               let name = itemDict.value(forKey: "Retailer Name") as? String ?? ""
                               let code = itemDict.value(forKey: "No_") as? String ?? ""
                               
                               self.getRetailerArr.append(name)
                               self.getRetailerCode.append(code)
                           }
                           
                       }
                   }
                   
               }
               
               responseMessage(message)
               
           }
           
       }
    
    func getApisecSalesDataResponseFromApiHandler(strUrl:String,passDict:[String:Any],responseMessage:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseData) in
            
            print(responseData)
            
            let message = responseData["message"].string ?? ""
            
            if responseData["response"].bool ?? false == true{
                
                if let dataArray = responseData["dataArray"].arrayObject{
                    
                    if self.getdistributedchaintModel.count > 0 {
                        
                        self.getdistributedchaintModel.removeAll()
                    }
                    
                    for item in dataArray{
                        
                        if let itemDict = item as? NSDictionary{
                            
                            let plannerLineNo = itemDict.value(forKey: "Planner Line No") as? Int ?? 0
                            let RetailerCode = itemDict.value(forKey: "Retailer Code") as? String ?? ""
                            let plannerNo = itemDict.value(forKey: "Planner No") as? String ?? ""
                            let RetailerName = itemDict.value(forKey: "Retailer Name") as? String ?? ""
                            let actualQuantity = itemDict.value(forKey: "Quantity") as? Int ?? 0
                            let plannerCity = itemDict.value(forKey: "Planner City") as? String ?? ""
                            let plannerDate = itemDict.value(forKey: "Planner Date") as? String ?? ""
                            let createDate = itemDict.value(forKey: "Create Date") as? String ?? ""
                            let orderStatus = itemDict.value(forKey: "Order Status") as? Int ?? 0
                            let tagedCustomerCode = itemDict.value(forKey: "Taged_Customer_Code") as? String ?? ""
                            let Item = itemDict.value(forKey: "Item") as? String ?? ""
                            let itemCategory = itemDict.value(forKey: "Item Category") as? String ?? ""
                            let month = itemDict.value(forKey: "Month") as? String ?? ""
                            let year = itemDict.value(forKey: "Year") as? String ?? ""
                            
                            let modelItem = DistributedChainModel(year: year, month: month, tagedCustomerCode: tagedCustomerCode, orderQuantity: orderStatus == 0 ? "0" : "" , actualQuantity: String(actualQuantity), itemCategory: itemCategory, orderStatus: String(orderStatus), createDate: createDate, retailerCode: RetailerCode, plannerDate: plannerDate, plannerCity: plannerCity, plannerNo: plannerNo, plannerLineNo: String(plannerLineNo), retailerName: RetailerName, Item: Item)
                            self.getdistributedchaintModel.append(modelItem)
                        }
                        
                    }
                    
                }
                
            }
            
            responseMessage(message)
            
        }
    
    }
    
    func noOfRowInScetion() ->Int{
        
        return getdistributedchaintModel.count + 1
    }
}
