//
//  ApiHandler.swift
//  AIPL ABRO
//
//  Created by CST on 21/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
import SwiftyJSON
class ApiHandler {
    
    func getDataFromApi(withUrl strUrl : String ,passDict:[String:Any],complitionBlock:@escaping (JSON) ->() ){
        
        AlamofireWrapper.sharedInstance.postRequestURLFormData(strUrl, params: passDict as [String:AnyObject], headers: nil, success: { (responseJSON) in
            
            print(responseJSON)
            
            Indicator.shared.hideProgressView()
            complitionBlock(responseJSON)
            
        }) { (error) in
            Indicator.shared.hideProgressView()
            print(error.localizedDescription)
        }
        
    }
    
    func getDataFromGetTypeApi(withUrl strUrl : String,complitionBlock:@escaping (JSON) ->()) {
        
        AlamofireWrapper.sharedInstance.getRequestURL(strUrl, success: { (responseJSON) in
            
            print(responseJSON)
            
            Indicator.shared.hideProgressView()
            complitionBlock(responseJSON)
            
        }) { (error) in
            
            print(error.localizedDescription)
            
        }
        
    }
    
    func getDataFromApiWithImageData(withUrl strUrl : String ,passDict:[String:Any],imageData:NSData,complitionBlock:@escaping (JSON) ->(),failure:@escaping (_ message:String) ->()){
        
        AlamofireWrapper.sharedInstance.postRequestURLWithFile(imageData: imageData, fileName: "image.png", imageparam: "image", urlString: strUrl, parameters: passDict as [String:AnyObject], headers: nil, success: { (responseJSON) in
            
            print(responseJSON)
            
            Indicator.shared.hideProgressView()
            complitionBlock(responseJSON)
            
        }) { (error) in
            Indicator.shared.hideProgressView()
            print(error.localizedDescription)
            failure("SomeThing went Wrong!!")
        }
    }
    
    func getDataFromApi1(withUrl strUrl : String ,passDict:[String:Any],complitionBlock:@escaping (JSON) ->() ){
           
        AlamofireWrapper.sharedInstance.callWebServiceForJsonPost(inParamaters: passDict, inStringURL: strUrl, inDelegate: self)
           
       }
   
}
