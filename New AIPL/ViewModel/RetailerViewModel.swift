//
//  RetailerViewModel.swift
//  AIPL ABRO
//
//  Created by CST on 24/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
import DropDown

class RetailerViewModel{
    
   var apiHandler = ApiHandler()
   var getDataArr = [retailerListHQwiseModel]()
   var getRetailerDetailArr = [RetailerModel]()
   let obj = CommonClass.sharedInstance
   var retailerName = [String]()
   var retailerNumber = [String]()
   var taggedCustomerCodeArr = [String]()
   var tagCusName = [String]()
   var businessEntityArr = [String]()
   var text =  Int()
   var delegate : NewRetailerVCDelegate?
   var DictForDropDown = NSMutableDictionary()
    
    func getReatilerListDataFromApiHandler(url:String,passDict:[String:Any],success:@escaping ([retailerListHQwiseModel],_ message:String)->(),failure:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (responseJSON) in
            
        //    print(responseJSON)
            
            let message = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataArray"].arrayObject{
                    
                    
                    if self.getDataArr.count > 0 {
                        
                        self.getDataArr.removeAll()
                        self.retailerName.removeAll()
                        self.retailerNumber.removeAll()
                        self.taggedCustomerCodeArr.removeAll()
                       
                    }
                    
                    for arrayItem in dataArray{
                        
                        var HQ = String()
                        var RetailerAddress = String()
                        var RetailerName = String()
                        var No = String()
                        var Zone = String()
                        var taggedCustomerCode = String()
                        var tagCustName = String()
                        if let dict = arrayItem as? NSDictionary{
                            
                            if let hq = dict.value(forKey: "HQ") as? String{
                                
                                HQ = hq
                            }
                            if let retailerAddress = dict.value(forKey: "Retailer Address") as? String{
                                
                                RetailerAddress = retailerAddress
                            }
                            if let retailerName = dict.value(forKey: "Retailer Name") as? String{
                                
                                RetailerName = retailerName
                                
                            }
                            if let no = dict.value(forKey: "No_") as? String{
                                
                                No = no
                            }
                            if let zone = dict.value(forKey: "Zone") as? String{
                                
                                Zone = zone
                            }
                            
                            if let TaggedCustomerCode = dict.value(forKey: "Tagged Customer Code") as? String{
                                
                               taggedCustomerCode = TaggedCustomerCode
                            }
                           
                            if let tagName = dict.value(forKey: "Name") as? String{
                                
                                tagCustName = tagName
                            }
                            
                            let item = retailerListHQwiseModel(RetailerName: RetailerName, RetailerAddress: RetailerAddress, Zone: Zone, HQ: HQ, No: No)
                            self.retailerName.append(RetailerName)
                            self.retailerNumber.append(No)
                            self.getDataArr.append(item)
                            self.taggedCustomerCodeArr.append(taggedCustomerCode)
                           
                        }
                        
                    }
                    
                    success(self.getDataArr,message)
                }
                
            }else{
                
                failure(message)
            }
            
        }
        
    }
    
    func getTaggedCustDataFromApiHandler(url:String,passDict:[String:Any],responseMessage:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (responseJSON) in
            
            //    print(responseJSON)
            
            let message = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataObj"].dictionary{
                    
                    
                    if self.tagCusName.count > 0 {
                        self.businessEntityArr.removeAll()
                        self.tagCusName.removeAll()
                    }
                    
                    var tagCustName = String()
                    var BusinessEntity = String()
                    if let tagName = dataArray["Name"]?.string{
                        
                        tagCustName = tagName
                    }
                    if let businessEntity = dataArray["Business Entity"]?.string{
                        
                        BusinessEntity = businessEntity
                    }
                    self.tagCusName.append(tagCustName)
                    self.businessEntityArr.append(BusinessEntity)
                }
                
            }
            
            responseMessage(message)
            
        }
        
    }
    
    //MARK:- Retailer Detail
    //MARK:-
    
    func getRetailerDetailDataFromApiHandler(strUrl:String,passDict:[String:Any],success:@escaping ( _ message:String)->()) {
        
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseJSON) in
            
            
            let message = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool ?? false == true{
                
                if let dataObjDict = responseJSON["dataObj"].dictionary {
                    
                    if self.getRetailerDetailArr.count > 0 {
                        
                        self.getRetailerDetailArr.removeAll()
                    }
                    
                    
                    var No = String()
                    var RetailerName = String()
                    var RetailerAddress = String()
                    var DSRCity = String()
                    var PostCode = String()
                    var StateCode = String()
                    var EMail = String()
                    var MobileNo = String()
                    var ContactPerson = String()
                    var Zone = String()
                    var HQ = String()
                    var Segment = String()
                    var CustomerType = String()
                    var CreateDate = String()
                    var NoSeries = String()
                    var CustomerTypeName = String()
                    var TaggedCustomerCode = String()
                    var TaggedCustomerName = String()
                    var Beat = String()
                    var PhoneNo = String()
                    var Classification = String()
                    var Potential = String()
                    var GSTNumber = String()
                    var CompBrand = String()
                    var lat = String()
                    var Long = String()
                    var UserType = String()
                    var Image = String()
                    var TelexNo = String()
                    
                    if let no = dataObjDict["No_"]?.string{
                        
                        No = no
                    }
                    if let retailerName = dataObjDict["Retailer Name"]?.string{
                        
                        RetailerName = retailerName
                    }
                    if let hq = dataObjDict["HQ"]?.string{
                        
                        HQ = hq
                    }
                    if let statecode = dataObjDict["State Code"]?.string{
                        
                        StateCode = statecode
                    }
                    if let dSRCity = dataObjDict["DSR City"]?.string{
                        
                        DSRCity = dSRCity
                    }
                    if let beat = dataObjDict["Beat"]?.string{
                        
                        Beat = beat
                    }
                    if let customerType = dataObjDict["Customer Type"]?.string{
                        
                        CustomerType = customerType
                    }
                    if let address = dataObjDict["Retailer Address"]?.string{
                        
                        RetailerAddress = address
                    }
                    if let email = dataObjDict["E-Mail"]?.string{
                        
                        EMail = email
                    }
                    if let contactPerson = dataObjDict["Contact Person"]?.string{
                        
                        ContactPerson = contactPerson
                    }
                    if let taggedCustomerName = dataObjDict["Tagged Customer Name"]?.string{
                        
                        TaggedCustomerName = taggedCustomerName
                    }
                    if let segment = dataObjDict["Segment"]?.string{
                        
                        Segment = segment
                    }
                    if let mobileNo = dataObjDict["Mobile No_"]?.string{
                        
                        MobileNo = mobileNo
                    }
                    
                    if let potential = dataObjDict["POTTENTIAL"]?.string{
                        
                        Potential = potential
                    }
                    if let latt = dataObjDict["LAT"]?.double{
                        
                        lat = String(latt)
                    }
                    if let long = dataObjDict["LONG"]?.double{
                        
                        Long = String(long)
                    }
                   if let userType = dataObjDict["USER_TYPE"]?.int{
                       
                       UserType = String(userType)
                   }
                    if let image = dataObjDict["IMAGE"]?.string{
                        
                        Image = image
                    }
                   if let gst = dataObjDict["GST"]?.string{
                        
                        GSTNumber = gst
                    }
                    if let compBrand = dataObjDict["COMPETITOR_BRAND"]?.string{
                        
                        CompBrand = compBrand
                    }
                    if let postCode = dataObjDict["Post Code"]?.string{
                        
                        PostCode = postCode
                    }
                    if let telexNo = dataObjDict["Telex No_"]?.string{
                        
                        TelexNo = telexNo
                    }
                    if let createdDate = dataObjDict["Create Date"]?.string{
                        
                        CreateDate = createdDate
                    }
                    if let tagCustCode = dataObjDict["Tagged Customer Code"]?.string{
                        
                        TaggedCustomerCode = tagCustCode
                    }
                    if let custTypeName = dataObjDict["Customer Type Name"]?.string{
                        
                        CustomerTypeName = custTypeName
                        
                    }
                    if let classification = dataObjDict["CLASSIFICATION"]?.string{
                        
                        Classification = classification
                    }
                    var stateDiscription = String()
                    if let sateDicp = dataObjDict["State Description"]?.string{
                        
                        stateDiscription = sateDicp
                    }
                    
                    
                    let item = RetailerModel(No: No, RetailerName: RetailerName, RetailerAddress: RetailerAddress, DSRCity: DSRCity, PostCode: PostCode, StateCode: StateCode, EMail: EMail, MobileNo: MobileNo, ContactPerson: ContactPerson, Zone: Zone, HQ: HQ, Segment: Segment, CustomerType: CustomerType, CreateDate: CreateDate, NoSeries: NoSeries, SegmentName: Segment, CustomerTypeName: CustomerTypeName, TaggedCustomerCode: TaggedCustomerCode, TaggedCustomerName: TaggedCustomerName, Beat: Beat, PhoneNo: PhoneNo, Classification: Classification, Potential: Potential, GSTNumber: GSTNumber, CompBrand: CompBrand, lat: lat, Long: Long, UserType: UserType, Image: Image, TelexNo: TelexNo,stateDiscription:stateDiscription)
                    
                    self.getRetailerDetailArr.append(item)
                }
                
            }
            
            success(message)
           
            
        }
    }
    
    //MARK:-Item Cat Api
    //MARK:-
    
    var ItemCategorysArr = [String]()
    var itemCodeArr = [String]()
    var itemDiscriptionArr = [String]()
    
    func apiitemList(urlStr:String,passDict:[String:Any],compilition:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: urlStr, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message1 = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataArray"].arrayObject{
                    
                    if self.ItemCategorysArr.count > 0 {
                        
                        self.ItemCategorysArr.removeAll()
                        self.itemCodeArr.removeAll()
                        self.itemDiscriptionArr.removeAll()
                    }
                    
                    for item in dataArray{
                        
                        var ItemCategorys = String()
                        var itemCode = String()
                        var itemDiscription = String()
                        
                        if let itemDict = item as? NSDictionary{
                            
                            if let itemCat = itemDict.value(forKey: "Item Categorys") as? String{
                                
                                ItemCategorys = itemCat
                            }
                            if let code = itemDict.value(forKey: "Code") as? String{
                                
                                itemCode = code
                                
                            }
                            if let ItemDiscription = itemDict.value(forKey: "Description") as? String{
                                
                                itemDiscription = ItemDiscription
                            }
                            self.ItemCategorysArr.append(ItemCategorys)
                            self.itemCodeArr.append(itemCode)
                            self.itemDiscriptionArr.append(itemDiscription)
                        }
                        
                    }
                    
                    compilition(message1)
                }
                
            }else{
                
                compilition(message1)
            }
            
        }
        
    }
    
    //MARK:- api customerBlocked
    //MARK:-
    
    func getTaggedCustomeDataFromApiHandler(strUrl:String,passDict:[String:Any],message:@escaping (_ message: String)->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message1 = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataArray"].arrayObject{
                    
                    var taggedCustomerNameArr = [String]()
                    var taggedCustomerCodeArr = [String]()
                    for item in dataArray{
                        
                        if let dictItem = item as? NSDictionary{
                            
                            var Name = String()
                            var Code = String()
                            if let name = dictItem.value(forKey: "Name") as? String{
                                
                                Name = name
                                
                            }
                            if let code = dictItem.value(forKey: "No_") as? String{
                                
                                Code = code
                                
                            }
                            
                            taggedCustomerNameArr.append(Name)
                            taggedCustomerCodeArr.append(Code)
                        }
                        
                    }
                    
                    self.DictForDropDown.addEntries(from: ["taggedCustomerName" : taggedCustomerNameArr])
                    self.DictForDropDown.addEntries(from: ["taggedCustomerCode" : taggedCustomerCodeArr])
                    
                }
            }
            message(message1)
             
        }
    }
    
    //MARK:- Add Or Edit Retailer
    //MARK:-
    
    func getRetailerAddEditFromApiHandler(strUrl:String,passDict:[String:Any],imageData:NSData,responseMessage:@escaping (_ message:String) -> ()){
        
      
        apiHandler.getDataFromApiWithImageData(withUrl: strUrl, passDict: passDict, imageData: imageData, complitionBlock: { (responseJSON) in
            
            print(responseJSON)
            
            responseMessage(responseJSON["message"].string ?? "")
            
            
        }) { (faliureMessage) in
            
            responseMessage(faliureMessage)
            
        }
    }
    
    //MARK:- api classification/segment
    //MARK:-
    
  
    
    func getclassficationAndsegmentDataFromApiHandler(strUrl:String,passDict:[String:Any],message:@escaping (_ message: String)->()){
        
        apiHandler.getDataFromApi(withUrl: strUrl, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message1 = responseJSON["message"].string ?? ""
            
            if responseJSON["response"].bool == true{
                
                if let dataArray = responseJSON["dataObj"].dictionary{
                    
                    if let segmentDict = dataArray["segment"]?.dictionary{
                       
                        if let recordsets = segmentDict["recordset"]?.arrayObject{
                            
                            var DescriptionArr = [String]()
                            
                            for item in recordsets{
                                
                                if let dictItem = item as? NSDictionary{
                                    
                                    var Description = String()
                                    
                                    if let discription = dictItem.value(forKey: "Description") as? String{
                                        
                                        Description = discription
                                    }
                                   
                                    DescriptionArr.append(Description)
                                }
                                
                            }
                            
                            self.DictForDropDown.addEntries(from: ["segment":DescriptionArr])
                        }
                        
                    }
                    if let classificationDict = dataArray["classification"]?.dictionary{
                        
                        if let recordsets = classificationDict["recordset"]?.arrayObject{
                            
                            var DescriptionArr = [String]()
                            
                            for item in recordsets{
                                
                                if let dictItem = item as? NSDictionary{
                                    
                                    var Description = String()
                                    
                                    if let discription = dictItem.value(forKey: "Description") as? String{
                                        
                                        Description = discription
                                    }
                                    
                                    DescriptionArr.append(Description)
                                }
                                
                            }
                            
                            self.DictForDropDown.addEntries(from: ["classification":DescriptionArr])
                        }
                    }
                    if let customerTypeDict = dataArray["customerType"]?.dictionary{
                        
                        if let recordsets = customerTypeDict["recordset"]?.arrayObject{
                            
                            var DescriptionArr = [String]()
                            var CodeArr = [String]()
                            for item in recordsets{
                                
                                if let dictItem = item as? NSDictionary{
                                    
                                    var Description = String()
                                    var Code = String()
                                    if let discription = dictItem.value(forKey: "Description") as? String{
                                        
                                        Description = discription
                                    }
                                    if let code = dictItem.value(forKey: "Code") as? String{
                                        
                                        Code = code
                                    }
                                    DescriptionArr.append(Description)
                                    CodeArr.append(Code)
                                }
                                
                            }
                            
                            self.DictForDropDown.addEntries(from: ["CustomerType":DescriptionArr])
                            self.DictForDropDown.addEntries(from: ["CustomerCode" : CodeArr])
                        }
                    }
                    
                }
            }
            message(message1)
             
        }
    }
    
    func setCommonConstraint(view:UIView,item:UIView){
        
           view.addSubview(item)
           view.layer.borderWidth = 1.0
           view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           view.backgroundColor = .white
           view.layer.cornerRadius = CGFloat(obj.commonHeight)/2
           item.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
           
    }
    func setDataOnButton(btn:UIButton,text:String,font:String,size:CGFloat,textcolor:UIColor,image:UIImage,backGroundColor:UIColor,aliment:UIControl.ContentHorizontalAlignment){
              
             btn.setDataOnButton(btn: btn, text: text, font: font, size: size, textcolor: textcolor, image: image, backGroundColor: backGroundColor, aliment: aliment)
        
    }
    func setFontandColor(txtFld:UITextField,color:UIColor,font:String,size:CGFloat,text:String){
          
        txtFld.setFontandColor(txtFld: txtFld, color: color, font: font, size: size, text: text)
        
    }
    func lblFontColor(lbl:UILabel,text:String, textColor: UIColor, font: String, size: CGFloat){
        
        lbl.setFontAndColor(lbl: lbl, text: text, textColor: textColor, font: font, size: size)
        
    }
    
    func dropDownDelegate(textField:UITextField,view:UIView,dropDown:DropDown)  {
   
        dropDown.anchorView = view
        dropDown.animationEntranceOptions = .allowAnimatedContent
        dropDown.backgroundColor = obj.commonAppRedColor
        dropDown.textColor = UIColor.white
        dropDown.textFont = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize) ?? UIFont()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            textField.text = item
            self?.text = index
            self?.delegate?.index(index: index, text: item)
        }
        
    }
    
    
    
    func getRetailerName() -> String{
        
        return getRetailerDetailArr[0].RetailerName 
    }
    
    func getHQ() -> String{
        
        return getRetailerDetailArr[0].HQ 
    }
    func getState() -> String{
        
        return getRetailerDetailArr[0].stateDiscription
    }
    func getCity() -> String{
        
        return getRetailerDetailArr[0].DSRCity 
    }
    func getBeat() -> String{
        
        return getRetailerDetailArr[0].Beat 
    }
    func getCustType() -> String{
        
        return getRetailerDetailArr[0].CustomerTypeName
    }
    func getAddress() -> String{
        
        return getRetailerDetailArr[0].RetailerAddress 
    }
    func getEmail() -> String{
        
        return getRetailerDetailArr[0].EMail 
    }
    func getContactNumber() -> String{
        
        return getRetailerDetailArr[0].MobileNo 
    }
    func getTagCust() -> String{
        
        return getRetailerDetailArr[0].TaggedCustomerName 
    }
    func getSegment() -> String{
        
        return getRetailerDetailArr[0].Segment 
    }
    func getContPerson() -> String{
        
        return getRetailerDetailArr[0].ContactPerson 
    }
}
