//
//  WebService.swift
//  AIPL ABRO
//
//  Created by apple on 14/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
import Foundation
import UIKit

import AFNetworking

//enum methodType {
//    
//    case post,get
//}

class WebService {
    
    //init(){}
    
    var responseCode = 0;
    
    let obj = CommonClass.sharedInstance
    
    func startConnectionWithText(_ getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void ) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
            
            //  manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            
            manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
            
            let url = self.obj.baseURL + (getUrlString as String)
            
            print(url, getParams)
            
            manager.post(url as String, parameters: getParams, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
                
            },
                         
                         failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
                            
                            self.responseCode = 2
                            
                            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                            
                            outputBlock(errorDist);
                            
                            print("Error: " + (error?.localizedDescription)!)
                            
            })
            
        }
    }
    
    func startConnectionWithSting(_ getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void ) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            // manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
            
            manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
            
            //   manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            
            let url = self.obj.baseURL + (getUrlString as String)
            
            print(url, getParams)
            
            manager.post(url as String, parameters: getParams, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
                
            },
                         
                         
                         
                         failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
                            
                            self.responseCode = 2
                            
                            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                            
                            outputBlock(errorDist);
                            
                            print("Error: " + (error?.localizedDescription)!)
                            
            })
            
        }
    }
    
    // MARK: POST WEBSERVICE WITH DICTIONARY TYPE PARAM
    
    
    func startConnectionWithSting_ForDictonary(_ getUrlString:NSString ,method_type:methodType, params getParams:[String:String],outputBlock:@escaping (_ receivedData:NSDictionary)->Void ) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
            
            manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
            
            //   manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            
            let url = self.obj.baseURL + (getUrlString as String)
            
            print(url, getParams)
            
            manager.post(url as String, parameters: getParams, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
                
            },
                         
                         failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
                            
                            self.responseCode = 2
                            
                            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                            
                            outputBlock(errorDist);
                            
                            print("Error: " + (error?.localizedDescription)!)
                            
            })
            
        }
    }
    
    //  Mark service for Document Picker
    
    func startConnectionWithFile(imageData:NSData,fileName:String,filetype:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
        
        manager.requestSerializer.timeoutInterval = 180
        
        let url = self.obj.baseURL + (getUrlString as String)
        
        print(url, getParams)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: filetype)
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    // method for split dictionary & then upload a document
    
    
    func startConnectionWithFile_uploadDict(imageData:NSData,fileName:String,filetype:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[String:String],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
       // manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
        
        manager.requestSerializer.timeoutInterval = 180
        
        let url = self.obj.baseURL + (getUrlString as String)
        
        print(url, getParams)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: filetype)
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    
    
    
    // for two documents uploadation
    
    
    func startConnectionWithFile1(imageData:NSData,imageData1:NSData,fileName:String,fileName1:String,filetype:String,filetype1:String,imageparm:String,imageparm1:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.requestSerializer.timeoutInterval = 180
        
        let url = self.obj.baseURL + (getUrlString as String)
        
        print(url, getParams)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: filetype)
            
            formData!.appendPart(withFileData: imageData1 as Data, name:imageparm1, fileName: fileName1, mimeType: filetype1)
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    
    //    func otpConnection(_ getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void ) {
    //
    //        DispatchQueue.global().async {
    //
    //            let manager = AFHTTPRequestOperationManager()
    //
    //            manager.operationQueue.cancelAllOperations()
    //
    //            manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as Set<NSObject>
    //
    //            //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
    //
    //            //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
    //
    //            let url = MsgUrl// + (getUrlString as String)
    //
    //            print(url)
    //
    //            manager.post(url as String, parameters: getParams, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
    //
    //                if(responseObject != nil){
    //
    //                    self.responseCode = 1
    //
    //                    outputBlock(responseObject! as! NSDictionary);
    //
    //                    // print("JSON: " + responseObject.description)
    //                }
    //
    //            },
    //
    //                         failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
    //
    //                            self.responseCode = 2
    //
    //                            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
    //
    //                            outputBlock(errorDist);
    //
    //                            print("Error: " + (error?.localizedDescription)!)
    //
    //            })
    //
    //        }
    //    }
    //
    func startConnectionWithStringGetTypeGoogle(getUrlString: NSString, outputBlock: @escaping (_ receivedData:NSDictionary)->Void) {
        
        
        
        let manager = AFHTTPRequestOperationManager()
        
        
        
        manager.operationQueue.cancelAllOperations()
        
        
        
        manager.requestSerializer.timeoutInterval = 180
        
        
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        
        let url = (getUrlString as String)
        
        manager.get(url as String, parameters: nil, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
            
            
            
            if(responseObject != nil){
                
                
                
                self.responseCode = 1
                
                
                
                outputBlock(responseObject! as! NSDictionary)
                
                
                
            }
            
            
            
        }, failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
            
            
            
            self.responseCode = 2
            
            
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            
            
            outputBlock(errorDist)
            
            
            
        })
        
    }
    
    
    
    func startConnectionWithfile(_ imageData:Data,fileName:String,filetype:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            
            //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            
            let url = self.obj.baseURL + (getUrlString as String)
            
            print(url, getParams)
            
            manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
                //code
                formData!.appendPart(withFileData: imageData, name: "file", fileName: fileName, mimeType: filetype)
            }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any!) -> Void in
                
                print(responseObject)
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
                
            }, failure: { (operation:AFHTTPRequestOperation?, error: Error?) -> Void in
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                
                outputBlock(errorDist);
                
                print(error!)
                
            })
            
        }
        
    }
    
    // get type webservice
    
    func startConnectionWithStringGetType(getUrlString:NSString ,outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = self.obj.baseURL + (getUrlString as String)
        
        
        manager.get(url as String, parameters: nil, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
        }, failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + (error?.localizedDescription)!)
        })
    }
    
    
    func startConnectionWithData(imageData:NSData,fileName:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        //5555 = NSSet(object: "text/html") as Set<NSObject>
        
        manager.requestSerializer.timeoutInterval = 180
        
        let url = self.obj.baseURL + (getUrlString as String)
        
        print(url, getParams)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: "image/jpeg")
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    func startConnectionWithfile1(_ imageData:NSArray,fileName:String,filetype:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
            
            // manager.responseSerializer.acceptableContentTypes = (manager.responseSerializer.acceptableContentTypes + Set<AnyHashable>(["text/html"]))
            
            
            let url = self.obj.baseURL + (getUrlString as String)
            
            print(url, getParams)
            
            manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
                //code
                
                for i in 0..<imageData.count{
                    
                    let imagedata:Data = imageData[i] as! Data
                    
                    let strname = String(format: "name%@", i)
                    
                    formData?.appendPart(withFileData: imagedata, name: strname, fileName: fileName, mimeType: filetype)
                    
                }
                
            }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any!) -> Void in
                
                print(responseObject)
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    print("JSON: " + (responseObject as AnyObject).description)
                }
                
            }, failure: { (operation:AFHTTPRequestOperation?, error:Error?) -> Void in
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                
                outputBlock(errorDist);
                
                print(error!)
                
            })
            
        }
    }
    
    
    
}

