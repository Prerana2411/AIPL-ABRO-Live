//
//  ExtensionRetailerDetails.swift
//  AIPL ABRO
//
//  Created by CST on 27/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

extension NewRetailerVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate,NewRetailerVCDelegate{
    
    
    
    //MARK:- Api retailerDetails
    //MARK:-
    
    func apiretailerDetails(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["retailerNumber":self.retailerNumber] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            self.getRetailerViewModel.getRetailerDetailDataFromApiHandler(strUrl: "retailerDetails", passDict: passDict) { (message) in
                
                print(message)
                
                if message == "Data found"{
                    
                    self.setDataOnScreen()
                }else{
                    
                    self.alert(message: self.obj.createString(Str: message))
                }
                
                
            }
        }else{
            
            alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
            
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
    
    func setDataOnScreen(){
        
        self.textFld_RN.text = getRetailerViewModel.getRetailerName()
        self.lbl_HQ.text = getRetailerViewModel.getHQ()
        self.lbl_State.text = getRetailerViewModel.getState()
        self.lbl_City.text = getRetailerViewModel.getCity()
        self.lbl_Beat.text = getRetailerViewModel.getBeat()
        self.lbl_Cust.text = getRetailerViewModel.getCustType()
        self.lbl_Address.text = getRetailerViewModel.getAddress()
        self.lbl_Email.text = getRetailerViewModel.getEmail()
        self.lbl_ContNum.text = getRetailerViewModel.getContactNumber()
        self.lbl_ContPerson.text = getRetailerViewModel.getContPerson()
        self.lbl_Tagged.text = getRetailerViewModel.getTagCust()
        self.lbl_Segment.text = getRetailerViewModel.getSegment()
        self.lbl_ClassFication.text = getRetailerViewModel.getRetailerDetailArr[0].Classification
        self.lbl_Potential.text = getRetailerViewModel.getRetailerDetailArr[0].Potential
        self.lbl_GSTNum.text = getRetailerViewModel.getRetailerDetailArr[0].GSTNumber
        self.lbl_ComBrand.text = getRetailerViewModel.getRetailerDetailArr[0].CompBrand
        self.imgView.setImageWith(URL(string: "\(obj.retailerImageUrl)\(getRetailerViewModel.getRetailerDetailArr[0].Image)")!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        self.lat = getRetailerViewModel.getRetailerDetailArr[0].lat
        self.long = getRetailerViewModel.getRetailerDetailArr[0].Long
        self.CustomerType = getRetailerViewModel.getRetailerDetailArr[0].CustomerType
        self.tagCustomerCode = getRetailerViewModel.getRetailerDetailArr[0].TaggedCustomerCode
        self.createdDate = getRetailerViewModel.getRetailerDetailArr[0].CreateDate
        self.NoSeries = getRetailerViewModel.getRetailerDetailArr[0].NoSeries
        self.TelexNo = getRetailerViewModel.getRetailerDetailArr[0].TelexNo
        self.StateCode = getRetailerViewModel.getRetailerDetailArr[0].StateCode
        
        if let imageData = imgView.image!.jpegData(compressionQuality: 1.0) as NSData? {
            
            self.imageData = imageData
            
        }
        
       
        
    }
    
    //MARK:- Api customerBlocked
    //MARK:-
    
    internal func apicustomerBlocked(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
           
            let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? ""] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            getRetailerViewModel.getTaggedCustomeDataFromApiHandler(strUrl: "customerBlocked", passDict: passDict) { (message) in
                
                if message == "Data found"{
                    
                    self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "taggedCustomerName") as? [String] ?? []), txtFld: self.lbl_Tagged, anchorView: self.TaggedView)
                    
                }else{
                    
                    self.alert(message: message)
                }
                
            }
            
        }else{
            
            
        }
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

            let alert = UIAlertController(title: obj.createString(Str: "AIPL-ABRO"), message: obj.createString(Str: "You don't have camera"), preferredStyle: UIAlertController.Style.alert)

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
              imgView.image = chosenImage
              initializeTheLocationManager()
               
            }else{
                print("imageData nahi aaya gya")
            }
       } else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)

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
    
   //MARK:- Validation
   //MARK:-
    
    func validation() {
        
        var validationMessage = ""
        
        if textFld_RN.text!.isEmpty{
            
        validationMessage = obj.createString(Str:"Please Enter Retailer Name!")
            
        }else if lbl_HQ.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter HQ!")
        }else if lbl_City.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select City!")
        }else if lbl_State.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter State!")
        }else if lbl_Beat.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select Beat!")
        }else if lbl_Cust.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select Customer Type!")
        }else if lbl_Address.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Address!")
        }else if lbl_Email.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Email-Address!")
        }else if !Validation().isValidEmail(lbl_Email.text!){
            
            validationMessage = obj.createString(Str:"Please Enter Valid Email-Address!")
        }
        else if lbl_ContNum.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Contact Number!")
            
        }else if !Validation().isValidPhoneNumber(lbl_ContNum.text!){
            
            validationMessage = obj.createString(Str:"Please Enter Valid Contact Number!")
        }
        else if lbl_ContPerson.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Contact Person")
        }else if lbl_Tagged.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select Tagged Customer!")
        }else if lbl_ClassFication.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select Classification!")
        }else if lbl_Potential.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Potential!")
        }else if lbl_GSTNum.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter GST Number!")
            
        }else if lbl_Segment.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Select Segment!")
            
        }else if lbl_ComBrand.text!.isEmpty{
            
            validationMessage = obj.createString(Str:"Please Enter Competitor Brand!")
        }
        
        if validationMessage.isEmpty{
           
            // Call Add Retailer Apii
            
            apiaddRetailer()
            
        }else{
            
            alert(message: validationMessage)
        }
    }
    
    //MARK:- Call addRetailer Api
    //MARK:-
    
    func apiaddRetailer(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passData = ["No":self.retailerNumber,"retailerName":self.textFld_RN.text!,"RetailerAddress":lbl_Address.text!,"DSRCity":lbl_City.text!,"PostCode":"1","StateCode":self.StateCode,"EMail":lbl_Email.text!,"MobileNo":lbl_ContNum.text!,"ContactPerson":lbl_ContPerson.text!,"SalePersonCode":userData.value(forKey: "Code") ?? "","SalePersonEMail":userData.value(forKey: "EMail") ?? "","ASMCode":userData.value(forKey: "asmCode") ?? "","RSMCode":userData.value(forKey: "rsmCode") ?? "","ASMName":userData.value(forKey: "asmName") ?? "","RSMName":userData.value(forKey: "rsmName") ?? "","Zone":userData.value(forKey: "Zone") ?? "","HQ":self.lbl_HQ.text!,"Segment":self.lbl_Segment.text!,"CustomerType":self.CustomerType,"CreateDate":self.createdDate,"NoSeries":self.NoSeries,"SegmentName":self.lbl_Segment.text!,"CustomerTypeName":self.lbl_Cust.text!,"TaggedCustomerCode":self.tagCustomerCode,"TaggedCustomerName":self.lbl_Tagged.text!,"Beat":self.lbl_Beat.text!,"PhoneNo":"","TelexNo":self.TelexNo,"StateDescription":"","LAT":self.lat,"LONG":self.long,"CLASSIFICATION":self.lbl_ClassFication.text!,"POTTENTIAL":self.lbl_Potential.text!,"GST":self.lbl_GSTNum.text!,"SEGMENT":self.lbl_Segment.text!,"COMPETITORBRAND":self.lbl_ComBrand.text!,"UserType":userData.value(forKey: "UserType") ?? ""] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            getRetailerViewModel.getRetailerAddEditFromApiHandler(strUrl: self.apiName, passDict: passData, imageData: imageData) { (message) in
                
                if message == "SomeThing went Wrong!!"{
                   
                    self.alert(message: self.obj.createString(Str: message))
                    
                }else if message == "data inserted" || message == "data updated"{
                   
                    self.navigationController?.popViewController(animated: false)
                    self.alert(message: self.obj.createString(Str: message))
                    
                }
                
            }
            
        }else{
            
             alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    func index(index: Int, text: String) {
        
        if isStateORCustomerType == "State"{
           
            self.lbl_State.text = (getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "stateDescription") as? [String] ?? [])[index]
            self.StateCode = (getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "stateCode") as? [String] ?? [])[index]
            
        }else if isStateORCustomerType == "CustType"{
            
            self.CustomerType = (getRetailerViewModel.DictForDropDown.value(forKey: "CustomerCode")as? [String] ?? [])[index]
            
        }else if isStateORCustomerType == "tagCustomer"{
            
            self.tagCustomerCode = (getRetailerViewModel.DictForDropDown.value(forKey: "taggedCustomerCode")as? [String] ?? [])[index]
        }
          
    }
    
    
}
