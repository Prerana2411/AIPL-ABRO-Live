//
//  DistributedSecSalesVC.swift
//  AIPL ABRO
//
//  Created by CST on 10/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown

class DistributedSecSalesVC: UIViewController {

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
    
    lazy var DistributorView = UIView()
    lazy var txt_Distributor = UITextField()
    lazy var btn_Distributor = UIButton()
    
    lazy var MonthView = UIView()
    lazy var txt_Month = UITextField()
    lazy var btn_Month = UIButton()
    
    lazy var YearView = UIView()
    lazy var txt_Year = UITextField()
    lazy var btn_Year = UIButton()
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    lazy var btn_addItem = UIButton()
    lazy var btn_SubmitReport = UIButton()
    let dropDown = DropDown()
    let getRetailerViewModel = RetailerViewModel()
    var type = String()
    var taggedCustomerCode = String()
    var date = String()
    
    lazy var stack : UIStackView = {
              
              let stack = UIStackView()
              stack.axis = .horizontal
              stack.spacing = 10
              stack.distribution = .fillEqually
              stack.alignment = .fill
              return stack
              
    }()
    lazy var baseview:UIView = {
        
        let view =  UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-350, width: self.view.frame.size.width, height: 350))
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        view.tag = 668
        
        return view
        
    }()
    let getSecDistViewModel = SecondaryDistributorViewModel()
    let obj = CommonClass.sharedInstance
    let getSecondaryDistributorViewModel = SecondaryDistributorViewModel()
    var getdistributorSecSalesModelArr = [distributorSecondarySalesModel]()
    
    var itemArr: [distributorSecondarySalesModel] = []{
       
        didSet{
            
            if (self.itemArr != oldValue){
                self.tableView.reloadData()
            }
            
        }
        willSet(newValue){
            
            self.itemArr = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavi()
        setDataOnScreen()
        getSecondaryDistributorViewModel.getdistributorSecSalesModel.append(distributorSecondarySalesModel(retailerCode: "", retailerName: "", createDate: "", quantity: "", month: "", year: ""))
        configTable()
        
        setTagOnButton(btn: btn_Distributor, tag: 2)
        setTagOnButton(btn: btn_Month, tag: 4)
        setTagOnButton(btn: btn_Year, tag: 5)
    }
    
    internal func setTagOnButton(btn:UIButton,tag:Int){
        
        btn.tag = tag
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
    }
    
    //MARK:- Btn Action
       //MARK:-
       
       @objc func btnClick(sender:UIButton){
           
           if sender.tag == 1{
               
              self.navigationController?.popViewController(animated: false)
               
           }else if sender.tag == 2{
               
            self.type = "Distributed"
               
               if self.getSecDistViewModel.getDistributorArr.count > 0 {
                   
                   self.dropDownDataSource(dataSource: self.getSecDistViewModel.getDistributorArr, txtFld: txt_Distributor, anchorView: DistributorView)
                   
               }
               
           }
           else if sender.tag == 4{
               
              
               
               self.txt_Month.text = ""
               self.DatePicker(sender: sender, txtFld: self.txt_Month)
               
           }else if sender.tag == 5{
               
              
               
               self.txt_Year.text = ""
               self.DatePicker(sender: sender, txtFld: self.txt_Year)
               
           }else if sender.tag == 7{
               
               if let baseViewTag = self.view.viewWithTag(668)
               {
                   if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                   {
                       let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat =  "yyyy-MM-dd"
                       
                       self.date = dateFormatter.string(from: datePicker.date)
                       
                       self.txt_Year.text = String(date.prefix(4))
                       let start = String.Index(utf16Offset: 5, in: date)
                       let end = String.Index(utf16Offset: 6, in: date)
                       let substring = String(date[start...end])
                       self.txt_Month.text = substring
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
           else if sender.tag == 10{
            
            validation()
            
           }else if sender.tag == 11{
             
            apidistributorSecondarySales()
            
           }
           
       }
    
    //MARK:- Validation
    //MARK:-
    
    func validation(){
        
        var message = ""
        
        if txt_Distributor.text!.isEmpty{
            
            message = "Please Select Distributor!"
            
        }else if txt_Year.text!.isEmpty && txt_Month.text!.isEmpty{
            
            message = "Please Select Month and Year!"
            
        }
        
        if message == "" {
            
             self.itemArr.append(distributorSecondarySalesModel(retailerCode: "", retailerName: "Retailer Name", createDate: self.date, quantity: "0", month: self.txt_Month.text!, year: self.txt_Year.text!))
            
        }else{
            
            alert(message: obj.createString(Str: message))
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
    
    //MARK:- Api distributorSecondarySalesIos
       //MARK:-
       
    func apidistributorSecondarySales(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            for i in 0..<(self.itemArr.count){
                
                self.getdistributorSecSalesModelArr.append(distributorSecondarySalesModel(retailerCode: self.itemArr[i].retailerCode, retailerName: self.itemArr[i].retailerName, createDate: self.itemArr[i].createDate, quantity: self.itemArr[i].quantity, month: self.itemArr[i].month, year: self.itemArr[i].year))
                
            }
            
            let encoder = JSONEncoder()
            do
            {
                let jsonData = try encoder.encode(getdistributorSecSalesModelArr)
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                let passDict = ["dataArray":jsonString ?? "","distributorCode":self.taggedCustomerCode,"distributorName":self.txt_Distributor.text!] as [String:Any]
                
                print(passDict)
                
                Indicator.shared.showProgressView(view)
                
                self.getSecDistViewModel.getApisecSalesDataResponseFromApiHandler(strUrl: "distributorSecondarySalesIos", passDict: passDict) { (message) in
                    
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
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
                
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
        view.addSubview(DistributorView)
        DistributorView.backgroundColor = .white
        DistributorView.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 25, paddingRight: 25, height: CGFloat(obj.commonHeight))
        DistributorView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        commonConstraint(object: txt_Distributor, mainView: DistributorView)
        commonConstraint(object: btn_Distributor, mainView: DistributorView)
        
        view.addSubview(stack)
        
        stack.withoutBottomAnchor(top: DistributorView.bottomAnchor, left: DistributorView.leftAnchor, right: DistributorView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight))
        stack.addArrangedSubview(MonthView)
        stack.addArrangedSubview(YearView)
        
        commonConstraint(object: txt_Month, mainView: MonthView)
        commonConstraint(object: btn_Month, mainView: MonthView)
        
        commonConstraint(object: txt_Year, mainView: YearView)
        commonConstraint(object: btn_Year, mainView: YearView)
        
        view.addSubview(self.tableView)
        
        tableView.scrollAnchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 25, paddingRight: 15)
        self.view.bringSubviewToFront(baseview)
        apidistributerList()

    }
    
    
    func setDataOnScreen(){
           
           setFontColor(txt: txt_Distributor, btn: btn_Distributor, text: "Select Distributor", view: DistributorView,image:#imageLiteral(resourceName: "down"))
           setFontColor(txt: txt_Month, btn: btn_Month, text: "Month", view: MonthView, image: #imageLiteral(resourceName: "calendar"))
           setFontColor(txt: txt_Year, btn: btn_Year, text: "Year", view: YearView, image: #imageLiteral(resourceName: "calendar"))
           setItemONButton(btn: btn_SubmitReport, image: UIImage(), text: "Submit Report", textColor: .white, backcolor: obj.commonAppRedColor)
           setItemONButton(btn: btn_addItem, image: UIImage(), text: "Add Item", textColor: .white, backcolor: obj.commonAppRedColor)
           titleHeader.text = obj.createString(Str: "Distributed Secondary Sales")
       }
    
    //MARK:- Set Font and Color
     
     func setFontColor(txt:UITextField,btn:UIButton,text:String,view:UIView,image:UIImage){
         
         view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
         view.layer.shadowOpacity = 0.5
         view.layer.shadowRadius = 0.5
         view.layer.masksToBounds = false
         view.backgroundColor = .white
        
         txt.placeholder = obj.createString(Str: text)
         txt.textColor = obj.commonAppTextDrakColor
         txt.font = UIFont(name: obj.RegularFont, size: 16)
         
         btn.setImage(image, for: .normal)
         btn.contentHorizontalAlignment = .right
         
     }
     
     func lblFontColor(lbl:UILabel,text:String){
         
         lbl.text = obj.createString(Str: text)
         lbl.font = UIFont(name: obj.RegularFont, size: 12)
         lbl.textColor = obj.commonAppTextDrakColor
         lbl.numberOfLines = 0
     }
     
     func setItemONButton(btn:UIButton,image:UIImage,text:String,textColor:UIColor,backcolor:UIColor){
         
         btn.setImage(image, for: .normal)
         btn.setTitleColor(textColor, for: .normal)
         btn.setTitle(text, for: .normal)
         btn.backgroundColor = backcolor
         btn.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
         
     }
    
    func commonConstraint(object:UIView,mainView:UIView){
        
        mainView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        mainView.addSubview(object)
        object.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
       
    }
}

//MARK:- tableview delegate and datasource
//MARK:-

extension DistributedSecSalesVC:UITableViewDelegate,UITableViewDataSource{
   
    
    func configTable(){
        
        self.tableView.register(DistributedCell.self, forCellReuseIdentifier: "\(DistributedCell.self)")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceHorizontal = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = .clear
        self.tableView.bounces = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return self.itemArr.count + 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(DistributedCell.self)", for: indexPath) as! DistributedCell
        
        if indexPath.row == 0{
            
            lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: "SNo")
           // lblBackColor(lbl: cell.lbl_RetailerName, backColor: .clear, text: "Retailer Name")
            cell.lbl_RetailerName.setFontandColor(txtFld: cell.lbl_RetailerName, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Retailer Name")
            cell.lbl_RetailerName.text = "Retailer Name"
            cell.lbl_RetailerName.textAlignment = .center
            cell.txt_Value.text = obj.createString(Str: "Value")
            cell.txt_Value.font = UIFont(name: obj.RegularFont, size: 14)
            cell.txt_Value.isUserInteractionEnabled = false
            cell.txt_Value.backgroundColor = .clear
            cell.txt_Value.textColor = obj.commonAppTextDrakColor
            setItemONButton(btn: cell.btn_RetailerName, image: UIImage(), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
            
        }else{
            
            lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: String(indexPath.row))
            cell.lbl_RetailerName.setFontandColor(txtFld: cell.lbl_RetailerName, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: self.itemArr[indexPath.row - 1].retailerName)
            cell.lbl_RetailerName.textAlignment = .center
            cell.txt_Value.text = obj.createString(Str: self.itemArr[indexPath.row - 1].quantity)
            cell.txt_Value.font = UIFont(name: obj.RegularFont, size: 14)
            cell.txt_Value.isUserInteractionEnabled = true
            cell.lbl_RetailerName.backgroundColor = .white
            cell.txt_Value.backgroundColor = .white
            cell.txt_Value.textColor = obj.commonAppTextDrakColor
            cell.delegate = self
            cell.getSecDistViewModel = self.getSecDistViewModel
            cell.btn_RetailerName.tag = indexPath.row - 1
            setItemONButton(btn: cell.btn_RetailerName, image: #imageLiteral(resourceName: "down"), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(btn_addItem)
        view.addSubview(btn_SubmitReport)
        
        btn_addItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([btn_addItem.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
                                     btn_addItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
                                     btn_addItem.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     btn_addItem.widthAnchor.constraint(equalToConstant: 100)])
        btn_addItem.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        btn_SubmitReport.scrollAnchor(top: btn_addItem.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 45, paddingBottom: 25, paddingRight: 45)
        btn_SubmitReport.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)).isActive = true
        btn_SubmitReport.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        setTagOnButton(btn: btn_addItem, tag: 10)
        setTagOnButton(btn: btn_SubmitReport, tag: 11)
        return view
        
    }
    
    func lblBackColor(lbl:UILabel,backColor:UIColor,text:String){
        lbl.textAlignment = .center
        lbl.backgroundColor = backColor
        lblFontColor(lbl: lbl, text: text)
    }
    
    
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
}

extension DistributedSecSalesVC:NewRetailerVCDelegate,retailerNameTypeDelegate{
    
    
    func retailerName(index: Int, type: String, text: String, indexPath: Int) {
        
        if type == "RetailerName"{
            
            self.itemArr[index].retailerName = text
            self.itemArr[index].retailerCode = self.getSecDistViewModel.getRetailerCode[indexPath]
            
        }else if type == "Value"{
            
            self.itemArr[index].quantity = text
        }
        
    }
    
    func index(index: Int, text: String) {
        
        if self.type == "Distributed"{
            self.type = ""
            self.taggedCustomerCode = self.getSecDistViewModel.getDistributorCode[index]
            apidistributerRetailer(taggedCustomerCode:self.getSecDistViewModel.getDistributorCode[index])
        }
        
    }
    
    
    func apidistributerRetailer(taggedCustomerCode:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["taggedCustomerCode":taggedCustomerCode] as [String:Any]
            Indicator.shared.showProgressView(self.view)
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
    
}
