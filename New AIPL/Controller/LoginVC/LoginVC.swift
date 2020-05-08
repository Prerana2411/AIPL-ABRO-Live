//
//  ViewController.swift
//  AIPL
//
//  Created by apple on 06/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation
class LoginVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var backgroundView:UIView!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var lbl_Password: UILabel!
    @IBOutlet weak var txt_UserName: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var btn_Login: UIButton!
    
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
    
   
    var validation = Validation()
    var conn = WebService()
    let obj = CommonClass.sharedInstance
    let alert = UIAlertController()
    
   
    //MARK:- LifeCycle Method
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
        
        if userData != [:] {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(vc, animated: false)
            
            print("login")
            
        }
        
       self.navigationController?.isNavigationBarHidden = true
      //  self.navigationController?.navigationBar.
                for family in UIFont.familyNames.sorted() {
                    let names = UIFont.fontNames(forFamilyName: family)
                    print("Family: \(family) Font names: \(names)")
                }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUpNavi()
    }
    
  //MARK:- Method to set Navi On Screen
  //MARK:-
  internal func setUpNavi(){
        
    backgroundView.backgroundColor = UIColor.white
          backgroundView.addSubview(navView)
          navView.translatesAutoresizingMaskIntoConstraints = false
          navView.withoutBottomAnchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
    _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
        setString()
    }

  //MARK:- String on UI Elements
  //MARK:-
    internal func setString(){
        
        let obj = CommonClass.sharedInstance
        
        self.titleHeader.text = obj.createString(Str: "Login")
        self.titleHeader.font = UIFont(name: obj.BoldFont, size: obj.BoldfontSize)
        self.lbl_UserName.text = obj.createString(Str: "UserName/Code")
        self.lbl_UserName.font = UIFont(name: obj.MediumFont, size: 14)
        self.lbl_UserName.textColor = obj.commonAppRedColor
        self.lbl_Password.text = obj.createString(Str: "Password")
        self.lbl_Password.font = UIFont(name: obj.MediumFont, size: 14)
        self.lbl_Password.textColor = obj.commonAppRedColor
        self.txt_UserName.placeholder = obj.createString(Str: "Enter Your UserName/Code")
        self.txt_UserName.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        self.txt_UserName.textColor = obj.commonAppTextDrakColor
        self.txt_Password.placeholder = obj.createString(Str: "Enter Your Password")
        self.txt_Password.textColor = obj.commonAppTextDrakColor
        self.txt_Password.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        self.btn_Login.setTitle(obj.createString(Str: "Login"), for: .normal)
        self.btn_Login.backgroundColor = obj.commonAppRedColor
        self.btn_Login.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        self.btn_Login.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    //MARK:- Bnt Action
    //MARK:-
    
    @IBAction func tap_Action(_ sender: UIButton) {
        
      //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        
    //    self.navigationController?.pushViewController(vc, animated: false)
        
        CheckValidation()
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popToRootViewController(animated: false)
            
        }
        
    }
}


