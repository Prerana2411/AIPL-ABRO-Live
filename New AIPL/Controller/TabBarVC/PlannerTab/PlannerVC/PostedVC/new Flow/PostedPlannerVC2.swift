//
//  PostedPlannerVC2.swift
//  AIPL ABRO
//
//  Created by CST on 13/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit



class PostedPlannerVC2: UIViewController {

    
    //MARK:- Variable
    //MARK:-
    lazy var navView : UIView = {
        
        let view = UIView()
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        return view
    }()
    
    lazy var leftBtn :UIButton = {
        
        let btn = UIButton()
        btn.tag = 1
        btn.setImage(UIImage(named: "back1"), for: .normal)
        btn.contentMode = .center
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
        
    }()
    
    lazy var titleHeader:UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    lazy var stackForDateMonthYear : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    lazy var date_View = UIView()
    lazy var month_View = UIView()
    lazy var year_View = UIView()
    lazy var date_lbl = UITextField()
    lazy var month_lbl = UITextField()
    lazy var year_lbl = UITextField()
    lazy var date_btn = UIButton()
    lazy var month_btn  = UIButton()
    lazy var year_btn  = UIButton()
    var Date = String()
    lazy var btn_Submit : UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "Show"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        return btn
        
    }()
    lazy var baseview:UIView = {
           
           let view =  UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-350, width: self.view.frame.size.width, height: 350))
           view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
           view.tag = 668
           
           return view
           
    }()
    
    lazy var lbl_PlannerNo = UILabel()
    lazy var lbl_SalesPerson = UILabel()
    lazy var lbl_SP_Name = UILabel()
    lazy var lbl_SP_Number = UILabel()
    lazy var lbl_SP_Email = UILabel()
    lazy var lbl_Month = UILabel()
    lazy var lbl_Year = UILabel()
    var getPlannerViewModel = PlannerViewModel()
    var getDailyRegisterSalesViewModel = DailyRegisterSalesViewModel()
    lazy var StackForIUpperLbls : UIStackView = {
        
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 3
        return stack
        
    }()
    
    lazy var tableView : UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
        
    }()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    let obj = CommonClass.sharedInstance
    
    let noOfItemArr1 = ["Market:","Total Primary Sales Target:","Total Primary Sale:","Today Primary Sales:","Total Collection Tgt:","Today Collection:","Total Collection:","Total No. of Customers:","No. of Customers Billed:","No.ASO:","Total Sec. value(self):","Total Call Target:","Total Calls:","Total Productive Call:","Cumulative Sec Value:","No. of calls(self):","Remarks:"]
    
    let noOfItemArr = ["Period of Reprt :","Towns Worked:","RSM Contacted:","ASM Contacted:","SO Contacted:","Parties Met:","Primary Target (Month ):","Primary Achievement till date:","Primary Projection for Month:","Week Primary Target:","Week Primary Achievement:","Projection for next week:","Total No. of Distributors:","No. of Distributors billed till date:","Collection Target ( Month ):","Collection Achievement till date:","Collection Projection for Month:","Collection Projection for next week:","Above 120 Days O/S:","Collected till Date:","Non Moving O/S:","Collected till Date:","Total Number of Districts:","Number of Districts with No Distributors:","Plan of Distributor Appointment this month:","Number Appointed till date:","Number of 1 L + Towns in Zone:","Number of 1 L + towns with no Distributors:","Plan of Distributor Appointment this month:","Number Appointed till date:","New Distributor Appt. Plan- (Town Names):","New Distributor Appointed ( Town Names ):","Market Feedback / Any other observations"]
    
    let noOfItemArr2 = ["Town Worked:","Worked With ASM/ASO Name:","Activity For The Day:","Collection Target:","Distributors/Dealers/Retailers Met:","Achievement Till Date:","Month target:","Collection target For The day:","Collection For The Day:","Primary Target For The Day:","Above 120 O/S:","Primary Billing For The Day:","Collected Till Date:","Total No Of Distributors:","Non-Moving O/S:","No of Distributors Billed This Month:","No of ASOs Sanctioned:","No of ASOs in System:","No of ASOs Working Today:","Vacant HQs:","New Distributor Appointed Plan:","New Distributor Appointed:"]
    
    var txtFldArr = [String]()
    
    var keyDict = ["Period of Reprt","Towns Worked","RSM Contacted","ASM Contacted","SO Contacted","Parties Met","Primary Target","Primary Achievement","Primary Projection","Week Primary Target","Week Primary Achievement","Projection","Total No Of Distributors","No Of Distributors","Collection Target","Collection Achievement","Collection Projection","Collection Projection For Next Week","Above 120 Days O/S","Collected","Non Moving O/S","Collected Till Date","Total Number of Districts","Number Of Districts With No Distributors","Plan of Distributor Appointment This Month","Number Appointed Till Date","Number of 1 L + Towns In Zone","Number of 1 L + Towns With No Distributors","New Distributor Appointed Plan","New Distributor Appointed","Market Feedback"]
    
    var keyDict1 = ["Market","Total Primary Sales Tgt","Total Primary Sales","Today Primary Sale","Total Collection Tgt","Today Collection","Total Collection","Total No of Customers","No of Customers Billed","No ASO","Total Secondary value","Total Call Target","Total Calls","Total Productive Call","Cumulative Secondary Value","No of Calls","Remarks"]
    var keyDict2 = ["Town Worked","Worked With ASM/ASO Name","Activity For The Day","Collection Target","Distributors/Dealers/Retailers Met","Achievement Till Date","Month target","Collection target For The day","Collection For The Day","Primary Target For The Day","Above 120 O/S","Primary Billing For The Day","Collected Till Date","Total No Of Distributors","Non-Moving O/S","No of Distributors Billed This Month","No of ASOs Sanctioned","No of ASOs in System","No of ASOs Working Today","Vacant HQs","New Distributor Appointed Plan","New Distributor Appointed"]
    
    var validationArr = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setDataOnScreen()
        
        if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 6{
            
            for _ in 0..<noOfItemArr.count{

                txtFldArr.append("")
                validationArr.append(false)
            }
            
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 7{
            
            for _ in 0..<noOfItemArr2.count{

                txtFldArr.append("")
                validationArr.append(false)
            }
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 10{
            
            for _ in 0..<noOfItemArr1.count{
                
                txtFldArr.append("")
                validationArr.append(false)
            }
            
        }
        
        
        self.tableView.isHidden = true
    }
    

    //MARK:- Method to set Navi On Screen
    //MARK:-
       internal func setUpNavi(){
             
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
        
        view.addSubview(stackForDateMonthYear)
        
        
        stackForDateMonthYear.translatesAutoresizingMaskIntoConstraints = false
        stackForDateMonthYear.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: CGFloat(obj.commonHeight))
        stackForDateMonthYear.addArrangedSubview(date_View)
        stackForDateMonthYear.addArrangedSubview(month_View)
        stackForDateMonthYear.addArrangedSubview(year_View)
        
        _ = date_View.CommonViewLableButton(view: date_View, btn: date_btn, lbl: date_lbl)
        _ = month_View.CommonViewLableButton(view: month_View, btn: month_btn, lbl: month_lbl)
        _ = year_View.CommonViewLableButton(view: year_View, btn: year_btn, lbl: year_lbl)
        
        view.addSubview(btn_Submit)
        
        btn_Submit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_Submit.topAnchor.constraint(equalTo: year_View.bottomAnchor, constant: 15),
                                     btn_Submit.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     btn_Submit.widthAnchor.constraint(equalToConstant: 90),
                                     btn_Submit.rightAnchor.constraint(equalTo: year_View.rightAnchor)])
        
        view.addSubview(tableView)
        
        tableView.scrollAnchor(top: btn_Submit.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 15, paddingRight: 15)
        
        titleHeader.setFontAndColor(lbl: titleHeader, text: "Daily Sales Register", textColor: .white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        
        date_lbl.setFontandColor(txtFld: date_lbl, color: .black, font: obj.RegularFont, size: obj.regularfontSize, text: "Date")
        month_lbl.setFontandColor(txtFld: month_lbl, color: .black, font: obj.RegularFont, size: obj.regularfontSize, text: "Month")
        year_lbl.setFontandColor(txtFld: year_lbl, color: .black, font: obj.RegularFont, size: obj.regularfontSize, text: "Year")
        
        date_btn.setDataOnButton(btn: date_btn, text: "", font: "", size: 0, textcolor: UIColor(), image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        month_btn.setDataOnButton(btn: month_btn, text: "", font: "", size: 0, textcolor: UIColor(), image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        year_btn.setDataOnButton(btn: year_btn, text: "", font: "", size: 0, textcolor: UIColor(), image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        
        btn_Submit.setDataOnButton(btn: btn_Submit, text: "Show", font: obj.MediumFont, size: obj.semiBoldfontSize, textcolor: .white, image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
        configTable()
        
        setTagandAction(btn: date_btn, tag: 2)
        setTagandAction(btn: month_btn, tag: 3)
        setTagandAction(btn: year_btn, tag: 4)
        setTagandAction(btn: btn_Submit, tag: 5)
    }

    internal func setDataOnScreen(){
        
      
    }
    
    func setTagandAction(btn:UIButton,tag:Int){
        
        btn.tag = tag
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
    }
    
    //MARK:- UIbutton Action
    //MARK:-
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 3 || sender.tag == 4 || sender.tag == 2{
            
             month_lbl.text = ""
             year_lbl.text = ""
             date_lbl.text = ""
             DatePicker(sender: sender, txtFld: date_lbl)
            
        }else if sender.tag == 5 {
            
            if date_lbl.text!.isEmpty{
                
                alert(message: obj.createString(Str: "Please enter date!"))
                
            }else{
                
                self.apicheckDayRegister()
            }
            
        }else if sender.tag == 6{
            
            self.validation()
            
        }else if sender.tag == 7{
            
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let date = dateFormatter.string(from: datePicker.date)
                    
                    self.Date = date
                    self.date_lbl.text = String(date.suffix(2))
                    self.year_lbl.text = String(date.prefix(4))
                    let start = String.Index(utf16Offset: 5, in: date)
                    let end = String.Index(utf16Offset: 6, in: date)
                    let substring = String(date[start...end])
                    self.month_lbl.text = substring
                    baseViewTag.removeFromSuperview()
                    datePicker.removeFromSuperview()
                }
            }
            
        }else if sender.tag == 8{
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                baseViewTag.removeFromSuperview()
            }
            
        }
        
    }
}


//MARK:- Configure tableView
//MARK:-

extension PostedPlannerVC2: UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
        
        self.tableView.register(PostedPlannerCell2.self, forCellReuseIdentifier: "\(PostedPlannerCell2.self)")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 6{
            
            return self.noOfItemArr.count
            
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 7{
            
            return self.noOfItemArr2.count
            
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 10{
            
            return self.noOfItemArr1.count
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(PostedPlannerCell2.self)", for: indexPath) as! PostedPlannerCell2
       
        
        if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 6{
            
             cell.lbl.setFontAndColor(lbl: cell.lbl, text: self.noOfItemArr[indexPath.row], textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 14)
            
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 7{
            
            cell.lbl.setFontAndColor(lbl: cell.lbl, text: self.noOfItemArr2[indexPath.row], textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 14)
            
        }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 10{
            
            cell.lbl.setFontAndColor(lbl: cell.lbl, text: self.noOfItemArr1[indexPath.row], textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 14)
            
        }
        
        cell.txtFld.tag = indexPath.row
        cell.txtFld.text = txtFldArr[indexPath.row]
        cell.txtFld.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        
      //  view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let btnSave = UIButton()
        view.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btnSave.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                                     btnSave.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
                                     btnSave.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                                     btnSave.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        btnSave.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        btnSave.setDataOnButton(btn: btnSave, text: "Save", font: obj.MediumFont, size: obj.semiBoldfontSize, textcolor: .white, image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
        setTagandAction(btn: btnSave, tag: 6)
        return view
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


extension PostedPlannerVC2:UITextFieldDelegate{
    
    //MARK:- TextFld Delegate
    //MARK:-
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(textField.tag)
        print(textField.text ?? "")
        
        self.txtFldArr[textField.tag] = textField.text ?? ""
        
        if !textField.text!.isEmpty{
            
            self.validationArr[textField.tag] = true
        }
        
        self.tableView.reloadData()
    }
    
    //MARK:- Api checkDayRegister
    //MARK:-
    
    func apicheckDayRegister(){
     
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passData = ["Date":self.Date,"salesPersoneCode":self.userData.value(forKey: "Code") as? String ?? ""]
            print(passData)
            Indicator.shared.showProgressView(self.view)
            
            getDailyRegisterSalesViewModel.getDaliyRegisterDataFromApiHandler(strUrl: "checkDayRegister", passDict: passData) { (responseMessage) in
                
                if responseMessage == "Data found"{
                    
                     self.tableView.isHidden = false
                    
                }else{
                    
                    self.alert(message: responseMessage)
                }
                
            }
           
           
        }else{
            
          alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
            
        }
        
    }
    
    //MARK:- Api ZSMsecondrySalesCreate Implementation
    //MARK:-
    
    func apiZSMsecondrySalesCreate(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            var passDict = NSMutableDictionary()
            var apiType = String()
            
            if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 6{
                
                passDict = ["Planner No":getDailyRegisterSalesViewModel.plannerArr[0],"Planner Line No":getDailyRegisterSalesViewModel.lineNoArr[0],"Planner City":getDailyRegisterSalesViewModel.cityArr[0],"Planner Date":self.Date,"Actual Travel City":getDailyRegisterSalesViewModel.cityArr[0],"Month":month_lbl.text ?? "","Year":year_lbl.text ?? "","Sales Person Code":userData.value(forKey: "Code") ?? "","Sales Person Name":userData.value(forKey: "Name") ?? "","Beat":getDailyRegisterSalesViewModel.cityArr[0],"Zone":userData.value(forKey: "Zone") ?? ""]
                
                for i in 0..<(keyDict.count){
                    
                    passDict.addEntries(from: [keyDict[i] : txtFldArr[i]])
                    
                }
                
                apiType = "ZSMsecondrySalesCreate"
                
            }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 7{
                
                passDict = ["Planner No":getDailyRegisterSalesViewModel.plannerArr[0],"Planner Line No":getDailyRegisterSalesViewModel.lineNoArr[0],"Planner Date":self.Date]
                
                for i in 0..<(keyDict2.count){
                    
                    passDict.addEntries(from: [keyDict2[i] : txtFldArr[i]])
                    
                }
                
                apiType = "RSMsecondrySalesCreate"
                
            }else if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 10{
                
                passDict = ["Planner No":getDailyRegisterSalesViewModel.plannerArr[0],"Planner Line No":getDailyRegisterSalesViewModel.lineNoArr[0],"Planner Date":self.Date]
                
                for i in 0..<(keyDict1.count){
                    
                    passDict.addEntries(from: [keyDict1[i] : txtFldArr[i]])
                    
                }
                 apiType = "ASMsecondrySalesCreate"
                
            }
            
            print(passDict)
            
            Indicator.shared.showProgressView(view)
            
            getDailyRegisterSalesViewModel.getDaliyRegisterDataFromApiHandler(strUrl: apiType, passDict: passDict as! [String : Any]) { (responseMessage) in
                
                print(responseMessage)
                
                if responseMessage == "Data created"{
                    
                    self.alertWithHandler(message: self.obj.createString(Str: responseMessage)) {
                        self.navigationController?.popViewController(animated: false)
                    }
                }else{
                    
                    self.alert(message: self.obj.createString(Str: responseMessage))
                }
                
            }
            
        }else{
            
             self.alert(message: obj.createString(Str: "Please check your internet connection"))
            
        }
        
    }
    
    //MARK:- Validation
    
    //MARK:- For Save Btn
    
    func validation(){
        
        var message = ""
        
        for item in validationArr{
            
            if item == false{
                
                message = "Please enter all fields!"
            }
            
        }
        
        if message == ""{
            
            self.apiZSMsecondrySalesCreate()
            
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
}

