//
//  MyAccountViewController.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController{
    
    //MARK: Outlets 
    
    @IBOutlet var name_textField: SkyFloatingLabelTextField!
    
    @IBOutlet var email_textField: SkyFloatingLabelTextField!
    
    @IBOutlet var phone_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password_textfield: SkyFloatingLabelTextField!
    
    @IBOutlet weak var order_historyview: UIView!
    
    @IBOutlet weak var viewAll_button: UIButton!
    
    @IBOutlet weak var viewAll_sampleBtn: UIButton!
    
    @IBOutlet var logOut_button: UIButton!
    
    @IBOutlet weak var merchant_button: UIButton!
    
    @IBOutlet var profilePic_ImageView: UIImageView!
    
    @IBOutlet weak var userType_label: UILabel!
    
    @IBOutlet weak var parentUserId_label: UILabel!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    // @IBOutlet weak var orderHistory_TableView: UITableView!
    
    //MARK: Variable
    
    let conn = webservices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewAll_button.layer.cornerRadius = self.viewAll_button.frame.size.height/2
        
        viewAll_button.layer.masksToBounds = true
        
        viewAll_sampleBtn.layer.cornerRadius = self.viewAll_sampleBtn.frame.size.height/2
        
        viewAll_sampleBtn.layer.masksToBounds = true
        
        logOut_button.layer.cornerRadius = self.logOut_button.frame.size.height/2
        
        logOut_button.layer.masksToBounds = true
        
        merchant_button.layer.cornerRadius = self.logOut_button.frame.size.height/2
        
        merchant_button.layer.masksToBounds = true
        
        self.order_historyview.shadow(Outlet: self.order_historyview)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  UserDefaults.standard.bool(forKey: "Login_Status"){
            
            self.fetchData()
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.backItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "My Account"
        
        self.setNavBar()
        
        profilePic_ImageView.layer.masksToBounds = true
        
        profilePic_ImageView.layer.cornerRadius = profilePic_ImageView.frame.height/2
        
        profilePic_ImageView.layer.borderWidth = 2
        
        profilePic_ImageView.layer.borderColor = UIColor(red: 14/255, green:  28/255, blue:  121/255, alpha: 1.0).cgColor
        
        //        self.tabBarController?.tabBar.isHidden = true
        
        //        if tabBarController?.selectedIndex == 3 {
        //
        //            if  UserDefaults.standard.bool(forKey: "Login_Status"){
        //
        
        //
        //            }else{
        //
        //                self.tabBarFunction()
        //
        //            }
        //
        //        }else{}
        
    }
    
    //MARK: Functions
    
    func tabBarFunction(){
        
        self.navigationController?.navigationBar.isHidden = true
        
        let alert = UIAlertController(title: "AIPL ABRO", message: "Login To see first", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func setNavBar() {
        
        
        let btn1 = UIButton(type: .custom)
        
        btn1.setImage(#imageLiteral(resourceName: "whitepen 25x25"), for: .normal)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn1.addTarget(self, action: #selector(self.btn1Action), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "settingIcon"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.addTarget(self, action: #selector(self.btn2Action), for: .touchUpInside)
        
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [ item2 , item1 ]
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn1Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditAccountViewController") as! EditAccountViewController
        
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn2Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn3Action(){
        
        if tabBarController?.selectedIndex == 4 {
            
            if  UserDefaults.standard.bool(forKey: "Login_Status"){
                
                self.tabBarController?.selectedIndex = 0
                
            }else{
                
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            
        }else{
            
            
        }
        
    }
    
    
    //MARK: Alert Functions
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertWithHandler(message : String , block:  @escaping ()->Void ){
        
        let alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action : UIAlertAction) in
            
            block()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func fetchData(){
        
        print("Hello")
        
        let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
        
        if userData != [:] {
            
            self.name_textField.text =     userData.value(forKey: "Name") as? String
            
            self.email_textField.text =  userData.value(forKey: "EMail") as? String
            
            self.phone_textField.text =  userData.value(forKey: "PhoneNo") as? String
            
            self.userType_label.text =  userData.value(forKey: "UserType") as? String
            
            self.codeLabel.text =     userData.value(forKey: "Code") as? String
            
            print("login")
            
        }else{
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).count != 0 {
                
                if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String == "<null>" ||  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") is NSNull{
                    
                    self.profilePic_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    ///var/www/html/aipl_api/images/
                    
                    self.profilePic_ImageView.setImageWith(NSURL(string: userImage_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                    
                    //                if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 1{
                    //
                    //                    self.profilePic_ImageView.setImageWith(NSURL(string: DISTRIBUTOR_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    //
                    //                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 2{
                    //
                    //                    self.profilePic_ImageView.setImageWith(NSURL(string: DIRECT_DEALER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    //
                    //                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 3{
                    //
                    //                    self.profilePic_ImageView.setImageWith(NSURL(string: RETAILER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    //
                    //                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 4{
                    //
                    //                    self.profilePic_ImageView.setImageWith(NSURL(string: END_USER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    //                }else{
                    //
                    //
                    //                }
                    
                }
                
                if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String != nil{
                    
                    self.name_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String
                    
                }
                
                if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String != nil{
                    
                    self.email_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String
                    
                }
                
                if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "phone") as? String != nil{
                    
                    self.phone_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "phone") as? String
                    
                }
                
                if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "name") as? String) != nil{
                    
                    self.userType_label.text =  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)?.value(forKey: "name") as? String)
                    
                }
                
                if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "id") as? Int) != nil{
                    
                    if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "id") as? Int) == 4{
                        
                        parentUserId_label.isHidden = true
                        
                        codeLabel.isHidden = true
                        
                    }else{
                        
                        if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "business_id") as? String != nil{
                            
                            parentUserId_label.isHidden = false
                            
                            codeLabel.isHidden = false
                            
                            self.parentUserId_label.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "business_id") as? String
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    //MARK: Action
    
    @IBAction func viewAll_button(_ sender: UIButton) {
        
        sender.tag = 0
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        
        vc.tag = sender.tag
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func viewAll_sampleBtnTap(_ sender: UIButton) {
        
        sender.tag = 1
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        
        vc.tag = sender.tag
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOut_Button(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "Login_Status")
        
        UserDefaults.standard.removeObject(forKey: "LoginData")
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        singleton.sharedInstance.cartCount = 0
        
        singleton.sharedInstance.notificationCount = 0
        
        self.delete_device()
        
        // let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
        
        //   vc.selectedIndex = 0
        
        //self.navigationController?.pushViewController(vc, animated: false)
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    @IBAction func btn_Merchant(_ sender: UIButton) {
        
        
        let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let vc = stroryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func delete_device(){
        
        var parameters: [NSString:NSObject] = [:]
        
        let unique_id = UIDevice.current.identifierForVendor!.uuidString
        
        print(unique_id)
        
        
        parameters = ["device_id" : unique_id as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("delete_device_info", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject]){receivedData in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as? Bool == true  {
                    
                    // self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                }else{
                    
                    //   self.alert(message: "Something went wrong")
                    
                }
                
            }
            else {
                
                self.alert(message: (receivedData.value(forKey: "Error") as? String)!)
                
            }
            
            
        }
        
    }
    
}
