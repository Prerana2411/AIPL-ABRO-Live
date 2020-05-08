//
//  AlamoFireWrapper.swift
//  Monami
//
//  Created by abc on 22/11/18.
//  Copyright © 2018 mobulous. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AlamofireWrapper:NSObject{
    //MARK: - Variables for getting web services
    
    
    public class var sharedInstance: AlamofireWrapper {
        struct Singleton {
            static let instance: AlamofireWrapper = AlamofireWrapper()
        }
        return Singleton.instance
    }
    
    override init() {}
    weak var delegate:WebServiceDelegates?
    let baseURL = "http://13.58.229.225:5002/"
    var responseCode = 0
    
    //MARK:- Methods
    //TODO: For requesting get types url
    
    // MARK: Web Service Methods - POST
       
       func callWebServiceForJsonPost(inParamaters:[String:Any]!, inStringURL:String, inDelegate : AnyObject ) -> Void {
           
           self.delegate = inDelegate as? WebServiceDelegates
        
        let url = baseURL + inStringURL
        
           print("BASE URL : \(inStringURL)",url)
           //.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
        if  InternetConnection.internetshared.isConnectedToNetwork() {
               
               Alamofire.request(url, method: HTTPMethod.post, parameters:inParamaters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                   print(response)
                   switch response.result {
                       
                   case .success(let success) :
                       
                       var optionKey:String? = ""
                       if let reqURL = response.request {
                           
                           if let strURL = (reqURL.url?.absoluteString) {
                               
                               let arrOptionKey : [String] = strURL.components(separatedBy: "/")
                               optionKey = arrOptionKey.last
                           }
                       }
                       if (self.delegate != nil ){
                           
                           //log.debug(optionKey! as Any)
                           //log.debug(success)
                           self.delegate?.didGetResponse!(inResponse: success as AnyObject,withRequest:optionKey!)
                       }
                       
                       break
                       
                   case .failure(let error):
                       
                       if (self.delegate != nil ){
                           
                           self.delegate?.didGetError!(inError: error as AnyObject)
                       }
                       break
                   }
               })
               
           }else{
               self.delegate?.didGetError!(inError: "" as AnyObject)
           }
       }
       
    
    
    func getRequestURL(_ strURL:String, success:@escaping (JSON)-> Void,failure:@escaping (Error) -> Void){
        var strURL =  (strURL as String)
        strURL = baseURL + "\(strURL)"
        print(strURL)
        let urlValue = URL(string: strURL)!
        _ = URLRequest(url: urlValue)
        Alamofire.request(urlValue).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                self.responseCode = 1
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
                
                self.responseCode = 2
            }
        }
    }
    
    //TODO: For requesting post types url
    func postRequestURL(_ strURL : String, params : [String : AnyObject]!, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let urlString = baseURL + (strURL as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("application/xml", forHTTPHeaderField: "Content-Type")
        Alamofire.request(urlValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers:headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                self.responseCode = 1
            }
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                failure(error)
                
                self.responseCode = 2
            }
        }
    }
    
    func postRequestURL1(_ strURL : String, params : [String : AnyObject]!, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let urlString = baseURL + (strURL as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("application/xml", forHTTPHeaderField: "Content-Type")
        Alamofire.request(urlValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers:headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                self.responseCode = 1
            }
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                failure(error)
                
                self.responseCode = 2
            }
        }
    }
    
    //TODO: For requesting post types url
    func postRequestURLFormData(_ strURL : String, params : [String : AnyObject]!, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let urlString = baseURL + (strURL as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                   // print(value)
                    self.responseCode = 1
                    let resJson = JSON(response.result.value!)
                    success(resJson)
                }
            case .failure(let error):
               // print(error)
                self.responseCode = 2
                let error : Error = response.result.error!
                failure(error)
            }
            
        }
    }
    
    func postRequestURLEncoded(_ strURL : String, params : [String : AnyObject]!, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let urlString = baseURL + (strURL as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(urlValue, method: .post, parameters: params, encoding: URLEncoding.default, headers:headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                self.responseCode = 1
            }
            if responseObject.result.isFailure {
                
                let error : Error = responseObject.result.error!
                failure(error)
                
                self.responseCode = 2
            }
        }
    }
    
    
    //TODO: For requesting post types url with file
    func postRequestURLWithFile( imageData:NSData,fileName: String,imageparam:String, urlString:String, parameters : [String : AnyObject]?, headers : [String : String]?,success: @escaping (JSON) -> Void,failure:@escaping (Error) -> Void){
        let urlString = baseURL + (urlString as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        
        if (imageData as? NSData) != nil {
            print("Could not get JPEG representation of UIImage")
            print("data hai")
         }else{
            print("Could not get JPEG representation of UIImage")
            print("data nahi hai")
        }
        
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        Alamofire.upload( multipartFormData: { multipartFormData in
            
            multipartFormData.append(imageData as Data, withName: imageparam, fileName: fileName, mimeType:"image/png")
            
            for (key, value) in parameters! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
        },to: urlString,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if((response.result.value != nil)){
                        self.responseCode = 1
                        let resJson = JSON(response.result.value!)
                        success(resJson)
                    }else{
                        self.responseCode = 2
                        let error : Error = response.result.error!
                        failure(error)
                    }
                }
            case .failure(let encodingError):
                self.responseCode = 2
                print(encodingError)
                let error : Error = encodingError
                failure(error)
              
            }
        })
    }
    
    //TODO: For requesting post types url with file
    func postRequestURLProfileData(imageData:NSData,fileName: String,imageparam:String, imagedocument:NSData,docparam:String,docname:String,urlString:String, parameters : [String : AnyObject]?, headers : [String : String]?,success: @escaping (JSON) -> Void,failure:@escaping (Error) -> Void){
        let urlString = baseURL + (urlString as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        Alamofire.upload( multipartFormData: { multipartFormData in
            
            multipartFormData.append(imageData as Data, withName: imageparam, fileName: fileName, mimeType:"image/png")
            
            multipartFormData.append(imagedocument as Data, withName: docparam, fileName: docname, mimeType: "image/png")
            
           
            
            for (key, value) in parameters! {
                print("Value Sended  ====>",key,value)
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
        },to: urlString,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if((response.result.value != nil)){
                        self.responseCode = 1
                        let resJson = JSON(response.result.value!)
                        success(resJson)
                    }else{
                        self.responseCode = 2
                        let error : Error = response.result.error!
                        failure(error)
                    }
                }
            case .failure(let encodingError):
                self.responseCode = 2
                print(encodingError)
                let error : Error = encodingError
                failure(error)
            }
        })
    }
    
    //For Multiple Image
    
    func postRequestMultipleFormData(fileArr:[NSData],fileName: [String],imageparm:String, urlString:String, parameters : [String : AnyObject]?, headers : [String : String]?,success: @escaping (JSON) -> Void,failure:@escaping (Error) -> Void)
    {
        let urlString = baseURL + (urlString as String)
        print(urlString)
        let urlValue = URL(string: urlString)!
        var request = URLRequest(url: urlValue)
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            //            if imageData.length > 0{
            //               multipartFormData.append(imageData as Data, withName: imageparm, fileName: fileName, mimeType:"image/png")
            //            }
            
            if fileArr.count != 0{
                for i in 0..<fileArr.count{
                    let imagedata = fileArr[i] as Data
                    print("FileName =========>",fileName[i])
                    
                    multipartFormData.append(imagedata as Data, withName: imageparm, fileName: fileName[i], mimeType:"image/png")
                }
            }
            
            for (key, value) in parameters! {
                
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
            
        },to: urlString,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if((response.result.value != nil)){
                        self.responseCode = 1
                        let resJson = JSON(response.result.value!)
                        success(resJson)
                    }else{
                        self.responseCode = 2
                        let error : Error = response.result.error!
                        failure(error)
                    }
                }
            case .failure(let encodingError):
                self.responseCode = 2
                print(encodingError)
                let error : Error = encodingError
                failure(error)
            }
        })
        
        
    }
    
   
}
