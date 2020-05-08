//
//  NewPlannerVC.swift
//  AIPL
//
//  Created by apple on 08/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import iOSDropDown

struct Planner: Codable {
    
    var compareDate : String?
    var salesPersonCode : String?
    var salePersonName : String?
    var plannerDate : String?
    var plannerDays : String?
    var city : String?
    var remarks : String?
    var salePersonHQ : String?
    var edited : String?
    var nightHalt : String?
    var beat : String?
}

struct EditedPlanner:Codable {
    
    var salesPersonCode : String?
    var salePersonName : String?
    var plannerDate : String?
    var plannerDays : String?
    var city : String?
    var remarks : String?
    var salePersonHQ : String?
    var edited : String?
    var nightHalt : String?
    var beat : String?
    var plannerNo : String?
    var lineNo : String?
    
}

class NewPlannerVC: UIViewController {

    
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
        return lbl
    }()
    
    let lbl_MYP : UILabel = {
        
        let lbl = UILabel()
        lbl.text = CommonClass.sharedInstance.createString(Str: "Month/Year Planner :")
        lbl.font = UIFont.init(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        lbl.textColor = CommonClass.sharedInstance.commonAppTextDrakColor
        return lbl
    }()
    
    lazy var tableView : UITableView = {
        
        var table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.isHidden = true
        return table
        
    }()
    
    lazy var lbl_PlannerNo = UILabel()
    lazy var lbl_SalesPerson = UILabel()
    lazy var lbl_SP_Name = UILabel()
    lazy var lbl_SP_Number = UILabel()
    lazy var lbl_SP_Email = UILabel()
    lazy var lbl_Month = UILabel()
    lazy var lbl_Year = UILabel()
    
    lazy var StackForIUpperLbls : UIStackView = {
        
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 3
        return stack
        
    }()
    
    
    lazy var view_Month : UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        return view
        
    }()
    
    lazy var txtFldMonth : UITextField = {
        
        let txt = UITextField()
        
        return txt
    }()
    lazy var btnMonth : UIButton = {
        
        let btn = UIButton()
        btn.contentHorizontalAlignment = .right
        btn.tag = 2
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    lazy var view_year : UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        return view
        
    }()
    
    lazy var txtFldyear : UITextField = {
        
        let txt = UITextField()
        
        return txt
    }()
    lazy var btnyear : UIButton = {
        
        let btn = UIButton()
        btn.contentHorizontalAlignment = .right
        btn.tag = 3
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnshow : UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "Show"), for: .normal)
        btn.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        btn.tag = 4
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var baseview:UIView = {
        
        let view =  UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-350, width: self.view.frame.size.width, height: 350))
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        view.tag = 668
        
        return view
        
    }()
    var tableHide = true
    var plannerType = String()
    let obj = CommonClass.sharedInstance
    var getPlannerViewModel = PlannerViewModel()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    var arr = NSMutableArray()
    var arrStrct = [Planner]()
    var arrStrctEdited = [EditedPlanner]()
    var fromDate = String()
    var ToDate = String()
    var getCityBeatFromViewModel = StartDayViewModel()
    
 
    
      //MARK:- LifeCycle Method
      //MARK:-
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
                 
          
      }

      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
        
        setActionOnBtn(btn:self.leftBtn,tag:1)
        
         self.setUpNavi()
      }
      
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
          
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
            
        view.addSubview(view_Month)
        view.addSubview(view_year)
        view.addSubview(btnshow)
        view_Month.translatesAutoresizingMaskIntoConstraints = false
        view_year.translatesAutoresizingMaskIntoConstraints = false
        btnshow.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([view_Month.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 25),
                                     view_Month.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
                                     view_Month.widthAnchor.constraint(equalToConstant: view.frame.size.width/3.5),
                                     view_Month.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        NSLayoutConstraint.activate([view_year.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 25),
                                     view_year.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                                     view_year.widthAnchor.constraint(equalToConstant: view.frame.size.width/3.5),
                                     view_year.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        NSLayoutConstraint.activate([btnshow.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 25),
        btnshow.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
        btnshow.widthAnchor.constraint(equalToConstant: view.frame.size.width/3.5),
        btnshow.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        
        commonTopConstraint(mainView: view_Month, item: txtFldMonth)
        commonTopConstraint(mainView: view_Month, item: btnMonth)
       
        commonTopConstraint(mainView: view_year, item: txtFldyear)
        commonTopConstraint(mainView: view_year, item: btnyear)
        
        if plannerType == "edit planner"{
           
            view.addSubview(StackForIUpperLbls)
            StackForIUpperLbls.withoutBottomAnchorHeightGreater(top: view_year.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10, height: 150)
            
            StackForIUpperLbls.addArrangedSubview(lbl_PlannerNo)
            StackForIUpperLbls.addArrangedSubview(lbl_SalesPerson)
            StackForIUpperLbls.addArrangedSubview(lbl_SP_Name)
            StackForIUpperLbls.addArrangedSubview(lbl_SP_Number)
            StackForIUpperLbls.addArrangedSubview(lbl_SP_Email)
            StackForIUpperLbls.addArrangedSubview(lbl_Month)
            StackForIUpperLbls.addArrangedSubview(lbl_Year)
            
           
            view.addSubview(tableView)
            tableView.scrollAnchor(top: StackForIUpperLbls.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)

            
        }else{
            
            view.addSubview(tableView)
            tableView.scrollAnchor(top: view_year.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
     
            
        }
        
        self.view.bringSubviewToFront(baseview)
        StackForIUpperLbls.isHidden = false
        setString()
      }

    
    func commonTopConstraint(mainView:UIView,item:UIView){
        
        mainView.addSubview(item)
        
        item.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12)
        
    }
    
    internal func setString(){
       
        getPlannerViewModel.setFontandColor(lbl: titleHeader, color: UIColor.white, font: obj.BoldFont, size: obj.BoldfontSize, text: "Planner Card", textAliment: .left)
        getPlannerViewModel.setColorFontImage(txtFld:txtFldMonth,btn:btnMonth,color:obj.commonAppTextDrakColor, image: #imageLiteral(resourceName: "calendar"), text: "Month")
        getPlannerViewModel.setColorFontImage(txtFld:txtFldyear,btn:btnyear,color:obj.commonAppTextDrakColor, image: #imageLiteral(resourceName: "calendar"), text: "Year")
        
    }
    
    internal func setDataOnScreen(){
        
        StackForIUpperLbls.isHidden = false
        
             getPlannerViewModel.setFontandColor(lbl: lbl_PlannerNo, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Planner No : \(getPlannerViewModel.getDataArrForEditList[0].PlannerNo ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_SalesPerson, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Sales Person : \(getPlannerViewModel.getDataArrForEditList[0].SalesPersonCode ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_SP_Name, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "SP Name RSM : \(getPlannerViewModel.getDataArrForEditList[0].SalesPersonName ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_SP_Number, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "SP Number : \(getPlannerViewModel.getDataArrForEditList[0].SalePersonMobile ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_SP_Email, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "SP Email : \(getPlannerViewModel.getDataArrForEditList[0].SalePersonEMail ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_Month, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Month : \(getPlannerViewModel.getDataArrForEditList[0].Month ?? "")", textAliment: .left)
              getPlannerViewModel.setFontandColor(lbl: lbl_Year, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Year : \(getPlannerViewModel.getDataArrForEditList[0].Year ?? "")", textAliment: .left)
    }
    
  
    
    func setActionOnBtn(btn:UIButton,tag:Int){
        
                btn.tag = tag
                btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
    }
    
    //MARK:- Validation
    //MARK:-
    
    func validation(){
        
        var message = ""
        
        if self.txtFldMonth.text!.isEmpty{
            
            message = "Please select Month"
            
        }else if self.txtFldyear.text!.isEmpty{
            
            message = "Please select Year"
            
        }
        
        if message == ""{
            
            self.apiAddOrEditPlanner()
            
        }else{
            
            alert(message: obj.createString(Str: message))
        }
    }
    
    //MARK:- Btn Action
    //MARK:-
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1 {
            
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 2 || sender.tag == 3 {
            txtFldMonth.text = ""
            DatePicker(sender: sender, txtFld: txtFldMonth)
            
        }else if sender.tag == 3{
             txtFldyear.text = ""
           DatePicker(sender: sender, txtFld: txtFldyear)
        }else if sender.tag == 4 {
            
            if txtFldMonth.text!.isEmpty || txtFldyear.text!.isEmpty{
                
                alert(message: obj.createString(Str: "Please select month and year!!"))
                
            }else{
                
                self.apishowPlanner()
            }
             
        }else if sender.tag == 7{
            
            if let baseViewTag = self.view.viewWithTag(668)
            {
                if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let date = dateFormatter.string(from: datePicker.date)
                    
                    self.txtFldyear.text = String(date.prefix(4))
                    let start = String.Index(utf16Offset: 5, in: date)
                    let end = String.Index(utf16Offset: 6, in: date)
                    let substring = String(date[start...end])
                    self.txtFldMonth.text = substring
                    //self.txtFldMonth.text = "4"
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
        }
        
    }
}
//MARK:- Configure tableView
//MARK:-

extension NewPlannerVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
           
           self.tableView.register(NewPlannerCell.self, forCellReuseIdentifier: "\(NewPlannerCell.self)")
           self.tableView.delegate = self
           self.tableView.dataSource = self
           self.tableView.isHidden = false
           self.tableView.alwaysBounceHorizontal = false
           self.tableView.alwaysBounceVertical = false
           self.tableView.rowHeight = UITableView.automaticDimension
           self.tableView.bounces = false
           self.tableView.isScrollEnabled = true
           self.getPlannerViewModel.delegate = self
           self.apiCity()
       
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return plannerType == "add planner" ? getPlannerViewModel.getNumberOfRowInSection(count: getPlannerViewModel.getDataArr.count):getPlannerViewModel.getNumberOfRowInSection(count: getPlannerViewModel.getEditArr.count)
        //return getPlannerViewModel.getNumberOfRowInSection()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(NewPlannerCell.self)", for: indexPath) as! NewPlannerCell
       
        cell.getCityBeatFromViewModel = self.getCityBeatFromViewModel
        
        if indexPath.row == 0{
            
            
            getPlannerViewModel.setFontandColor(lbl: cell.lbl_Beat, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Beat", textAliment: .left)
            getPlannerViewModel.setFontandColor(lbl: cell.lbl_City, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "City", textAliment: .left)
            getPlannerViewModel.setFontandColor(lbl: cell.lbl_Date, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: "Date", textAliment: .center)
            getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.lbl_Date)
            getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.view_Beat)
            getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.view_City)
            getPlannerViewModel.commonMethoToSetImage(btn: cell.btn_City, image: UIImage(), hidden: true)
            getPlannerViewModel.commonMethoToSetImage(btn: cell.btn_Beat, image: UIImage(), hidden: true)
           
            
        }else{
            
           
            getPlannerViewModel.setFontandColor(lbl: cell.lbl_Beat, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: self.plannerType == "add planner" ? getPlannerViewModel.getBeatForEachRow(index: indexPath.row) : getPlannerViewModel.getEditBeatForEachRow(index: indexPath.row) , textAliment: .left)
            
            getPlannerViewModel.setFontandColor(lbl: cell.lbl_City, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: self.plannerType == "add planner" ? getPlannerViewModel.getCityForEachRow(index: indexPath.row) : getPlannerViewModel.getEditCityForEachRow(index: indexPath.row) , textAliment: .left)
            
           getPlannerViewModel.setFontandColor(lbl: cell.lbl_Date, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13, text: self.plannerType == "add planner" ? getPlannerViewModel.getDateForEachRow(index: indexPath.row) : getPlannerViewModel.getEditDateForEachRow(index: indexPath.row), textAliment: .center)
            self.plannerType == "add planner" ? (getPlannerViewModel.getDayForEachRow(index: indexPath.row) == "Sunday" ? (getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppRedColor,view:cell.lbl_Date)) : (getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.lbl_Date)) ):(getPlannerViewModel.getEditDayForEachRow(index: indexPath.row) == "Sunday" ? (getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppRedColor,view:cell.lbl_Date)) : (getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.lbl_Date)) )
            getPlannerViewModel.commonMethodforBackColor(color:obj.commonAppLightblueColor,view:cell.lbl_Date)
            getPlannerViewModel.commonMethodforBackColor(color:UIColor.white,view:cell.view_Beat)
            getPlannerViewModel.commonMethodforBackColor(color:UIColor.white,view:cell.view_City)
            getPlannerViewModel.commonMethoToSetImage(btn: cell.btn_City, image: #imageLiteral(resourceName: "down"), hidden: false)
            getPlannerViewModel.commonMethoToSetImage(btn: cell.btn_Beat, image: #imageLiteral(resourceName: "down"), hidden: false)
            cell.btn_City.tag = indexPath.row - 1
            cell.btn_Beat.tag = indexPath.row - 1
            cell.delegate = self
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        let SaveBtn = UIButton()
        view.addSubview(SaveBtn)
        SaveBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([SaveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     SaveBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     SaveBtn.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     SaveBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)])
        SaveBtn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        SaveBtn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        SaveBtn.setTitle(CommonClass.sharedInstance.createString(Str: "Save"), for: .normal)
        SaveBtn.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        SaveBtn.tag = 9
        SaveBtn.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        return view
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(lbl_MYP)
        lbl_MYP.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_MYP.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     lbl_MYP.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)])
        return view
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
        
    }
    
}
extension NewPlannerVC:NewPlannerCelldelegate,ReloadTableView{
    
    
    func newValueForCity(text: String, index: Int) {
        
        self.plannerType == "add planner" ? (self.getPlannerViewModel.getDataArr[index].City = text) : (self.getPlannerViewModel.getEditArr[index].City = text)
        
    }
    
    func newValueForBeat(text: String, index: Int) {
        
        self.plannerType == "add planner" ? (self.getPlannerViewModel.getDataArr[index].beat = text) : (self.getPlannerViewModel.getEditArr[index].beat = text)
     }
    
    func newValueForNightHalt(text: String, index: Int) {
        
        self.plannerType == "add planner" ? (self.getPlannerViewModel.getDataArr[index].nightHalt = text) : (self.getPlannerViewModel.getEditArr[index].nightHalt = text)
        
        
    }
  
    func reloadTable() {
        
        self.tableView.reloadData()
        
    }
    
    
   
}

extension String{
    static func toJSonString(data : Any) -> String {

               var jsonString = "";

               do {
                   var dataDict : [String : Any] = [:];

                   dataDict["type"] = "Step"
                   dataDict["data"] = ["2015-08-02": 8574];
                   let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                   jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

               } catch {
                   print(error.localizedDescription)
               }

               return jsonString;
       }
}
