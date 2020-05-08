//
//  RetailerVC.swift
//  AIPL ABRO
//
//  Created by CST on 15/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown

class RetailerVC: UIViewController {

    
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
    
    lazy var btn_Retailer = UIButton()
    
    lazy var HqView = UIView()
    lazy var txt_HQ = UITextField()
    lazy var RetailerView = UIView()
    lazy var lbl_Retailer = UITextField()
    lazy var dropBtnForRetailer  = UIButton()
    var dropDown = DropDown()
    lazy var btn_Edit = UIButton()
    var titleHeaderName = String()
    let obj = CommonClass.sharedInstance
    var getRetailerViewModel = RetailerViewModel()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    var index = Int()
    //MARK:- LifeCycle Method
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
         setUpNavi()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
          
        view.backgroundColor = obj.commonAppbackgroundColor
            view.addSubview(navView)
            navView.translatesAutoresizingMaskIntoConstraints = false
            navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
      _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
         
        view.addSubview(btn_Retailer)
        btn_Retailer.backgroundColor = .red
        btn_Retailer.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 30, paddingRight: 30, height: CGFloat(obj.commonHeight))
        btn_Retailer.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        view.addSubview(HqView)
        view.addSubview(RetailerView)
        
        HqView.withoutBottomAnchor(top: btn_Retailer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10, height: CGFloat(obj.commonHeight))
        RetailerView.withoutBottomAnchor(top: HqView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: CGFloat(obj.commonHeight))
       
        getRetailerViewModel.setCommonConstraint(view: HqView, item: txt_HQ)
        getRetailerViewModel.setCommonConstraint(view: RetailerView, item: lbl_Retailer)
        getRetailerViewModel.setCommonConstraint(view: RetailerView, item: dropBtnForRetailer)
        
        view.addSubview(btn_Edit)
        btn_Edit.translatesAutoresizingMaskIntoConstraints = false
        btn_Edit.backgroundColor = .red
        NSLayoutConstraint.activate([btn_Edit.topAnchor.constraint(equalTo: RetailerView.bottomAnchor, constant: 20),
                                     btn_Edit.rightAnchor.constraint(equalTo: RetailerView.rightAnchor, constant: 0),
                                     btn_Edit.widthAnchor.constraint(equalTo: RetailerView.widthAnchor, multiplier: 0.3),
                                     btn_Edit.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight))])
        
        self.setDataOnScreen()
        
      }
    
    
    //MARK:- Custom Method To SetDataOnScreen
    
    private func setDataOnScreen(){
        
       
        titleHeader.text = obj.createString(Str: titleHeaderName)
        titleHeader.textColor = .white
        titleHeader.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        btn_Retailer.tag = 2
        btn_Retailer.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        btn_Edit.tag = 3
        btn_Edit.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        dropBtnForRetailer.tag = 4
        dropBtnForRetailer.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        getRetailerViewModel.setDataOnButton(btn: btn_Retailer, text: "  Add \(titleHeaderName)", font: obj.MediumFont, size: obj.semiBoldfontSize, textcolor: .white, image: UIImage(named: "add")!, backGroundColor: obj.commonAppRedColor, aliment: .center)
        getRetailerViewModel.setDataOnButton(btn: btn_Edit, text: "Edit", font: obj.RegularFont, size: obj.semiBoldfontSize, textcolor: obj.commonAppRedColor, image: UIImage(), backGroundColor: .white, aliment: .center)
        btn_Edit.borderColor = obj.commonAppRedColor
        btn_Edit.borderWidth = 0.5
        
        getRetailerViewModel.setFontandColor(txtFld: txt_HQ, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "HQ")
        txt_HQ.text = userData.value(forKey: "HQ") as? String ?? ""
        getRetailerViewModel.setFontandColor(txtFld: lbl_Retailer, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        dropBtnForRetailer.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        dropBtnForRetailer.contentHorizontalAlignment = .right
       
    }
       
    
    //MARK:- Btn Action
    //MARK:-
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 2{
            
            let vc = NewRetailerVC()
            vc.titleHeaderName = self.titleHeaderName
            vc.edit_Add_Type = "Add"
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 3{
            
            let vc = NewRetailerVC()
            vc.titleHeaderName = self.titleHeaderName
            vc.edit_Add_Type = "Edit"
            vc.retailerNumber = getRetailerViewModel.retailerNumber[getRetailerViewModel.text]
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if sender.tag == 4{
            
            if getRetailerViewModel.retailerName.count > 0 {
                
                dropMethod()
                
            }else{
                
                apiretailerListHQwise()
            }
             
        }
    }
}

//MARK:- Api retailerListHQwise
//MARK:-

extension RetailerVC{
    
    func apiretailerListHQwise(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["salesPersonHq":userData.value(forKey: "HQ") ?? "","salesPersonZone":userData.value(forKey: "Zone") ?? ""] as [String:Any]
            
            Indicator.shared.showProgressView(view)
            
            getRetailerViewModel.getReatilerListDataFromApiHandler(url: "retailerListHQwise", passDict: passDict, success: { (_, message) in
                
                print(message)
                
                if message == "Data found"{
                    
                    self.dropMethod()
                    
                }
                
            }) { (message) in
                
                self.alert(message: CommonClass.sharedInstance.createString(Str: message))
            }
            
        }else{
            
            alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    
    func dropMethod(){
        
        if self.dropDown.dataSource.count > 0{
            
            self.dropDown.dataSource.removeAll()
        }
        
        
        self.getRetailerViewModel.dropDownDelegate(textField: self.lbl_Retailer, view: self.RetailerView, dropDown: self.dropDown)
        self.dropDown.dataSource = self.getRetailerViewModel.retailerName
        self.dropDown.show()
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
