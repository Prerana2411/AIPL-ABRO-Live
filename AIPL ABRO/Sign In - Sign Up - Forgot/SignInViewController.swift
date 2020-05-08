//
//  SignInViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    //MARK: Outlets
    
    @IBOutlet weak var icon_imageView: UIImageView!
    
    @IBOutlet weak var email_TextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password_TextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signIn_button: UIButton!
    
    @IBOutlet weak var signUp_View: UIView!
    
    @IBOutlet weak var signUp_button: UIButton!
    
    
    //MARK: WEB service Variables
    
    var validation = Validation()
    
    var conn = webservices()
    
  //  var UserData : NSDictionary = [:]
    
    //MARK: Functions
    
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
    
    func emptyText(txtFld: UITextField) {
        
        txtFld.text! = ""
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Arcon", size: 20)!]
//
//
//        var navigationBarAppearace = UINavigationBar.appearance()
//
//        navigationBarAppearace.tintColor = UIColor.black
//
//        navigationBarAppearace.barTintColor = UIColor.white
        
//      UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
       
        signIn_button.layer.cornerRadius =  signIn_button.frame.height/2
        
        signIn_button.layer.masksToBounds = true
        
        signUp_button.layer.cornerRadius = signUp_button.frame.height/2
        
        signUp_button.layer.masksToBounds = true
        
        signUp_View.layer.cornerRadius = signUp_View.frame.height/2
        
        signUp_View.layer.masksToBounds = true
        
        signUp_View.layer.borderWidth = 2
        
        signUp_View.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor

//        email_TextField.selectedTitle = ""
//        
//        password_TextField.selectedTitle = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Sign In"
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.setNavBar()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if tabBarController?.selectedIndex == 4 {
            
            if  UserDefaults.standard.bool(forKey: "Login_Status"){
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
                
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else{
                
                
                
            }
            
        }else{}
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func setNavBar(){
        
        let btn1 = UIButton(type: .custom)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn1.tag = 0
        
        let item1 = UIBarButtonItem(customView: btn1)
        ////        
        let btn2 = UIButton(type: .custom)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.tag = 0
        
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [ item1 , item2 ]
        
        //////
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn3Action(){
        
//        self.tabBarController?.navigationController?.navigationBar.isHidden = true
//        
//        self.navigationController?.navigationBar.isHidden = false
        
        self.tabBarController?.selectedIndex = 0
        
        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        
    }
    
    //MARK: Actions
    
    
    @IBAction func forgot_button(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
 
    }

    @IBAction func signIn_button(_ sender: UIButton) {
        
        //Email
        if email_TextField.text!.isEmpty{
            
            self.alertWithHandler(message: "Email cannot be empty"){
                
                self.email_TextField.becomeFirstResponder()
            }
            
            
        }else if self.validation.isValidEmail(email_TextField.text!) == false{
            
            self.alertWithHandler(message: "Invalid Email Id"){
                
                self.email_TextField.becomeFirstResponder()
            }
            
        }else
            //Password
            if (password_TextField.text?.isEmpty)!{
                
                self.alert(message: "Password cannot be empty")
                
            }else{
                
                self.connection()
        }
        
        
        
        
    }
    
    //MARK:- New Flow Add
    //MARK:-
    
    @IBAction func btn_Merchant(_ sender: UIButton) {
        
        
        let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let vc = stroryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: connection function
    
    func connection(){
        
        
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["email": email_TextField.text! as NSObject ,"password" : password_TextField.text! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("login", method_type: .post, params: parameters as [NSString : NSObject]){
            
            (receivedData) in
            
            Indicator.shared.hideProgressView()
            
            print(receivedData)
            
           
            if self.conn.responseCode == 1{
        
                if receivedData.value(forKey: "response") as! Int == 1{

                    UserDefaults.standard.set(true, forKey: "Login_Status")
                    
                     UserDefaults.standard.set("user_Flow", forKey: "Login_Flow")
         
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: receivedData.value(forKey: "data") as! NSDictionary), forKey: "LoginData")
                    
                    self.add_device()
                    
//                    print(UserDefaults.standard.value(forKey: "UserData")!)
//
                   
                    print(NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary)
//
                    singleton.sharedInstance.UserData = [:]
                    
                    singleton.sharedInstance.UserData = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary
                    
                    print( singleton.sharedInstance.UserData)
                    
                    //  var myId = String(describing:((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "UserData") as! Data) as! NSDictionary).value(forKey: "id")!))
                    
//                    let  alert = UIAlertController(title: "AIPL ABRO", message: receivedData.value(forKey: "message") as? String, preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
   
        //PushViewController
                    
                    if self.tabBarController?.selectedIndex == 4{
                    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        
                        
        self.navigationController?.pushViewController(vc, animated: true)
                    }
//        } ))
            
//        self.present(alert, animated: true, completion: nil)
        
        }else{
        
            self.alert(message: receivedData.value(forKey: "message") as! String)
        
            }
        
        }else{
            
            self.alert(message: receivedData.value(forKey: "Error") as! String)
        
        }
    
        }
    }
    
    func add_device(){
        
        var parameters: [NSString:NSObject] = [:]
        
        let unique_id = UIDevice.current.identifierForVendor!.uuidString
        
        print(unique_id)
        
        guard let token_id = UserDefaults.standard.value(forKey:"token") else{
            
            return
            
        }
        
    //    print(token_id!)
        
        let user_id = ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)!
      
        print(user_id)
        
        parameters = [ "user_id" : user_id as NSObject ,"device_id" : unique_id as NSObject ,"device_token": token_id as! NSObject,"device_type" : "1" as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("device_info", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject]){receivedData in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as? Bool == true  {
                    
                    // self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                }else{
                    
                    self.alert(message: "Something went wrong")
                    
                }
                
            }
            else {
                self.alert(message: (receivedData.value(forKey: "Error") as? String)!)
                
            }
            
        }
        
    }
   
    
    @IBAction func signUp_button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func signUp_Button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
  
    
}
