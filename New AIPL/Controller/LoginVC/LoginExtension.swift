//
//  LoginExtension.swift
//  AIPL ABRO
//
//  Created by apple on 14/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

extension LoginVC{
    
    //MARK:- Check Validation
    //MARK:-
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertWithHandler(message : String , block:  @escaping ()->Void ){
        
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: {(action : UIAlertAction) in
            
            block()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func emptyText(txtFld: UITextField) {
        
        txtFld.text! = ""
        
    }
    
    func CheckValidation(){
        
        
        
        if txt_UserName.text!.isEmpty{
            
            self.alertWithHandler(message: obj.createString(Str: "User Name cannot be empty")){
                
                self.txt_UserName.becomeFirstResponder()
            }
            
            
        }else if (txt_Password.text?.isEmpty)!{
                
                self.alert(message: obj.createString(Str: "Password cannot be empty"))
                
            }else{
                
                self.connection()
        }
        
    }
    
    //MARK:- APi Implemetio
    //MARK:-
    
    func connection(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
           
            let passData = ["user_name":txt_UserName.text!,"password":txt_Password.text!] as? [NSString:NSObject] ?? [:]
            print(passData)
            Indicator.shared.showProgressView(self.view)
            conn.startConnectionWithSting("login", method_type: .post, params: passData as [NSString : NSObject]) { (responseJSON) in
                
                Indicator.shared.hideProgressView()
                print(responseJSON)
                
                let message = responseJSON.value(forKey: "message") as? String ?? ""
                
                if self.conn.responseCode == 1{
                    
                    if responseJSON.value(forKey: "response") as? Bool ?? false == true{
                        
                        if let dataDict = responseJSON.value(forKey: "dataObj") as? NSDictionary {
                            var CODE = String()
                            var Name = String()
                            var EMail = String()
                            var RSMCode = String()
                            var Zone = String()
                            var HQ = String()
                            var EmployeeLevel = Int()
                            var ApproveCMS = Int()
                            var PhoneNoR = String()
                            
                            if let code = dataDict.value(forKey: "Code") as? String{
                                
                                CODE = code
                                
                            }
                            if let name = dataDict.value(forKey: "Name") as? String{
                                
                                Name = name
                                
                            }
                            if let email = dataDict.value(forKey: "E-Mail") as? String{
                                
                                EMail = email
                                
                            }
                            if let RsmCode = dataDict.value(forKey: "RSM Code") as? String{
                                
                                RSMCode = RsmCode
                                
                            }
                            if let zone = dataDict.value(forKey: "Zone") as? String{
                                
                                Zone = zone
                                
                            }
                            if let Hq = dataDict.value(forKey: "HQ") as? String{
                                
                                HQ = Hq
                                
                            }
                            if let employeeLevel = dataDict.value(forKey: "Employee Level") as? Int{
                                
                                EmployeeLevel = employeeLevel
                                
                            }
                            if let approveCMS = dataDict.value(forKey: "Approve CMS") as? Int{
                                
                                ApproveCMS = approveCMS
                                
                            }
                            if let PhoneNo = dataDict.value(forKey: "Phone No_") as? String{
                                
                                PhoneNoR = PhoneNo
                                
                            }
                            var asmCode = String()
                            if let ASMCode = dataDict.value(forKey: "ASM Code") as? String{
                                
                                asmCode = ASMCode
                                
                            }
                            var asmName = String()
                            if let ASMName = dataDict.value(forKey: "ASM Name") as? String{
                                
                                asmName = ASMName
                                
                            }
                            var rsmCode = String()
                            if let RSMCode = dataDict.value(forKey: "RSM Code") as? String{
                                
                                rsmCode = RSMCode
                                
                            }
                            var rsmName = String()
                            if let RSMName = dataDict.value(forKey: "RSM Name") as? String{
                                
                                rsmName = RSMName
                                
                            }
                            var userType = String()
                            if let businessEntity = dataDict.value(forKey: "Business Entity") as? String{
                                
                                
                                userType = businessEntity == "INAB" ? "0" : "1"
                                
                            }
                            
                            let loginData = ["Code":CODE,
                                "Name":Name,
                                "EMail":EMail,
                                "RSMCode":RSMCode,
                                "Zone":Zone,
                                "HQ":HQ,
                                "EmployeeLevel":EmployeeLevel,
                                "ApproveCMS":ApproveCMS,
                                "PhoneNo":PhoneNoR,
                                "asmCode":asmCode,
                                "asmName":asmName,
                                "rsmCode":rsmCode,
                                "rsmName":rsmName,
                                "UserType":userType
                                ] as [String : Any]
                            
                            print("Login Data",loginData)
                            
                             UserDefaults.standard.set(true, forKey: "Login_Status")
                            
                             UserDefaults.standard.set("corp_flow", forKey: "Login_Flow")
                            
                            UserDefaults.standard.set(loginData, forKey: "loginData")
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                        
                        
                       
                    }else{
                        
                       self.alert(message: message)
                    }
                    
                }else{
                   
                    self.alert(message: "Something went wrong")
                    
                }
                
            }
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
}
