//
//  StartYourDayVC.swift
//  AIPL
//
//  Created by apple on 07/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import iOSDropDown
import CoreLocation

class StartYourDayVC: UIViewController {

    //MARK:- Variable
    let navView : UIView = {
           
           let view = UIView()
           view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
           return view
       }()
      
       let leftBtn :UIButton = {
           
           let btn = UIButton()
           btn.tag = 1
           btn.setImage(UIImage(named: "back1"), for: .normal)
           btn.contentMode = .center
           btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
           
       }()
       
       let titleHeader:UILabel = {
           
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        return lbl
       }()
    
    let lbl_ModeOfTransport : UILabel = {
        
        let lbl = UILabel()
        lbl.text = "sdfsdf"
        return lbl
        
    }()
    let lbl_TypeOfTransport : UILabel = {
        
        let lbl = UILabel()
        return lbl
        
    }()
    let lbl_TravelType : UILabel = {
        
        let lbl = UILabel()
        return lbl
        
    }()
    let DownView : UIView = {
        
        let view = UIView()
       
        return view
    }()
    
    
    lazy var documentView : UIView = {
        
        let view = UIView()
        
        return view
        
    }()
    
    lazy var imageView : UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let btn_Document : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "attachment"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        btn.tag = 6
        return btn
    }()
    let lbl_Document : UILabel = {
        
        let lbl = UILabel()
        return lbl
        
    }()
    let btn_Submit : UIButton = {
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "Submit"), for: .normal)
        btn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        btn.tag = 7
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    var imagePicker = UIImagePickerController()
    var imageData = NSData()
    let obj = CommonClass.sharedInstance
    var dropMT = DropView()
    var dropTT = DropView()
    var dropTrType = DropView()
    var dropSH = DropView()
    var dropDown = DropDown()
    var validation = Validation()
    var conn = WebService()
    var alamofire = AlamofireWrapper.sharedInstance
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    var cityModelArr = [CityModel]()
    var dayCode = Int()
    var delegate : StartYourDayDelegate?
    var remark = String()
    var getStartDayViewModel = StartDayViewModel()
    let locManager = CLLocationManager()
    var lat = String()
    var long = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        imagePicker.allowsEditing =  true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        initializeTheLocationManager()
        
        if dayCode != 0{
            
           apigetStartDayDetails()
        }
         
    }
    
    //MARK:- Method to set Navi On Screen
     //MARK:-
     internal func setUpNavi(){
        
       
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
             navView.translatesAutoresizingMaskIntoConstraints = false
             navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
       _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
       

        view.addSubview(DownView)
        DownView.translatesAutoresizingMaskIntoConstraints = false
        DownView.scrollAnchor(top: navView.bottomAnchor, left:view.leftAnchor , bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        DownView.addSubview(lbl_ModeOfTransport)
        lbl_ModeOfTransport.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_ModeOfTransport.topAnchor.constraint(equalTo: DownView.topAnchor, constant: 20),
                                             lbl_ModeOfTransport.leadingAnchor.constraint(equalTo: DownView.leadingAnchor, constant: 20)])
        DownView.addSubview(dropMT)
        dropMT.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dropMT.topAnchor.constraint(equalTo: lbl_ModeOfTransport.bottomAnchor, constant: 15),
                                     dropMT.leftAnchor.constraint(equalTo: DownView.leftAnchor, constant: 20),
                                     dropMT.rightAnchor.constraint(equalTo: DownView.rightAnchor, constant: 20),
                                     dropMT.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        DownView.addSubview(lbl_TypeOfTransport)
        DownView.addSubview(dropTT)
        dropTT.translatesAutoresizingMaskIntoConstraints = false
        lbl_TypeOfTransport.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_TypeOfTransport.topAnchor.constraint(equalTo: dropMT.bottomAnchor, constant: 20),
                                             lbl_TypeOfTransport.leadingAnchor.constraint(equalTo: DownView.leadingAnchor, constant: 20)])
        dropTT.withoutBottomAnchor(top: lbl_TypeOfTransport.bottomAnchor, left: DownView.leftAnchor, right: DownView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: CGFloat(obj.commonHeight))
        
      
        
        DownView.addSubview(lbl_TravelType)
        DownView.addSubview(dropTrType)
        dropTrType.translatesAutoresizingMaskIntoConstraints = false
        dropTrType.DropBtn.setImage(UIImage(), for: .normal)
        lbl_TravelType.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_TravelType.topAnchor.constraint(equalTo: dropTT.bottomAnchor, constant: 20),
                                             lbl_TravelType.leadingAnchor.constraint(equalTo: DownView.leadingAnchor, constant: 20)])
        dropTrType.withoutBottomAnchor(top: lbl_TravelType.bottomAnchor, left: DownView.leftAnchor, right: DownView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: CGFloat(obj.commonHeight))
        
         DownView.addSubview(dropSH)
         dropSH.translatesAutoresizingMaskIntoConstraints = false
         dropSH.withoutBottomAnchor(top: dropTrType.bottomAnchor, left: DownView.leftAnchor, right: DownView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: CGFloat(obj.commonHeight))
        
        self.setConstriantSubmit(top: dropSH.bottomAnchor, distTop: 35)
           setString()
       }

    
    //MARK:- Custom Method To Set Title On UIElements
    //MARK:-
    
    func setString(){
        
        
        self.setFontandColor(lbl: titleHeader, color: UIColor.white, font: obj.BoldFont, size: obj.BoldfontSize, text: obj.createString(Str: "Start Your Day"))
        self.setFontandColor(lbl: lbl_TypeOfTransport, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Mode of Transport :")
        self.setFontandColor(lbl: lbl_ModeOfTransport, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Type of Transport :")
        self.setFontandColor(lbl: lbl_TravelType, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Travel Type :")
        self.dropMT.dropTxtFld.placeholder = obj.createString(Str: "Select")
        self.dropMT.dropTxtFld.font = UIFont(name: obj.RegularFont, size: obj.regularfontSize)
        self.dropTT.dropTxtFld.placeholder = obj.createString(Str: "Select")
        self.dropTT.dropTxtFld.font = UIFont(name: obj.RegularFont, size: obj.regularfontSize)
        self.dropTrType.dropTxtFld.text = obj.createString(Str: userData.value(forKey: "HQ")) as? String ?? ""
        self.dropTrType.dropTxtFld.font = UIFont(name: obj.RegularFont, size: obj.regularfontSize)
        self.dropSH.dropTxtFld.placeholder = obj.createString(Str: "Select Tour")
        self.dropSH.dropTxtFld.font = UIFont(name: obj.RegularFont, size: obj.regularfontSize)
        self.imageView.image = #imageLiteral(resourceName: "placeholder")
        setActionOnBtn(btn:  self.dropSH.DropBtn, tag: 5)
        setActionOnBtn(btn:  self.dropTT.DropBtn, tag: 3)
        setActionOnBtn(btn:  self.dropTrType.DropBtn, tag: 4)
        setActionOnBtn(btn:  self.dropMT.DropBtn, tag: 2)
       
    }
    
    
    func setActionOnBtn(btn:UIButton,tag:Int){
        
                btn.tag = tag
                btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
    }
    
    //MARK:- Custom Method To Set Font and Color
    
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat,text:String){
        
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        lbl.text = text
    }
    
    //MARK:- Bnt Action
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 2 {
            
            dropDownSelect(txtfld:dropMT.dropTxtFld)
             self.dropMT.dropTxtFld.optionArray = ["Self","Rented"]
                
            self.dropMT.dropTxtFld.showList()
            
//            dropDownSelect(txtfld:dropTT.dropTxtFld)
//            self.dropTT.dropTxtFld.optionArray = ["Self","Rented"]
//            self.dropTT.dropTxtFld.showList()
            
            print("Model Of Transport")
           
        }else if sender.tag == 3 {
            
            dropDownSelect(txtfld:dropTT.dropTxtFld)
            self.dropTT.dropTxtFld.optionArray = dropMT.dropTxtFld.text == "Rented" ? ["Bus","Train"] : ["Bike","Car"]
            self.dropTT.dropTxtFld.showList()
            
            
        
        }else if sender.tag == 4 {
            
            print("Travel Type")
        }else if sender.tag == 5 {
            
            cityApiCall()
            print("Select tour")
        }else if sender.tag == 6{
            
            self.openActionSheet()
        }else if sender.tag == 7{
            
            self.CheckValidation()
        }
        
        print("working")
    }
    
    //MARK:- DropDown  Method
    //MARK:-
    
    func dropDownSelect(txtfld:UITextField){
        
             
            self.dropTT.dropTxtFld.didSelect { (selectedText, index, id) in
            
            txtfld.text = "\(selectedText)"
           }
            self.dropTT.dropTxtFld.listDidDisappear {
            
            if self.dropTT.dropTxtFld.text != nil  {
                
                if self.dropTT.dropTxtFld.text == "Self" {
                    
                   self.setDocumentConstraint()
                    
                }else{
                    self.documentView.removeFromSuperview()
                   // self.btn_Document.removeFromSuperview()
                   // self.lbl_Document.removeFromSuperview()
                    self.setConstriantSubmit(top: self.dropSH.bottomAnchor, distTop: 35)
                    
                }
                
            }
        }
    }
   
    //MARK:- Method To Set For Document Bnt
    //MARK:-
    
    func setDocumentConstraint(){
        
        
        DownView.addSubview(documentView)
        documentView.withoutBottomAnchor(top: dropSH.bottomAnchor, left: DownView.leftAnchor, right: DownView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 120)
        
        documentView.addSubview(btn_Document)
        btn_Document.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_Document.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     btn_Document.widthAnchor.constraint(equalToConstant: 50),
                                     btn_Document.topAnchor.constraint(equalTo: documentView.topAnchor, constant: 0),
                                     btn_Document.leftAnchor.constraint(equalTo: documentView.leftAnchor, constant: 0)])
        documentView.addSubview(lbl_Document)
        lbl_Document.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_Document.centerYAnchor.constraint(equalTo: btn_Document.centerYAnchor),
                                     lbl_Document.leftAnchor.constraint(equalTo: btn_Document.rightAnchor, constant: 10)])
        self.setFontandColor(lbl: lbl_Document, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: obj.createString(Str: "Upload Image"))
        documentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.leftAnchor.constraint(equalTo: btn_Document.rightAnchor, constant: 5),
                                     imageView.topAnchor.constraint(equalTo: btn_Document.bottomAnchor, constant: 8),
                                     imageView.heightAnchor.constraint(equalToConstant: 60),
                                     imageView.widthAnchor.constraint(equalToConstant: 60)])
        btn_Submit.removeFromSuperview()
        self.setConstriantSubmit(top: documentView.bottomAnchor, distTop: 15)
           
    }
    
    //MARK:- SetConstraintForSubmit Bnt
    //MARK:-
    
    func setConstriantSubmit(top:NSLayoutYAxisAnchor?,distTop:CGFloat){
        
        DownView.addSubview(btn_Submit)
               btn_Submit.translatesAutoresizingMaskIntoConstraints = false
               btn_Submit.withoutBottomAnchor(top: top, left: DownView.leftAnchor, right: DownView.rightAnchor, paddingTop: distTop, paddingLeft: 30, paddingRight: 30, height: CGFloat(obj.commonHeight))
               btn_Submit.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        
        
    }
}
//MARK:- Current Lat Long Method
//MARK:-
extension StartYourDayVC:CLLocationManagerDelegate {
    
    func initializeTheLocationManager()
    {
         locManager.delegate         = self
         locManager.desiredAccuracy  = kCLLocationAccuracyBest;
         //locManager.distanceFilter   = 10; // meters
         locManager.requestWhenInUseAuthorization()
         locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locManager.location?.coordinate
        self.lat = location?.latitude.description ?? ""
        self.long = location?.longitude.description ?? ""
        
        
        print("Your Lat is \(lat) and long is \(long)")
    }
}
