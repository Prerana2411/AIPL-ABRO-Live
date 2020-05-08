//
//  StartYourDayExtension.swift
//  AIPL ABRO
//
//  Created by apple on 14/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

extension StartYourDayVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //MARK:- Api Implementation
    //MARK:-City Api
    
    func cityApiCall(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
            print(passData)
            Indicator.shared.showProgressView(self.view)
            
            getStartDayViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                
               Indicator.shared.hideProgressView()
                
                 DispatchQueue.main.async {
                
                    if (self.getStartDayViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []).count > 0 {
                    self.dropSH.dropTxtFld.optionArray = self.getStartDayViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []
                    self.dropDownSelect(txtfld:self.dropSH.dropTxtFld)
                    self.dropSH.dropTxtFld.showList()
                    
                }
              }
            }
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
    }
    
    //MARK:- Api addDayStart Call
    
    func apiaddDayStart(apiType strUrl:String,passData:[String:Any]){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            print(passData)
           
            Indicator.shared.showProgressView(self.view)
            
            getStartDayViewModel.getDataFromApiHandlerClassForStartDay(url: strUrl, passDict: passData, imageData: self.imageData) { (responseMessage) in
                
                self.alertWithHandler(message: self.obj.createString(Str: responseMessage)) {
                    
                    self.navigationController?.popViewController(animated: false)
                    
                }
                
            }
            
//            getStartDayViewModel.getDataFromApiHandlerClassForStartDay(url: strUrl, passDict: passData, imageData: self.imageData, complitionBlock: { (_) in
//            
//                UserDefaults.standard.set(true, forKey: "isDayStarted")
//                self.navigationController?.popViewController(animated: false)
//                
//            }) { (message) in
//                
//                self.alert(message: self.obj.createString(Str: message))
//                
//            }

        }else{
             self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
   
    
    
    //MARK:- Api getStartDayDetails
    
    func apigetStartDayDetails(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["dayCode":self.dayCode] as [String:Any]
            
            print(passDict)
            
            Indicator.shared.showProgressView(self.view)
            
            getStartDayViewModel.getDataFromApiHandlerClass(url: "getStartDayDetails", passDict: passDict) { (_) in
                
                Indicator.shared.hideProgressView()
                
                DispatchQueue.main.async {
                  
                    let dataFromApi = self.getStartDayViewModel.setDataOnScreen(index: 0)
                    
                    print(dataFromApi.City!)
                    
                    self.setDataOnScreen(ModeOfTransport: dataFromApi.TransportMode ?? "", TypeOfTransport: dataFromApi.TransportType ?? "", TravelType: dataFromApi.Headquarter ?? "", city: dataFromApi.City ?? "", imageUrl: self.obj.imageStartDay + (dataFromApi.Image ?? "") )
                }
            }
             
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    
    func setDataOnScreen(ModeOfTransport:String,TypeOfTransport:String,TravelType:String,city:String,imageUrl:String){
        
        self.dropTT.dropTxtFld.text = ModeOfTransport
        self.dropMT.dropTxtFld.text = TypeOfTransport
        self.dropTrType.dropTxtFld.text = TravelType
        self.dropSH.dropTxtFld.text = city
        self.imageView.setImageWith(URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "my account "))
        TypeOfTransport == " self" || TypeOfTransport == "Self" ? setDocumentConstraint() : self.setConstriantSubmit(top: dropSH.bottomAnchor, distTop: 35)
        
        
    }
    
    //MARK:- Validation
    
    func CheckValidation(){
        
        if dropMT.dropTxtFld.text!.isEmpty{
           
            self.alertWithHandler(message: obj.createString(Str: "Please Select Mode of Transport")){
                
                self.dropMT.dropTxtFld.becomeFirstResponder()
            }
            
        }else if dropTT.dropTxtFld.text!.isEmpty{
            
            self.alertWithHandler(message: obj.createString(Str: "Please Select Type of Transport")){
                
                self.dropTT.dropTxtFld.becomeFirstResponder()
            }
            
        }else if dropTrType.dropTxtFld.text!.isEmpty{
            
            self.alertWithHandler(message: obj.createString(Str: "Please Fill Travel Type")){
                
                self.dropTrType.dropTxtFld.becomeFirstResponder()
            }
            
        }else if dropSH.dropTxtFld.text!.isEmpty{
            
            self.alertWithHandler(message: obj.createString(Str: "Please Fill City Field")){
                
                self.dropSH.dropTxtFld.becomeFirstResponder()
            }
        }else{
            
            
            if self.lat.isEmpty{
                
                self.initializeTheLocationManager()
                
            }else{
              
            if self.dayCode != 0 {
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? "",
                                           "salesPersonName":userData.value(forKey: "Name") ?? "",
                                           "dayDate":formatter.string(from: date),
                                           "transportMode":"\(dropTT.dropTxtFld.text ?? "")",
                                           "transportType":"\(dropMT.dropTxtFld.text ?? "")",
                                           "headquarter":"\(dropTrType.dropTxtFld.text ?? "")",
                                           "city":"\(dropSH.dropTxtFld.text ?? "")",
                                           "dayCode":String(self.dayCode),
                                           "startLat":self.lat,
                                           "startLong":self.long,
                                           "zone":userData.value(forKey: "Zone") ?? "",
                                           "BusinessEntity":userData.value(forKey: "UserType") ?? ""
                               ] as [String:Any]
                           
               self.apiaddDayStart(apiType: "editDayStart", passData: passData)
            }else if !self.remark.isEmpty{
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? "",
                                           "salesPersonName":userData.value(forKey: "Name") ?? "",
                                           "dayDate":formatter.string(from: date),
                                           "transportMode":"\(dropMT.dropTxtFld.text ?? "")",
                                           "transportType":"\(dropTT.dropTxtFld.text ?? "")",
                                           "headquarter":"\(dropTrType.dropTxtFld.text ?? "")",
                                           "city":"\(dropSH.dropTxtFld.text ?? "")",
                                           "remarks":self.remark
                               ] as [String:Any]
                
                self.apiaddDayStart(apiType: "addDayStart", passData: passData)
                
            }else{
                
                 let date = Date()
                 let formatter = DateFormatter()
                 formatter.dateFormat = "yyyy-MM-dd"
                 let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? "",
                                            "salesPersonName":userData.value(forKey: "Name") ?? "",
                                            "dayDate":formatter.string(from: date),
                                            "transportMode":"\(dropMT.dropTxtFld.text ?? "")",
                                            "transportType":"\(dropTT.dropTxtFld.text ?? "")",
                                            "headquarter":"\(dropTrType.dropTxtFld.text ?? "")",
                                            "city":"\(dropSH.dropTxtFld.text ?? "")",
                                            "startLat":self.lat,
                                            "startLong":self.long,
                                            "zone":userData.value(forKey: "Zone") ?? "",
                                            "BusinessEntity":userData.value(forKey: "UserType") ?? ""
                                ] as [String:Any]
                            
                self.apiaddDayStart(apiType: "addDayStart", passData: passData)
            }
            }
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
    
    func emptyText(txtFld: UITextField) {
        
        txtFld.text! = ""
        
    }
    
    
    // MARK:- IMAGEPICKER DELEGATE
    //MARK:-
    
    func openActionSheet() {
        
        let alert:UIAlertController=UIAlertController(title: obj.createString(Str: "Choose Image"), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: obj.createString(Str: "Camera"), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: obj.createString(Str: "Gallery"), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: obj.createString(Str: "Cancel"), style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openCamera() {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }else {
            
            let alert = UIAlertController(title: obj.createString(Str: "KwikDokita"), message: obj.createString(Str: "You don't have camera"), preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: obj.createString(Str: "OK"), style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
             if let imageData = chosenImage.jpegData(compressionQuality: 1.0) as NSData? {
                self.imageData = imageData
                self.imageView.image = chosenImage
                       }else{
                           print("imageData nahi aaya gya")
                       }
            
            
        } else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}

