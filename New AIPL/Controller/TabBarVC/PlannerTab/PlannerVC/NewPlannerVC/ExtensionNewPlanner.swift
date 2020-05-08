//
//  ExtensionNewPlanner.swift
//  AIPL ABRO
//
//  Created by CST on 22/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

extension NewPlannerVC{
    
//MARK:- DatePicker
//MARK:-
    
    func DatePicker(sender:UIButton,txtFld:UITextField){
        
        self.view.addSubview(baseview)
        self.view.endEditing(true)
        
        let doneButton : UIButton = {
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            btn.tag = 7
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            return btn
        }()
        
        let cancelButton : UIButton = {
            
            let btn = UIButton(frame: CGRect(x: baseview.frame.size.width-100, y: 0, width: 100, height: 50))
            btn.tag = 8
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            return btn
        }()
        view.addSubview(baseview)
        _ = baseview.openDatePicker(sender: sender.tag, baseview: baseview, doneButton: doneButton, cancelButton: cancelButton, txtDate: txtFld)
       
        
    }
    
 //MARK:- Api showPlanner
 //MARK:-
    
    func apishowPlanner(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
           
            let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
            let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? "","month":txtFldMonth.text ?? "","year":txtFldyear.text ?? ""] as [String:Any]
            print("Pass Date \(passDict)")
            Indicator.shared.showProgressView(self.view)
            
            
            getPlannerViewModel.getDataFromApiHandlerClass(url: "showPlanner", passDict: passDict, complitionBlock1: { (_, message) in
                
                if message == "You have not added any data yet"{
                    
                    self.configTable()
                    self.tableView.reloadData()
                }
                
                
            }) { (_, message) in
                
                self.configTable()
                
                if self.plannerType == "add planner"{
                    
                    if message == "data created"{
                        
                        self.tableView.isHidden = true
                        
                        self.alertWithHandler(message: "Data already created!") {
                            
                            self.navigationController?.popViewController(animated: false)
                            
                        }
                        
                    }
                    
                    
                    
                }else if message == "data created" || self.plannerType == "edit planner"{
                    
                    self.setDataOnScreen()
                  
                }
                self.tableView.reloadData()
            }
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
        
    }
   
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
    
    func apiAddOrEditPlanner(){
        
         if InternetConnection.internetshared.isConnectedToNetwork(){

         if arr.count > 0 {
          
            arr.removeAllObjects()
         }
            if plannerType == "edit planner"{
                
                for i in 0..<(getPlannerViewModel.getDataArrForEditList.count){
                    
                    arrStrctEdited.append(EditedPlanner(salesPersonCode: getPlannerViewModel.getEditArr[i].SalesPersonCode, salePersonName: getPlannerViewModel.getEditArr[i].SalesPersonName, plannerDate: getPlannerViewModel.getEditArr[i].plannerDate, plannerDays: getPlannerViewModel.getEditArr[i].plannerDays, city: getPlannerViewModel.getEditArr[i].City, remarks: "", salePersonHQ: userData.value(forKey: "HQ") as? String ?? "", edited: getPlannerViewModel.getEditArr[i].Edited, nightHalt: "0", beat: getPlannerViewModel.getEditArr[i].beat, plannerNo: getPlannerViewModel.getEditArr[i].plannerNo, lineNo: getPlannerViewModel.getEditArr[i].lineNo))
                    
                }
                
            }else{
                
                for i in 0..<(getPlannerViewModel.getDataArr.count){
                    
                    arrStrct.append(Planner(compareDate: getPlannerViewModel.getDataArr[i].compareDate, salesPersonCode: getPlannerViewModel.getDataArr[i].SalesPersonCode, salePersonName: userData.value(forKey: "Name") as? String ?? "", plannerDate: getPlannerViewModel.getDataArr[i].plannerDate, plannerDays: getPlannerViewModel.getDataArr[i].plannerDays, city: getPlannerViewModel.getDataArr[i].City, remarks: "", salePersonHQ: userData.value(forKey: "HQ") as? String ?? "", edited: getPlannerViewModel.getDataArr[i].Edited, nightHalt: "0", beat: getPlannerViewModel.getDataArr[i].beat))
                    
                }
                
            }
             
        let encoder = JSONEncoder()
        do
        {
              let jsonData = try encoder.encode(arrStrct)
              let jsonString = String(data: jsonData, encoding: .utf8)
           
              if self.plannerType == "add planner"{
                
                
                self.fromDate = getPlannerViewModel.getDataArr[0].plannerDate ?? ""
                self.ToDate = getPlannerViewModel.getDataArr[getPlannerViewModel.getDataArr.count - 1].plannerDate ?? ""
                let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? "","salePersonName":userData.value(forKey: "Name") ?? "","salePersonMobile":userData.value(forKey: "PhoneNo") ?? "","salePersonEmail":userData.value(forKey: "EMail") ?? "","fromDate":self.fromDate,"toDate":self.ToDate,"month":txtFldMonth.text ?? "","year":txtFldyear.text ?? "","hq":userData.value(forKey: "HQ") ?? "","planData":jsonString ?? ""] as [String:Any]
                
                print(passDict)
                 
                Indicator.shared.showProgressView(view)
                getPlannerViewModel.addPlannerApi(url:  "addPlannerIOS", passDict: passDict) { (message) in
                    
                    self.alert(message: self.obj.createString(Str: message))
                    
                    if message == "data created"{
                        
                        self.navigationController?.popViewController(animated: false)
                        
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: message))
                        
                    }
                    
                }
                
            } else if self.plannerType == "edit planner"{
                
                let jsonData1 = try encoder.encode(arrStrctEdited)
                let jsonString1 = String(data: jsonData1, encoding: .utf8)
                
                let passDict = ["planData":jsonString1 ?? ""] as [String:Any]
                
                 print(passDict)
                Indicator.shared.showProgressView(view)
                getPlannerViewModel.addPlannerApi(url:  "editPlannerIOS", passDict: passDict) { (message) in
                    
                    if message == "data updated"{
                        
                        self.alertWithHandler(message : message , block: {
                            
                             self.navigationController?.popViewController(animated: false)
                        })
                      
            
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: message))
                        
                    }
                     
                }
                  
            }
               
            
        }
        catch
        {
            
        }
         }else{
            
           self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
    }
    
    //MARK:- Api City Type
    //MARK:-
    
    func apiCity(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
            Indicator.shared.showProgressView(view)
            getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                 
            }
            
        }else{
            
           self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
    }
    
}
