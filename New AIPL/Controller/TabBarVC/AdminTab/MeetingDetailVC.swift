//
//  MeetingDetailVC.swift
//  AIPL ABRO
//
//  Created by call soft on 24/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import RSSelectionMenu

class MeetingDetailVC: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var vw_bg: UIView!
    @IBOutlet weak var vw_meetDescr: UIView!
    @IBOutlet weak var txt_meetDesc: UITextView!
    @IBOutlet weak var vw_selectDate: UIView!
    @IBOutlet weak var txt_selectDate: UITextField!
    @IBOutlet weak var vw_selectTime: UIView!
    @IBOutlet weak var txt_selectTime: UITextField!
    @IBOutlet weak var vw_addUser: UIView!
    @IBOutlet weak var btn_addUser: UIButton!
    @IBOutlet weak var vw_create: UIView!
    @IBOutlet weak var btnCreate: UIButton!
    
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lbl_user: UILabel!
    
    
    //MARK:- Variable
    let navView : UIView = {
        
        let view = UIView()
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        return view
    }()
    
    let leftBtn :UIButton = {
        
        let btn = UIButton()
        btn.tag = 1
        btn.setImage(#imageLiteral(resourceName: "back1"), for: .normal)
        btn.contentMode = .center
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
        
    }()
    
    let titleHeader:UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        lbl.text = "Create Meeting"
        return lbl
    }()
    
    var conn = WebService()
    let obj = CommonClass.sharedInstance
    let datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    var arrUser = [UserListModel]()
    
    var newDict = [NSMutableDictionary]()
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vw_bg.backgroundColor = obj.commonAppbackgroundColor
        
        vw_meetDescr.backgroundColor = .white
        vw_meetDescr.layer.masksToBounds = true
        vw_meetDescr.layer.borderColor = UIColor.lightGray.cgColor
        vw_meetDescr.layer.borderWidth = 1.0
        vw_meetDescr.layer.cornerRadius = 10.0
      
        vw_selectDate.backgroundColor = .white
        vw_selectDate.layer.masksToBounds = true
        vw_selectDate.layer.borderColor = UIColor.lightGray.cgColor
        vw_selectDate.layer.borderWidth = 1.0
        vw_selectDate.layer.cornerRadius = vw_selectDate.frame.size.height/2
        txt_selectDate.delegate = self
        txt_selectDate.placeholder = "Select"
        txt_selectDate.placeHolderColor = .black
        
        vw_selectTime.backgroundColor = .white
        vw_selectTime.layer.masksToBounds = true
        vw_selectTime.layer.borderColor = UIColor.lightGray.cgColor
        vw_selectTime.layer.borderWidth = 1.0
        vw_selectTime.layer.cornerRadius = vw_selectTime.frame.size.height/2
        txt_selectTime.delegate = self
        txt_selectTime.placeholder = "Select"
        txt_selectTime.placeHolderColor = .black
        
        vw_addUser.backgroundColor = .white
        vw_addUser.layer.masksToBounds = true
        vw_addUser.layer.borderColor = UIColor.lightGray.cgColor
        vw_addUser.layer.borderWidth = 1.0
        vw_addUser.layer.cornerRadius = vw_addUser.frame.size.height/2
       
        btn_addUser.contentHorizontalAlignment = .left
        btn_addUser.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        
        vw_create.backgroundColor = .red
        vw_create.layer.masksToBounds = true
        vw_create.layer.cornerRadius = vw_create.frame.size.height/2
        self.setFontandColorforButton(btn: btnCreate, color: obj.commonwhiteColor, font: obj.RegularFont, size: obj.semiBoldfontSize)
        
        lbl_desc.text = "Meeting Description"
        lblTime.text = "Select Time"
        lblDate.text = "Select Date"
        lbl_user.text = "Add User"
        
         self.setFontandColor(lbl: lbl_desc, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lblDate, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lblTime, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
        self.setFontandColor(lbl: lbl_user, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
        
         self.setFontandColorforButton(btn: btn_addUser, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
        
        txt_meetDesc.delegate = self
        txt_meetDesc.text = "Write here..."
        txt_meetDesc.textColor = UIColor.gray

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setUpNavi()
        
    }
    
    internal func setUpNavi(){
        
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1 {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK:- Custom Method To Set Font and Color
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat){
        
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    func setFontandColorforButton(btn:UIButton,color:UIColor,font:String,size:CGFloat){
        
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray{
            textView.text = nil
            textView.textColor = UIColor.black
           
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write here..."
            textView.textColor = UIColor.gray
          
        }
    }
    
    //TODO: Time picker
    func showTimePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePickerTime));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txt_selectTime.inputAccessoryView = toolbar
        txt_selectTime.inputView = datePicker
        let minDate = setMinAndMaxDateForDatePicker(maxYear: 50, minYear: 0).0
        let maxDate = setMinAndMaxDateForDatePicker(maxYear: 50, minYear: 0).1
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        
    }
    //TODO: Date picker
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txt_selectDate.inputAccessoryView = toolbar
        txt_selectDate.inputView = datePicker
        let minDate = setMinAndMaxDateForDatePicker(maxYear: 50, minYear: 0).0
        let maxDate = setMinAndMaxDateForDatePicker(maxYear: 50, minYear: 0).1
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        
    }
    
    func setMinAndMaxDateForDatePicker(maxYear: Int,minYear: Int) -> (Date , Date) {
        
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -minYear
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = maxYear
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        return( minDate,maxDate)
    }
    
    @objc func donedatePickerTime(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        txt_selectTime.text = formatter.string(from: datePicker.date)
        
        let time = datePicker.timeZone
        print(time as Any)
        self.view.endEditing(true)
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txt_selectDate.text = formatter.string(from: datePicker.date)
        let time = datePicker.timeZone
        print(time as Any)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    //MARK:- Actions
    
    @IBAction func bt_addUserTap(_ sender: UIButton) {
        
        let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let vc = stroryBoard.instantiateViewController(withIdentifier: "UserListPopupVC") as! UserListPopupVC
        vc.arrUser = self.arrUser
        
        vc.updateCallBack = { (userArr)->Void in
            // do stuff with the result
            
            if userArr.count != 0{
                self.alert(message: "User added successfully")
                self.btn_addUser.setTitle("\(userArr.count) user added", for: .normal)
                self.newDict = userArr
                print("InvitationList",userArr)
            }else{
                
            }
           
        }
        
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func btn_craeteTap(_ sender: UIButton) {
        validation()
    }
    
    //MARK- Validation
    
    func validation(){
        
        var message = ""
        
        if  txt_meetDesc.text == "Write here..." ||  txt_meetDesc.text == "" {
            message = "Please enter description!"
            
        }else if txt_selectDate.text!.isEmpty{
            
            message = "Please Select Date!"
            
        }else if txt_selectTime.text!.isEmpty{
            
            message = "Please Select Time!"
            
        }else if btn_addUser.titleLabel?.text == "Add"{
            
            message = "Please Add User!"
        }
        
        if message != ""{
            
            alert(message: message)
            
        }else{
            
            apiCreateMeet()
        }
    }
    
}


//MARK:- Api Meeting list
extension MeetingDetailVC{
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func apiCreateMeet(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let newNSArray = self.newDict as NSArray
            let jsonData = try! JSONSerialization.data(withJSONObject: newNSArray)
            let jsonString = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            print(jsonString)
            
            let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
            
            let passData = ["Meeting_Request_By_Code":userData.value(forKey: "Code") ?? "",
                            "Meeting_Request_By_Name":userData.value(forKey: "Name") ?? "",
                            "Meeting_Request_By_Employee_Level":userData.value(forKey: "EmployeeLevel") ?? 0,
                            "Meeting_Description":txt_meetDesc.text!,
                            "Meeting_Date":txt_selectDate.text!,
                            "Meeting_Time":txt_selectTime.text!,
                            "invitationList":jsonString!]
            
            print("Pass Date \(passData)")
            
            Indicator.shared.showProgressView(self.view)
            conn.startConnectionWithSting("zoom/meetingCreate", method_type: .post, params: passData as! [NSString : NSObject]) { (responseJSON) in
                
                Indicator.shared.hideProgressView()
                print(responseJSON)
                
                let message = responseJSON.value(forKey: "message") as? String ?? ""
                
                if self.conn.responseCode == 1{
                    
                    if responseJSON.value(forKey: "response") as? Bool ?? false == true{
                        
                        if let dataArr = responseJSON.value(forKey: "dataArr") as? NSArray {
                            
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

extension MeetingDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_selectTime {
            if txt_selectDate.text != ""{
                showTimePicker()
            }else{
                self.alert(message: "Please select date first")
                
            }
            
        }else   if textField == txt_selectDate {
            showDatePicker()
        }
        
        
    }
}

