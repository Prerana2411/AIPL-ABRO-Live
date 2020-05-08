//
//  HomeVC.swift
//  AIPL
//
//  Created by apple on 06/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {

    
    //MARK:- Outlet
    @IBOutlet weak var btn_DayStart:UIButton!
    @IBOutlet weak var btn_DayEnd:UIButton!
    @IBOutlet weak var lbl_Month: UILabel!
    @IBOutlet weak var lbl_Target: UILabel!
    @IBOutlet weak var lbl_Sales: UILabel!
    @IBOutlet weak var lbl_Collection: UILabel!
    @IBOutlet weak var btn_LeftMonth:UIButton!
    @IBOutlet weak var btn_RightMonth:UIButton!
    @IBOutlet weak var lbl_LeftTarget: UILabel!
    @IBOutlet weak var lbl_LeftSales: UILabel!
    @IBOutlet weak var lbl_LeftCollection: UILabel!
    @IBOutlet weak var lbl_RightTarget: UILabel!
    @IBOutlet weak var lbl_RightSales: UILabel!
    @IBOutlet weak var lbl_RightCollection: UILabel!
    @IBOutlet weak var lbl_TotalFY: UILabel!
    @IBOutlet weak var lbl_TotalTarget: UILabel!
    @IBOutlet weak var lbl_TotalSales: UILabel!
    @IBOutlet weak var lbl_TotalCollection: UILabel!
    @IBOutlet weak var lbl_TotalCollectionValue: UILabel!
    @IBOutlet weak var lbl_TotalTargetValue: UILabel!
    @IBOutlet weak var lbl_TotalSalesValue: UILabel!
    @IBOutlet weak var txt_From: UITextField!
    @IBOutlet weak var txt_To: UITextField!
    @IBOutlet weak var btn_From: UIButton!
    @IBOutlet weak var btn_To: UIButton!
    @IBOutlet weak var btn_GO: UIButton!
    
    //MARK:- Variable
    let navView : UIView = {
           
           let view = UIView()
           view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
           return view
       }()
      
       let rightBtn :UIButton = {
           
           let btn = UIButton()
           btn.tag = 1
           btn.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
           btn.contentMode = .scaleAspectFill
          // btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
           
       }()
       
       let titleHeader:UIImageView = {
           
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "header_logo")
        img.contentMode = .scaleAspectFit
        return img
       }()
    // Location Manager
    let locManager = CLLocationManager()
    var alamofire = AlamofireWrapper.sharedInstance
    let obj = CommonClass.sharedInstance
    var dayCode = Int()
    var salesPersonCode = String()
    var viewModelobj = StartDayViewModel()
    var apiHandler = ApiHandler()
    var locationTimer: Timer?
    let calendar = Calendar.current
    let date = Date()
    var lat = String()
    var long = String()
    //MARK:- LifeCycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavi()
        btn_DayEnd.tag = 4
        btn_DayEnd.addTarget(self, action: #selector(tap_Action), for: .touchUpInside)
        self.ApigetDayStartEndTime()
    }
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
          
        view.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
            view.addSubview(navView)
            navView.translatesAutoresizingMaskIntoConstraints = false
            navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
      _ = navView.naviView(navView: navView, rightBtn: rightBtn, leftBtn: UIButton(), logoImg: titleHeader, title: UILabel(), isLogoHidden: false)
        
        // APi Call To Check Day Start or not
        self.apicheckStartDate()
          
      }

    //MARK:- String on UI Elements
    //MARK:-
    internal func setString(btnStartTitle:String,btn_DayStartColor:UIColor,btn_DayEndColor:UIColor){
        
       
        self.btnColorTitle(btnTitle: btnStartTitle, btn_DayStart: btn_DayStart, btn_DayEnd: btn_DayEnd, btn_DayStartColor: btn_DayStartColor, btn_DayEndColor: btn_DayEndColor)
        
        self.lbl_Month.text = obj.createString(Str: "Month")
        self.setFontandColor(lbl: lbl_Month, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.lbl_Target.text = obj.createString(Str: "Target")
        self.setFontandColor(lbl: lbl_Target, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.lbl_Sales.text = obj.createString(Str: "Sales")
        self.setFontandColor(lbl: lbl_Sales, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.lbl_Collection.text = obj.createString(Str: "Collection")
        self.setFontandColor(lbl: lbl_Collection, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        
        self.setFontandColor(lbl: lbl_LeftSales, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_LeftTarget, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_LeftCollection, color: obj.commonAppTextDrakColor, font:obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_RightSales, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_RightTarget, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_RightCollection, color: obj.commonAppTextDrakColor, font:obj.RegularFont, size: obj.regularfontSize)
        self.lbl_TotalFY.text = obj.createString(Str: "Total in the Financial Year :")
        self.setFontandColor(lbl: lbl_TotalFY, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.lbl_TotalSales.text = obj.createString(Str: "Total Sales :")
        self.lbl_TotalTarget.text = obj.createString(Str: "Total Target :")
        self.lbl_TotalCollection.text = obj.createString(Str: "Total Collection :")
        self.setFontandColor(lbl: lbl_TotalSales, color: UIColor.black, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.setFontandColor(lbl: lbl_TotalTarget, color: UIColor.black, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.setFontandColor(lbl: lbl_TotalCollection, color: UIColor.black, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.setFontandColor(lbl: lbl_TotalSalesValue, color: obj.commonAppTextDrakColor, font:obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_TotalTargetValue, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_TotalCollectionValue, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
        self.txt_From.placeholder = obj.createString(Str: "From")
        self.txt_To.placeholder = obj.createString(Str: "To")
        btn_GO.setTitleColor(UIColor.white, for: .normal)
        btn_GO.setTitle(obj.createString(Str: "GO"), for: .normal)
        btn_GO.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        btn_LeftMonth.setTitle(obj.createString(Str: "Dec - 2019"), for: .normal)
        btn_RightMonth.setTitle(obj.createString(Str: "Jan - 2020"), for: .normal)
       
        
      }
    
    //MARK:- Custom Method To Set Font and Color
    
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat){
        
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    //MARK:- UIButton Action
    //MARK:-
    
    @IBAction func tap_Action(_ sender: UIButton) {
        
        if sender.tag == 1{
            
            let vc = StartYourDayVC()
            vc.delegate = self
            vc.dayCode = self.dayCode
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 3{
            
            let vc = ItemDetailsVC()
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 4{
            
            let vc = RemarkVC()
            vc.remarkType = "Why you are ending your day early?"
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            self.navigationController?.present(vc, animated: false, completion: nil)
            
        }
          
    }
    
    //MARK:- Time Difference Method
    
    func timeBetween10to5(start:Int,end:Int){
        
       
        let now = Date()
        let ten_today = calendar.date(
          bySettingHour: start,
          minute: 0,
          second: 0,
          of: now)!

        let five_today = calendar.date(
          bySettingHour: end,
          minute: 0,
          second: 0,
          of: now)!

        if now >= ten_today &&
          now <= five_today
        {
          print("The time is between \(start):00 and \(end):00")
            
              let vc = LeaveVC()
              vc.modalPresentationStyle = .overFullScreen
              vc.nav = self.navigationController ?? UINavigationController()
              vc.delegate = self
              self.present(vc, animated: false, completion: nil)
            
        }
    }
}

//MARK:- Current Lat Long Method
//MARK:-
extension HomeVC:CLLocationManagerDelegate {
    
   @objc func initializeTheLocationManager()
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
        
        apiupdateLocationDayStart(dayCode: String(self.dayCode), salesPersonCode: self.salesPersonCode, lastLat: lat, lastLong: long)
        print("Your Lat is \(lat) and long is \(long)")
    }
}

// MARK:- Custom Protocol Call
//MARK:- when Day Started

extension HomeVC:StartYourDayDelegate{
    
    func startYourDay(btnTitle: String) {
        
    //    self.btnColorTitle(btnTitle: btnTitle, btn_DayStart: btn_DayStart, btn_DayEnd: btn_DayEnd, btn_DayStartColor: obj.commonAppGreenColor, btn_DayEndColor: obj.commonAppRedColor)
        
    }
  
    func btnColorTitle(btnTitle:String,btn_DayStart:UIButton,btn_DayEnd:UIButton,btn_DayStartColor:UIColor,btn_DayEndColor:UIColor){
        
               btnTitle == "Day Start" ? (btn_DayEnd.isUserInteractionEnabled = false) : (btn_DayEnd.isUserInteractionEnabled = true)
               
               self.btn_DayStart.setTitle(obj.createString(Str: btnTitle), for: .normal)
               self.btn_DayStart.backgroundColor = btn_DayStartColor
               self.btn_DayStart.titleLabel?.font = UIFont(name: obj.BoldFont, size: obj.BoldfontSize)
               self.btn_DayEnd.titleLabel?.font = UIFont(name: obj.BoldFont, size: obj.BoldfontSize)
               self.btn_DayStart.setTitleColor(UIColor.white, for: .normal)
               self.btn_DayEnd.setTitle(obj.createString(Str: "Day End"), for: .normal)
               self.btn_DayEnd.backgroundColor = btn_DayEndColor
               self.btn_DayEnd.setTitleColor(UIColor.white, for: .normal)
    }
}
//MARK:- Api checkStartDate
//MARK:-

extension HomeVC{
    
    func apicheckStartDate(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
            let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? "","dayDate":formatter.string(from: date)] as [String:Any]
            
            print("Pass Date \(passDict)")
            Indicator.shared.showProgressView(self.view)
            
            self.viewModelobj.getDataFromApiHandlerClass(url: "checkStartDate", passDict: passDict) { (message) in
                
            Indicator.shared.hideProgressView()
               
                if self.viewModelobj.getDataArr.count > 0 {
                    
                    
                    
                    if let dayCode = self.viewModelobj.getDataArr[0].dayCode{
                        
                        self.dayCode = dayCode
                        self.salesPersonCode = self.viewModelobj.getDataArr[0].SalesPersonCode ?? ""
                        
                    }
                    if self.viewModelobj.getDataArr[0].Edited == "0" || self.viewModelobj.getDataArr[0].Edited == ""{
                        
                        self.setString(btnStartTitle: "Edit Day Start", btn_DayStartColor: self.obj.commonAppGreenColor, btn_DayEndColor: self.obj.commonAppRedColor)
                        //Timer is use to send lat long after some time interval wwhen day is started..
                        self.locationTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.initializeTheLocationManager), userInfo: nil, repeats: true)
                    }
                    else if self.viewModelobj.getDataArr[0].LeaveStatus == "yes" && self.viewModelobj.getDataArr[0].Edited ==  "1"{
                       
                        self.setString(btnStartTitle: "Day Start", btn_DayStartColor: self.obj.commonAppLightblueColor, btn_DayEndColor: self.obj.commonAppLightblueColor)
                        
                        self.btn_DayStart.isUserInteractionEnabled = false
                        self.btn_DayEnd.isUserInteractionEnabled = false
                    }else if self.viewModelobj.getDataArr[0].Edited ==  "1" && self.viewModelobj.getDataArr[0].EndRemarks != "null"  {
                        
                        self.setString(btnStartTitle: "Day Start", btn_DayStartColor: self.obj.commonAppRedColor, btn_DayEndColor: self.obj.commonAppLightblueColor)
                        self.btn_DayEnd.isUserInteractionEnabled = true
                        self.btn_DayStart.isUserInteractionEnabled = false
                        self.dayCode = 0
                    }else if self.viewModelobj.getDataArr[0].Edited ==  "1"   {
                        
                        self.setString(btnStartTitle: "Day Start", btn_DayStartColor: self.obj.commonAppLightblueColor, btn_DayEndColor: self.obj.commonAppRedColor)
                        self.btn_DayEnd.isUserInteractionEnabled = true
                        self.btn_DayStart.isUserInteractionEnabled = false
                    } else{
                        
                      self.setString(btnStartTitle: "Day Start", btn_DayStartColor: self.obj.commonAppRedColor, btn_DayEndColor: self.obj.commonAppLightblueColor)
                      self.btn_DayEnd.isUserInteractionEnabled = false
                    }
                }else{
                    
                    self.setString(btnStartTitle: "Day Start", btn_DayStartColor: self.obj.commonAppRedColor, btn_DayEndColor: self.obj.commonAppLightblueColor)
                    self.btn_DayEnd.isUserInteractionEnabled = false
                   // self.timeBetween10to5()
                    
                }
                
            }
             
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    //MARK:- Api getDayStartEndTime
    //MARK:-
    
    func ApigetDayStartEndTime(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            Indicator.shared.showProgressView(self.view)
            
            self.viewModelobj.getDataFromApiHandlerGetTypeApi(strUrl: "getDayStartEndTime") { (responseMessage) in
                
                var startTime = String()
                startTime = String(self.viewModelobj.startTime.prefix(2))
                let nsStartTime = startTime as NSString
                
                var endTime = String()
                endTime = String(self.viewModelobj.endTime.prefix(2))
                let nsendTime = endTime as NSString
                
                self.timeBetween10to5(start: nsendTime.integerValue , end: nsStartTime.integerValue)
                
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
    
}
//MARK:- Api updateLocationDayStart
//MARK:-

extension HomeVC{
    
    func apiupdateLocationDayStart(dayCode:String,salesPersonCode:String,lastLat:String,lastLong:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
           
            let passDict = ["salesPersonCode":salesPersonCode,"dayCode":dayCode,"lastLat":lastLat,"lastLong":lastLong] as [String:Any]
            
            print("Pass Date \(passDict)")
           // Indicator.shared.showProgressView(self.view)
            
            apiHandler.getDataFromApi(withUrl: "updateLocationDayStart", passDict: passDict) { (responseJSON) in
                
                print(responseJSON)
            }
            
        }else{
             self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
    }
}

//MARK:- Api editDayEnd
//MARK:-

extension HomeVC:RemarkVCDelegate{
   
    
    func apieditDayEnd(remark:String,lat:String,long:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            let endTime = "\(hour):\(minutes):\(seconds)"
            
            print(endTime,self.lat,self.long)
            
            let passDict = ["endTime":endTime,"endLat":lat,"endLong":long,"endRemarks":remark,"salesPersonCode":self.salesPersonCode,"dayCode":self.dayCode] as [String:Any]
            
            print(passDict)
            
            Indicator.shared.showProgressView(view)
            
            viewModelobj.getDataFromApiHandlerClass(url: "editDayEnd", passDict: passDict) { (responseMessage) in
                
                if responseMessage == "data found"{
                    
                    self.apicheckStartDate()
                }
                
                self.alert(message: self.obj.createString(Str: responseMessage))
            }
            
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
        
    }
    
    func remark(endDay remarks: String) {
        
       self.initializeTheLocationManager()
        
        print(remarks)
        
        apieditDayEnd(remark: remarks, lat: self.lat, long: self.long)
        
    }
     
    func callCheckDayStartApi() {
        
        self.apicheckStartDate()
        
    }
}
