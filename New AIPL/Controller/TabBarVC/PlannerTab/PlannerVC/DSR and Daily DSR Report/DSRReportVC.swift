//
//  DSRReportVC.swift
//  AIPL ABRO
//
//  Created by CST on 28/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class DSRReportVC: UIViewController {

    //MARK:- Variable
    //MARK:-
    
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
    
    lazy var SalesPersonView = UIView()
    lazy var txt_SalesPerson = UITextField()
    lazy var btn_SalesPerson = UIButton()
    
    lazy var MonthView = UIView()
    lazy var txt_Month = UITextField()
    lazy var btn_Month = UIButton()
    
    lazy var YearView = UIView()
    lazy var txt_Year = UITextField()
    lazy var btn_Year = UIButton()
    
    lazy var btn_Show = UIButton()
    
    lazy var stack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    let obj = CommonClass.sharedInstance
    let getDSRReportViewModelObj = DSRReportViewModel()
    var titleheader = String()
    var txt1 = String()
    var txt2 = String()
    var datePickerType = String()
    
    lazy var baseview:UIView = {
        
        let view =  UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-350, width: self.view.frame.size.width, height: 350))
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        view.tag = 668
        
        return view
        
    }()
    
    //MARK:- LifeCycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        setUpNavi()
        setDataOnScreen()
    }

    //MARK:- Method to set Navi On Screen
    //MARK:-
       internal func setUpNavi(){
                   
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
        view.addSubview(SalesPersonView)
        SalesPersonView.backgroundColor = .white
        SalesPersonView.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 15, paddingRight: 15, height: CGFloat(obj.commonHeight))
        SalesPersonView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        commonConstraint(object: txt_SalesPerson, mainView: SalesPersonView)
       // commonConstraint(object: btn_SalesPerson, mainView: SalesPersonView)
        
        view.addSubview(stack)
       
        stack.withoutBottomAnchor(top: SalesPersonView.bottomAnchor, left: SalesPersonView.leftAnchor, right: SalesPersonView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight))
       
        stack.addArrangedSubview(MonthView)
        stack.addArrangedSubview(YearView)
        
        MonthView.backgroundColor = .white
        YearView.backgroundColor = .white
        
        commonConstraint(object: txt_Month, mainView: MonthView)
        commonConstraint(object: btn_Month, mainView: MonthView)
        
        commonConstraint(object: txt_Year, mainView: YearView)
        commonConstraint(object: btn_Year, mainView: YearView)
        
        btn_Month.tag = 2
        btn_Year.tag = 3
        
        btn_Year.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        btn_Month.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
        view.addSubview(btn_Show)
        
        btn_Show.withoutBottomAnchor(top: stack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 55, paddingLeft: 50, paddingRight: 50, height: CGFloat(obj.commonHeight))
        btn_Show.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        btn_Show.tag = 4
        btn_Show.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
        self.view.bringSubviewToFront(self.baseview)
    }
    
    func commonConstraint(object:UIView,mainView:UIView){
        
           mainView.layer.borderWidth = 1.0
           mainView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           mainView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
           mainView.addSubview(object)
           object.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
          
    }
    
    func setDataOnScreen(){
        
        titleHeader.setFontAndColor(lbl: titleHeader, text: titleheader, textColor: .white, font: obj.BoldFont, size: (obj.BoldfontSize))
        txt_Month.setFontandColor(txtFld: txt_Month, color: obj.commonAppTextDrakColor, font: obj.MediumFont, size: obj.semiBoldfontSize, text: txt1)
        txt_Year.setFontandColor(txtFld: txt_Year, color: obj.commonAppTextDrakColor, font: obj.MediumFont, size: obj.semiBoldfontSize, text: txt2)
        txt_SalesPerson.setFontandColor(txtFld: txt_SalesPerson, color: obj.commonAppTextDrakColor, font: obj.MediumFont, size: obj.semiBoldfontSize, text: "Salesperson")
        
        txt_SalesPerson.text = userData.value(forKey: "Name") as? String ?? ""
        
        btn_Year.setDataOnButton(btn: btn_Year, text: "", font: "", size: 0, textcolor: .clear, image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        btn_Month.setDataOnButton(btn: btn_Month, text: "", font: "", size: 0, textcolor: .clear, image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        btn_SalesPerson.setDataOnButton(btn: btn_SalesPerson, text: "", font: "", size: 0, textcolor: .clear, image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        btn_Show.setDataOnButton(btn: btn_Show, text: "Show", font: obj.MediumFont, size: obj.semiBoldfontSize, textcolor: .white, image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
    }

    //MARK:- Btn Action
    //MARK:-
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
            
        }else if sender.tag == 2{
            self.datePickerType = "From"
            self.txt_Month.text = ""
            self.DatePicker(sender: sender, txtFld: self.txt_Month)
            
        }else if sender.tag == 3{
             self.datePickerType = "To"
            self.txt_Year.text = ""
            self.DatePicker(sender: sender, txtFld: self.txt_Year)
        }else if sender.tag == 4{
            
            validation()
            
        }else if sender.tag == 7 {
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let date = dateFormatter.string(from: datePicker.date)
                    
                    if self.txt2 == "To"{
                        
                        if datePickerType == "From"{
                           
                            self.txt_Month.text = date
                            
                        }else{
                            
                            self.txt_Year.text = date
                        }
                        
                        
                    }else{
                        
                        self.txt_Year.text = String(date.prefix(4))
                        let start = String.Index(utf16Offset: 5, in: date)
                        let end = String.Index(utf16Offset: 6, in: date)
                        let substring = String(date[start...end])
                        self.txt_Month.text = substring
                        
                    }
                    
                    baseViewTag.removeFromSuperview()
                    datePicker.removeFromSuperview()
                }
            }
            
        }else if sender.tag == 8 {
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                baseViewTag.removeFromSuperview()
            }
        }
        
    }
    
    //MARK:- Validation
    //MARK:-
    
    func validation(){
        
        var message = ""
        
        if txt_SalesPerson.text!.isEmpty{
            
            message = "Please Enter Sales Persons!"
            
        }else if txt_Month.text!.isEmpty{
            
            message = "Please Select Month!"
            
        }else if txt_Year.text!.isEmpty{
            
            message = "Please Select Year!"
        }
        
        if message == ""{
            
            if titleheader == "Daily DSR Report"{
                
                self.apidsrReport(apiType: "dsrReportDate")
                
            }else if titleheader == "Attendance Report" {
                
                self.apidsrReport(apiType: "attendanceReport")
                
            }else{
                
              self.apidsrReport(apiType: "dsrReportMonth")
            }
            
            
        }else{
            
            alert(message: obj.createString(Str: message))
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
    
    
}

//MARK:- Api dsrReportMonth
//MARK:-
extension DSRReportVC{
    
    func apidsrReport(apiType:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            var passDict = [String:Any]()
            
            if txt2 == "To"{
               
             passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? "","startDate":self.txt_Month.text ?? "","endDate":self.txt_Year.text ?? ""] as [String:Any]
                
            }else{
             
            passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? "","month":self.txt_Month.text ?? "","year":self.txt_Year.text ?? ""] as [String:Any]
                
            }
            
            Indicator.shared.showProgressView(view)
            
            self.getDSRReportViewModelObj.getApiDataFromApiHandler(strUrl: apiType, passDict: passDict) { (responseMessage) in
                
                print(responseMessage)
                if responseMessage == "Data found"{
                    
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(URL(string: "http://13.58.229.225/public/excel/\(self.getDSRReportViewModelObj.url)")!, options: [:], completionHandler: nil)
                        
                    } else {
                        UIApplication.shared.openURL(URL(string: "http://13.58.229.225/public/excel/\(self.getDSRReportViewModelObj.url)")!)
                    }
                    
                }
                

            }
            
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
        
    }
    
}
