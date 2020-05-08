//
//  PostedPlannerVC.swift
//  AIPL
//
//  Created by apple on 09/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import DropDown
class PostedPlannerVC: UIViewController,NewRetailerVCDelegate {
    
    
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
    lazy var btn_Submit : UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "Show"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        return btn
        
    }()
    lazy var btn_AddCategory : UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "Add Item Category"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        return btn
        
    }()
    
    lazy var lbl_Remark = UILabel()
    lazy var View_Remark :UIView = {
        
        let view = UIView()
        return view
        
    }()
    lazy var txtView_Remark :UITextView = {
        
        let txt = UITextView()
        return txt
        
    }()
    lazy var baseview:UIView = {
           
           let view =  UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-350, width: self.view.frame.size.width, height: 350))
           view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
           view.tag = 668
           
           return view
           
    }()
    lazy var btn_save = UIButton()
    
    lazy var btn_SubmitReport = UIButton()
    
    lazy var Travel_View = UIView()
    lazy var Travel_lbl = UITextField()
    lazy var Travel_lbl_header = UILabel()
    lazy var Travel_btn  = UIButton()
    
    lazy var Beat_View = UIView()
    lazy var Beat_lbl = UITextField()
    lazy var Beat_lbl_header = UILabel()
    lazy var Beat_btn  = UIButton()
    
    lazy var stack1 : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    
    lazy var Retailer_View = UIView()
    lazy var Retailer_lbl = UITextField()
    lazy var Retailer_lbl_header = UILabel()
    lazy var Retailer_btn  = UIButton()
    
    lazy var Order_View = UIView()
    lazy var Order_lbl = UITextField()
    lazy var Order_lbl_header = UILabel()
    lazy var Order_btn  = UIButton()
    
    lazy var Tagged_View = UIView()
    lazy var Tagged_lbl = UITextField()
    lazy var Tagged_lbl_header = UILabel()
    lazy var Tagged_btn  = UIButton()
    
    lazy var stack2 : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    
    lazy var tableView : UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
        
    }()
    
    lazy var footerView = UIView()
    var tableItemArr = NSMutableArray()
    let obj = CommonClass.sharedInstance
    var dropDown = DropDown()
    var getCityBeatFromViewModel = StartDayViewModel()
    var getRetailerViewModel = RetailerViewModel()
    var getDailyRegisterSalesViewModel = DailyRegisterSalesViewModel()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    var Date = String()
    var searchArrRes = [String]()
    var searching:Bool = false
    var originalArr = [String]()
    var index = Int()
    var itemCodeIndex = Int()
    var isRetailerSelected = Bool()
    var taggedCustCode = String()
    var retailerCode = String()
    var taggedCustomerCode = String()
    var OrderNotRec_Reason = String()
    var OrderNotRec_Remarks = String()
    
    var itemArr: [DailyRegisterModel] = []{
       
        didSet{
            
            if (self.itemArr != oldValue){
                self.tableView.reloadData()
            }
            
        }
        willSet(newValue){
            
            self.itemArr = newValue
        }
    }
    
    //MARK:- LifeCycle Method
    //MARK:-
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
         searchAPI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        self.setUpNavi()
        
        configTable()
        
        setTagAndAction(btn: date_btn, tag: 3)
        setTagAndAction(btn: month_btn, tag: 4)
        setTagAndAction(btn: year_btn, tag: 5)
        setTagAndAction(btn: btn_Submit, tag: 6)
        setTagAndAction(btn: Travel_btn, tag: 7)
        setTagAndAction(btn: Beat_btn, tag: 8)
        setTagAndAction(btn: Retailer_btn, tag: 9)
        setTagAndAction(btn: Order_btn, tag: 10)
        setTagAndAction(btn: btn_save, tag: 11)
        setTagAndAction(btn: btn_SubmitReport, tag: 12)
        setTagAndAction(btn: Tagged_btn, tag: 16)
        // This method is used to set data on screen
        setString()
        initialsetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
       
    }
    
    internal func initialsetup() {
        
        Travel_lbl.delegate = self
        Travel_btn.isHidden = true
        
        
        
    }
    
    func setTagAndAction(btn:UIButton,tag:Int){
        
        btn.tag = tag
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
    }
    
    //MARK:- DatePicker
    //MARK:-
    
    func DatePicker(sender:UIButton,txtFld:UITextField){
        
        self.view.addSubview(baseview)
        self.view.endEditing(true)
        
        let doneButton : UIButton = {
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            btn.tag = 13
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            return btn
        }()
        
        let cancelButton : UIButton = {
            
            let btn = UIButton(frame: CGRect(x: baseview.frame.size.width-100, y: 0, width: 100, height: 50))
            btn.tag = 14
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            return btn
        }()
        view.addSubview(baseview)
        _ = baseview.openDatePicker(sender: sender.tag, baseview: baseview, doneButton: doneButton, cancelButton: cancelButton, txtDate: txtFld)
        
        
    }
    
    //MARK- Validation
    //MARK:-
    
    func validation(){
        
        var message = ""
        
        if date_lbl.text!.isEmpty{
            
            message = "Please Select Date!"
            
        }else if month_lbl.text!.isEmpty{
            
            message = "Please Select Month!"
            
        }else if year_lbl.text!.isEmpty{
            
            message = "Please Select Year!"
        }
        
        if message != ""{
            
            alert(message: message)
            
        }else{
            
           apicheckDayRegister()
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
    
    func index(index: Int, text: String) {
        
        if text == "Yes"{
            
            self.btn_AddCategory.isHidden = false
            apiitemCategoryList() 
        }else if text == "No"{
            
             self.btn_AddCategory.isHidden = true
             self.itemArr.removeAll()
            
             let vc = NoOrderPopupVC()
             vc.modalPresentationStyle = .overFullScreen
             vc.nav = self.navigationController!
             vc.delegate = self
             self.navigationController?.present(vc, animated: false, completion: nil)
             
        }
        if isRetailerSelected == true{
            
            print(getRetailerViewModel.taggedCustomerCodeArr[index])
            taggedCustCode = getRetailerViewModel.taggedCustomerCodeArr[index]
            retailerCode = getRetailerViewModel.retailerNumber[index]
            
        }
        self.index = index
      
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
}

extension PostedPlannerVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
    if let char = string.cString(using: String.Encoding.utf8) {
        
        let searchText  = textField.text! + string
        print("SearchText!!!!=<",searchText)
        
        let filerArr = self.originalArr.filter({$0.lowercased().contains(searchText.lowercased())})
        
        if filerArr.count > 0 {
            self.dropDownDataSource(dataSource: filerArr, txtFld: self.Travel_lbl, anchorView: self.Travel_View)
        }else{
            
            dropDown.hide()
        }
        
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.Travel_lbl, anchorView: self.Travel_View)
        }
    }
    
        return true
    }
   
    
    func searchAPI(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
            Indicator.shared.showProgressView(view)
            getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                
                self.originalArr = (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? [])
            }
            
        }else{
            
          alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
            
        }
    }
}
