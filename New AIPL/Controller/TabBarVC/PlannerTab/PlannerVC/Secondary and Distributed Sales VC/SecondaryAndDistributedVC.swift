//
//  SecondaryAndDistributedVC.swift
//  AIPL ABRO
//
//  Created by CST on 16/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown
class SecondaryAndDistributedVC: UIViewController {

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
    
    lazy var RetailerView = UIView()
    lazy var txt_Retailer = UITextField()
    lazy var btn_Retailer = UIButton()
    
    lazy var MonthView = UIView()
    lazy var txt_Month = UITextField()
    lazy var btn_Month = UIButton()
    
    lazy var YearView = UIView()
    lazy var txt_Year = UITextField()
    lazy var btn_Year = UIButton()
    lazy var btn_Show = UIButton()
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    lazy var btn_SubmitReport = UIButton()
    
    lazy var stack : UIStackView = {
              
              let stack = UIStackView()
              stack.axis = .horizontal
              stack.spacing = 10
              stack.distribution = .fillEqually
              stack.alignment = .fill
              return stack
              
    }()
    
    var contentViewSize = CGSize()
    var titleHeaderName = String()
    // ScrollView
    lazy var scrollView:UIScrollView = {
        
        let sv = UIScrollView(frame: .zero)
        sv.bounces = false
        sv.backgroundColor = .clear
        sv.alwaysBounceHorizontal = true
        return sv
        
    }()
    
    lazy var insideView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let obj = CommonClass.sharedInstance
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    let getSecDistViewModel = SecondaryDistributorViewModel()
    let getRetailerViewModel = RetailerViewModel()
    let dropDown = DropDown()
    var type = String()
    var retailerCode = String()
    var arrForsecSalesChainCreate = [DistributedChainModel]()
    
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

        self.tableView.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       
        setTagOnButton(btn: btn_Distributor, tag: 2)
        setTagOnButton(btn: btn_Retailer, tag: 3)
        setTagOnButton(btn: btn_Month, tag: 4)
        setTagOnButton(btn: btn_Year, tag: 5)
        setTagOnButton(btn: btn_Show, tag: 9)
        setDataOnScreen()
        self.setUpNavi()
        
    }

    internal func setTagOnButton(btn:UIButton,tag:Int){
        
        btn.tag = tag
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
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
        
        view.addSubview(RetailerView)
        RetailerView.backgroundColor = .white
        RetailerView.withoutBottomAnchor(top: DistributorView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 25, paddingRight: 25, height: CGFloat(obj.commonHeight))
        RetailerView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        commonConstraint(object: txt_Retailer, mainView: RetailerView)
        commonConstraint(object: btn_Retailer, mainView: RetailerView)
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: RetailerView.bottomAnchor, constant: 15),
                                     stack.leftAnchor.constraint(equalTo: RetailerView.leftAnchor, constant: 0),
                                     stack.widthAnchor.constraint(equalTo: RetailerView.widthAnchor, multiplier: 0.7),
                                     stack.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        
        stack.addArrangedSubview(MonthView)
        stack.addArrangedSubview(YearView)
        stack.addArrangedSubview(MonthView)
        commonConstraint(object: txt_Month, mainView: MonthView)
        commonConstraint(object: txt_Year, mainView: YearView)
        commonConstraint(object: btn_Month, mainView: MonthView)
        commonConstraint(object: btn_Year, mainView: YearView)
        
        view.addSubview(btn_Show)
        
        btn_Show.withoutBottomAnchor(top: stack.topAnchor, left: stack.rightAnchor, right: DistributorView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: 0, height: CGFloat(obj.commonHeight))
        btn_Show.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        view.addSubview(tableView)
        self.tableView.scrollAnchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        self.view.bringSubviewToFront(baseview)
        apidistributerList()
    }
    
    func setDataOnScreen(){
        
        setFontColor(txt: txt_Retailer, btn: btn_Retailer, text: "Select", view: RetailerView, image: #imageLiteral(resourceName: "down"))
        setFontColor(txt: txt_Distributor, btn: btn_Distributor, text: "Select Distributor", view: DistributorView,image:#imageLiteral(resourceName: "down"))
        setFontColor(txt: txt_Month, btn: btn_Month, text: "Month", view: MonthView, image: #imageLiteral(resourceName: "calendar"))
        setFontColor(txt: txt_Year, btn: btn_Year, text: "Year", view: YearView, image: #imageLiteral(resourceName: "calendar"))
        setItemONButton(btn: btn_Show, image: UIImage(), text: "Show", textColor: .white, backcolor: obj.commonAppRedColor)
        setItemONButton(btn: btn_SubmitReport, image: UIImage(), text: "Submit Report", textColor: .white, backcolor: obj.commonAppRedColor)
        
        titleHeader.text = obj.createString(Str: titleHeaderName)
    }
    
    func commonConstraint(object:UIView,mainView:UIView){
        
        mainView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        mainView.addSubview(object)
        object.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
       
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
    
    //MARK:- Btn Action
    //MARK:-
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
           self.navigationController?.popViewController(animated: false)
            
        }else if sender.tag == 2{
            
            type = "Distributor"
            
            if self.getSecDistViewModel.getDistributorArr.count > 0 {
                
                self.dropDownDataSource(dataSource: self.getSecDistViewModel.getDistributorArr, txtFld: txt_Distributor, anchorView: DistributorView)
                
            }
            
            
        }else if sender.tag == 3{
            
            type = "Retailer"
            
            if self.getSecDistViewModel.getRetailerArr.count > 0 {
                
                self.dropDownDataSource(dataSource: self.getSecDistViewModel.getRetailerArr, txtFld: txt_Retailer, anchorView: RetailerView)
                
            }
            
        }else if sender.tag == 4{
            
            type = ""
            
            self.txt_Month.text = ""
            self.DatePicker(sender: sender, txtFld: self.txt_Month)
            
        }else if sender.tag == 5{
            
            type = ""
            
            self.txt_Year.text = ""
            self.DatePicker(sender: sender, txtFld: self.txt_Year)
            
        }else if sender.tag == 7{
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let date = dateFormatter.string(from: datePicker.date)
                    
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
            
        }else if sender.tag == 9{
            
            validation()
            
        }else if sender.tag == 11 {
            
            self.apisecSalesChainCreateIOS()
        }
        
        
    }
    
    //MARK:- Validation
    //MARK:-
    
    func validation(){
        
        var message = String()
        
        if txt_Distributor.text!.isEmpty{
           
            message = "Please Select Distributor!"
            
        }else if txt_Retailer.text!.isEmpty{
            
             message = "Please Select Retailer!"
            
        }else if txt_Year.text!.isEmpty{
            
            message = "Please Select Year!"
            
        }else if txt_Month.text!.isEmpty{
            
            message = "Please Select Month!"
        }
        
        if message == ""{
            
            self.apisecSalesData()
            
        }else{
            
            alert(message: obj.createString(Str: message))
        }
        
    }
}
//MARK:- Configure tableView
//MARK:-

extension SecondaryAndDistributedVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
        
        titleHeaderName == "Daily Sales Register" ? self.tableView.register(SecondarySaleCell.self, forCellReuseIdentifier: "\(SecondarySaleCell.self)") :self.tableView.register(DistributedCell.self, forCellReuseIdentifier: "\(DistributedCell.self)")
        
           self.tableView.delegate = self
           self.tableView.dataSource = self
           self.tableView.alwaysBounceHorizontal = false
           self.tableView.alwaysBounceVertical = false
           self.tableView.rowHeight = UITableView.automaticDimension
           self.tableView.separatorColor = .clear
           self.tableView.bounces = false
           
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.getSecDistViewModel.noOfRowInScetion()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if titleHeaderName == "Daily Sales Register"{
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(SecondarySaleCell.self)", for: indexPath) as! SecondarySaleCell
        
            if indexPath.row == 0  {
            
            lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: "SNo")
            lblBackColor(lbl: cell.lbl_RetailerName, backColor: .clear, text: "Retailer Name")
            lblBackColor(lbl: cell.lbl_ItemCategory, backColor: .clear, text: "Item Category")
            lblBackColor(lbl: cell.lbl_Item, backColor: .clear, text: "Item")
            lblBackColor(lbl: cell.lbl_Status, backColor: .clear, text: "Status")
            cell.lbl_Value.setFontandColor(txtFld: cell.lbl_Value, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 12, text: "Value")
                cell.lbl_Value.text = "Value"
            cell.lbl_Value.backgroundColor = .clear
            setItemONButton(btn: cell.btn_Status, image: UIImage(), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
            cell.setColorOnBottomView(color1: .lightGray, color2: .clear)
               // cell.lbl_Value.isUserInteractionEnabled = false
            
            }else{
            
            lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: String(indexPath.row))
                lblBackColor(lbl: cell.lbl_RetailerName, backColor: .white, text: self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].retailerName)
                lblBackColor(lbl: cell.lbl_ItemCategory, backColor: .white, text: self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].itemCategory)
                lblBackColor(lbl: cell.lbl_Item, backColor: .white, text: self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].Item)
                lblBackColor(lbl: cell.lbl_Status, backColor: .white, text: self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].orderStatus == "0" ? "No" : "Yes" )
            cell.lbl_Value.setFontandColor(txtFld: cell.lbl_Value, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 12, text: "")
            cell.lbl_Value.text = self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].actualQuantity
            setItemONButton(btn: cell.btn_Status, image: #imageLiteral(resourceName: "down"), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
                cell.setColorOnBottomView(color1: .lightGray, color2: .lightGray)
            cell.lbl_Value.backgroundColor = .white
          //  cell.lbl_Value.isUserInteractionEnabled = true
                cell.btn_Status.tag = indexPath.row - 1
                cell.lbl_Value.tag = indexPath.row - 1
            cell.delegate = self
            self.getSecDistViewModel.getdistributedchaintModel[indexPath.row - 1].orderStatus == "0" ? (cell.lbl_Value.isUserInteractionEnabled = false) : (cell.lbl_Value.isUserInteractionEnabled = true)
            cell.delegate1 = self
        }
            if indexPath.row == self.getSecDistViewModel.noOfRowInScetion() - 1{
                
            cell.setColorOnBottomView(color1: .clear, color2: .clear)
                
            }
             
        return cell
        }
        else if titleHeaderName == "Distributed Secondary Sales"{
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(DistributedCell.self)", for: indexPath) as! DistributedCell
            
            if indexPath.row == 0{
                
                lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: "SNo")
               // lblBackColor(lbl: cell.lbl_RetailerName, backColor: .clear, text: "Retailer Name")
                cell.txt_Value.text = obj.createString(Str: "Value")
                cell.txt_Value.font = UIFont(name: obj.RegularFont, size: 14)
                cell.txt_Value.isUserInteractionEnabled = false
                cell.txt_Value.backgroundColor = .clear
                cell.txt_Value.textColor = obj.commonAppTextDrakColor
                setItemONButton(btn: cell.btn_RetailerName, image: UIImage(), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
                 
            }else{
                
                lblBackColor(lbl: cell.lbl_Date, backColor: .clear, text: String(indexPath.row))
              //  lblBackColor(lbl: cell.lbl_RetailerName, backColor: .white, text: "Prince Sinha")
                cell.txt_Value.text = obj.createString(Str: "10")
                cell.txt_Value.font = UIFont(name: obj.RegularFont, size: 14)
                cell.txt_Value.isUserInteractionEnabled = true
                cell.txt_Value.backgroundColor = .white
                cell.txt_Value.textColor = obj.commonAppTextDrakColor
                setItemONButton(btn: cell.btn_RetailerName, image: #imageLiteral(resourceName: "down"), text: "", textColor: UIColor.clear, backcolor: UIColor.clear)
                 
            }
             return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(btn_SubmitReport)
        
        btn_SubmitReport.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 65, paddingBottom: 25, paddingRight: 25)
        btn_SubmitReport.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)).isActive = true
        btn_SubmitReport.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        btn_SubmitReport.tag = 11
        btn_SubmitReport.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return view
        
    }
    
    func lblBackColor(lbl:UILabel,backColor:UIColor,text:String){
        lbl.textAlignment = .center
        lbl.backgroundColor = backColor
        lblFontColor(lbl: lbl, text: text)
    }
}
