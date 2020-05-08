//
//  DSRReportViewModel.swift
//  AIPL ABRO
//
//  Created by CST on 12/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation


class DSRReportViewModel{
    
  var apiHandler = ApiHandler()
  var url = String()
    
    func getApiDataFromApiHandler(strUrl:String,passDict:[String:Any],responseMessage:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseData) in
            
            print(responseData)
            let message = responseData["message"].string ?? ""
            
            if responseData["response"].bool ?? false == true{
                
                if let dataObj = responseData["dataObj"].dictionary{
                    
                    self.url = dataObj["url"]?.string ?? ""
                    
                }
                
            }
            
            responseMessage(message)
        }
    }
    
}
