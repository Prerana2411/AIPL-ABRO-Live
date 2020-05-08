//
//  ExtensionSecondaryDistributor.swift
//  AIPL ABRO
//
//  Created by CST on 07/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

//MARK:- Api implementation distributerRetailer and distributerList
//MARK:-

extension SecondaryAndDistributedVC{
    
    func apidistributerList(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["salesPersoneCode":"AUTO-N-013"] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            self.getSecDistViewModel.getDistributorListDataFormApiHandler(strUrl: "distributerList", passDict: passDict, responseMessage: { (responseMessage) in
                
                print(responseMessage)
                
                if responseMessage == "Data found"{
                    
                }else{
                    
                    self.alert(message: CommonClass.sharedInstance.createString(Str: responseMessage))
                }
                
            })
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
        
    }
    
    
    func apidistributerRetailer(taggedCustomerCode:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["taggedCustomerCode":taggedCustomerCode] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            self.getSecDistViewModel.getRetailerListDataFormApiHandler(strUrl: "distributerRetailer", passDict: passDict) { (responseMessage) in
                
                if responseMessage == "Data found"{
                    
                    
                }else{
                    
                    self.alert(message: self.obj.createString(Str: responseMessage))
                }
                
            }
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
    }
    
    func apisecSalesData(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
           // let passDict = ["retailerCode":self.retailerCode,"month":self.txt_Month.text ?? "","year":self.txt_Year.text ?? ""] as [String:Any]
            let passDict = ["retailerCode":"R-00076092","month":"2","year":"2020"] as [String:Any]
            
            print(passDict)
            
            Indicator.shared.showProgressView(view)
            
            self.getSecDistViewModel.getApisecSalesDataResponseFromApiHandler(strUrl: "secSalesData", passDict: passDict) { (responseMessage) in
                
                print(responseMessage)
                
                if responseMessage == "Data found"{
                    
                    self.tableView.isHidden = false
                    self.configTable()
                    
                }else{
                  
                    self.alert(message: self.obj.createString(Str: responseMessage))
                    
                }
                
            }
            
        }else{
            
           self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    //MARK:- Api secSalesChainCreateIOS
    //MARK:-
    
    func apisecSalesChainCreateIOS(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            for i in 0..<(self.getSecDistViewModel.getdistributedchaintModel.count){
                
                self.arrForsecSalesChainCreate.append(DistributedChainModel(year: self.getSecDistViewModel.getdistributedchaintModel[i].year, month: self.getSecDistViewModel.getdistributedchaintModel[i].month, tagedCustomerCode: self.getSecDistViewModel.getdistributedchaintModel[i].tagedCustomerCode, orderQuantity: self.getSecDistViewModel.getdistributedchaintModel[i].orderQuantity, actualQuantity: self.getSecDistViewModel.getdistributedchaintModel[i].actualQuantity, itemCategory: self.getSecDistViewModel.getdistributedchaintModel[i].itemCategory, orderStatus: self.getSecDistViewModel.getdistributedchaintModel[i].orderStatus, createDate: self.getSecDistViewModel.getdistributedchaintModel[i].createDate, retailerCode: self.getSecDistViewModel.getdistributedchaintModel[i].retailerCode, plannerDate: self.getSecDistViewModel.getdistributedchaintModel[i].plannerDate, plannerCity: self.getSecDistViewModel.getdistributedchaintModel[i].plannerCity, plannerNo: self.getSecDistViewModel.getdistributedchaintModel[i].plannerNo, plannerLineNo: self.getSecDistViewModel.getdistributedchaintModel[i].plannerLineNo, retailerName: self.getSecDistViewModel.getdistributedchaintModel[i].retailerName, Item: self.getSecDistViewModel.getdistributedchaintModel[i].Item))
                
            }
            
            let encoder = JSONEncoder()
            do
            {
                let jsonData = try encoder.encode(arrForsecSalesChainCreate)
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                let passDict = ["dataArray":jsonString ?? ""] as [String:Any]
                
                print(passDict)
                                
                Indicator.shared.showProgressView(view)
                
                self.getSecDistViewModel.getApisecSalesDataResponseFromApiHandler(strUrl: "secSalesChainCreateIOS", passDict: passDict) { (message) in
                    
                    print(message)
                    
                    if message == "Data created"{
                        
                        self.alertWithHandler(message: self.obj.createString(Str: message)) {
                            
                            self.navigationController?.popViewController(animated: false)
                            
                        }
                        
                        
                    }else{
                        
                        self.alert(message:  self.obj.createString(Str: message))
                    }
                    
                }
                
                
            }catch{
                
            }
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
            
        }
        
    }
    
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
    
    //MARK:- DropDown DataSource
    //MARK:-
    func dropDownDataSource(dataSource:[String],txtFld:UITextField,anchorView:UIView){
        
        
        DispatchQueue.main.async {
            
            if dataSource.count > 0 {
                
                if self.dropDown.dataSource.count > 0 {
                    
                    self.dropDown.dataSource.removeAll()
                }
                
                self.getRetailerViewModel.dropDownDelegate(textField: txtFld,view:anchorView, dropDown: self.dropDown)
                self.dropDown.dataSource = dataSource
                self.getRetailerViewModel.delegate = self
                self.dropDown.show()
                
            }
        }
        
    }
    
   
    
}

extension SecondaryAndDistributedVC:NewRetailerVCDelegate,ValueDelegate{
    
    
    func getValue(text: String, index: Int) {
        
        self.getSecDistViewModel.getdistributedchaintModel[index].orderQuantity = text
        
    }
    
    func index(index: Int, text: String) {
        
        if type == "Distributor"{
           
            apidistributerRetailer(taggedCustomerCode:self.getSecDistViewModel.getDistributorCode[index])
            
        }
        if type == "Retailer" {
            
           self.retailerCode = self.getSecDistViewModel.getRetailerCode[index]
            
        }
        if text == "No" || text == "Yes"{
            
            self.getSecDistViewModel.getdistributedchaintModel[index].orderStatus = text == "Yes" ? "1":"0"
            
        }
        print(index)
    }
    
}
