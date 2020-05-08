//
//  SignUpViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    //MARK: Outlets

    @IBOutlet weak var icon_imageView: UIImageView!
    
    @IBOutlet weak var name_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var email_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phone_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var selectUserType_textField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var enterUserId_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var provided_Label: UILabel!
    
    @IBOutlet weak var password_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signUp_button: UIButton!
    
    @IBOutlet weak var selectUser_tableView: UITableView!
    
    @IBOutlet weak var dropImage_View: UIView!
    
    @IBOutlet var enterUserId_height: NSLayoutConstraint!
    
    @IBOutlet var enterUserId_top: NSLayoutConstraint!
    
    
    //MARK: Variables
    
    var userArray = ["Distributer","Direct Dealer" ,"Retailer" ,"End User"]
    
    var selectedItemIndex: Int!
    
    var selected = false
    
    var selectUserType = ""
    
    var selectusertype = 0
    
    var parentUserId = ""
    
    var userTypeArray : NSArray = []
    
    //MARK: WEB service Variables
    
    var validation = Validation()
    
    var conn = webservices()
    
    //MARK: My Functions
    
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
        
        name_textField.delegate = self
        
        email_textField.delegate = self
            
        phone_textField.delegate = self
            
        selectUserType_textField.delegate = self
        
        enterUserId_textField.delegate = self
        
        password_textField.delegate = self
        
        dropImage_View.clipsToBounds = true
        
        signUp_button.layer.cornerRadius =  signUp_button.frame.height/2
        
        signUp_button.layer.masksToBounds = true
        
        selectUser_tableView.tableFooterView = UIView()
        
        enterUserId_top.constant = 0
        
        enterUserId_height.constant = 0
        
        

//        name_textField.selectedTitle = ""
//        
//        email_textField.selectedTitle = ""
//        
//        phone_textField.selectedTitle = ""
//        
//        selectUserType_textField.selectedTitle = ""
//        
//        enterUserId_textField.selectedTitle = ""
//        
//        password_textField.selectedTitle = ""
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        selectUserType_textField.iconFont = UIFont(name: "FontAwesome", size: 32)
        
        selectUserType_textField.iconText = "\u{f107}"
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
     //   self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Sign Up"
        
        selectUser_tableView.layer.masksToBounds = true
        
        selectUser_tableView.layer.cornerRadius = 10
        
        dropImage_View.isHidden = true
        
        self.setNavBar()
        
        self.connectionForUserType()
        
    }
    
    //MARK: setnavbar
    func setNavBar(){
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn3Action(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func signUp_button(_ sender: UIButton) {
        
        if enterUserId_textField.text!.isEmpty {
            
            parentUserId = ""
            
        }else{
        
            parentUserId = enterUserId_textField.text!
        }
//Name
        if name_textField.text!.isEmpty{
            
            self.alertWithHandler(message: "Name cannot be empty"){
                
                self.name_textField.becomeFirstResponder()
                
            }
            
        }else
            
        if name_textField.text!.replacingOccurrences(of: " ", with: "") == "" {
            
            self.alertWithHandler(message: "Invalid Name"){
                
                self.name_textField.becomeFirstResponder()
                
                self.emptyText(txtFld: self.name_textField)
                
            }
            
        }else
            
        if self.validation.isValidCharacters(name_textField.text!) == false{
                
                self.alertWithHandler(message: "Invalid Name"){
                    
                    self.name_textField.becomeFirstResponder()
                    
                    self.emptyText(txtFld: self.name_textField)
                }
                
        }else
        
//Email
        if email_textField.text!.isEmpty{
            
            self.alertWithHandler(message: "Email cannot be empty"){
                
                self.email_textField.becomeFirstResponder()
            }
            
            
        }else if self.validation.isValidEmail(email_textField.text!) == false{
            
            self.alertWithHandler(message: "Invalid Email Id"){
                
                self.email_textField.becomeFirstResponder()
                
                
            }
            
        }else
            
 //Phone
            
        if phone_textField.text!.isEmpty{
            
            self.alertWithHandler(message: "Phone number cannot be empty"){
                
            self.phone_textField.becomeFirstResponder()
            }
            
        }else
        
        if validation.isValidPhoneNumber(phone_textField.text!) == false{
                
            self.alertWithHandler(message: "Phone number is not Valid"){
                
                self.phone_textField.becomeFirstResponder()
                
                self.emptyText(txtFld: self.phone_textField)
            }
                
        }else
            
//SelectUserType
            
       if selectUserType.count == 0{
                
                self.alert(message: "Select User Type")
                
        }else
        
//Password
        
        if (password_textField.text?.isEmpty)!{
            
            self.alert(message: "Password cannot be empty")
                      
        }else if password_textField.text!.characters.count<6 || password_textField.text!.characters.count>15{
            
            self.alertWithHandler(message: "Password length should between 6-15 Characters"){
                
                self.password_textField.becomeFirstResponder()
                
               // self.emptyText(txtFld: self.phone_textField)
            }
            
        }else
//Start Connection
            
        {
            
            self.connection()
            
        }
    }

    
    //MARK: connection function
    
    func connection(){
    
    var parameters : [NSString: NSObject] = [:]
    
        parameters = ["name": name_textField.text! as NSObject,
                      "user_type": selectusertype as NSObject,
                      "password" : password_textField.text! as NSObject ,
                      "phone" : phone_textField.text! as NSObject,
                      "email" : email_textField.text! as NSObject ,
                      "parent_user_id" : parentUserId as NSObject]
    
    print(parameters)
    
    Indicator.shared.showProgressView(self.view)
    
       
    self.conn.startConnectionWithSting("signup", method_type: .post, params: parameters as [NSString : NSObject])
    {
           (receivedData) in
        
        print(receivedData)
   
        Indicator.shared.hideProgressView()
    
        if self.conn.responseCode == 1{
           
            if receivedData.value(forKey: "response") as? Int == 1{
       
                let  alert = UIAlertController(title: "AIPL ABRO", message: receivedData.value(forKey: "message") as? String, preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
    
        //fetching user id
//
//         UserDefaults.standard.set(receivedData.value(forKey: "data") as! NSDictionary, forKey: "UserSignUpdata")
//
//         print(UserDefaults.standard.value(forKey: "UserSignUpdata")!)
    
         //   var temp = UserDefaults.standard.value(forKey: "UserSignUpdata")!
           
          //  print(  (temp as AnyObject).value(forKey: "id") as! Int  )
    
        //PushViewController
        
                    self.navigationController?.popViewController(animated: true)
    
                } ))
    
                self.present(alert, animated: true, completion: nil)
    
            }else{
    
                self.alert(message: receivedData.value(forKey: "message") as! String)
    
            }
    
        }else{
    
            self.alert(message: receivedData.value(forKey: "Error") as! String)
    
        }
    
        }
    
    }
    
    @IBAction func signIn_button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        if textField == selectUserType_textField{
            
            selectUserType_textField.text = ""
        
            self.view.endEditing(true)
       
            dropImage_View.isHidden = false
        
            return false
        
        }else{
            
            dropImage_View.isHidden = true
            
            return true
        }
        
    }
    

    //MARK: connection for user type
    
    func connectionForUserType(){
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithStringGetType(getUrlString: "AlluserType"){
            
            (receivedData) in
            
            Indicator.shared.hideProgressView()
            
            print(receivedData)
            
            if self.conn.responseCode == 1{
                
                if ((receivedData.value(forKey: "response") as! Bool) == true){
                    
                    self.userTypeArray = receivedData.value(forKey: "data") as! NSArray
                    
                    if self.userTypeArray.count != 0{
                        
                        self.selectUser_tableView.delegate = self
                        
                        self.selectUser_tableView.dataSource = self
                        
                        self.selectUser_tableView.reloadData()
                    }
                    
                }else{
                    
                      self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else{
                
                  self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    
    //MARK:- table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = selectUser_tableView.dequeueReusableCell(withIdentifier: "SignUp_Identifier") as! SignUpTableViewCell
        
        if selectedItemIndex != nil && selectedItemIndex == indexPath.row{
            
             cell.userTick_ImageView.isHidden = false
            
        }else{
            
             cell.userTick_ImageView.isHidden = true
            
        }
        
        cell.user_Label.text = String(describing: ((userTypeArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name"))!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedItemIndex = indexPath.row
        
        self.selectUserType_textField.text = String(describing: ((userTypeArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name"))!)//userArray[indexPath.row]
        
      //  selectUserType = userArray[indexPath.row]
        
        selectusertype = (userTypeArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as! Int
        
        selectUserType = String(describing: ((userTypeArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name"))!)
        
        dropImage_View.isHidden = true
        
        self.view.endEditing(true)
        
        if String(describing: ((userTypeArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name"))!) == "End User"{
            
            self.enterUserId_textField.isHidden = true
            
            self.provided_Label.isHidden = true
            
            self.enterUserId_top.constant = 0
            
            self.enterUserId_height.constant = 0
            
            self.enterUserId_textField.text = ""
            
            
        }else{
            
            
            enterUserId_textField.isHidden = false
            
            provided_Label.isHidden = false
            
            enterUserId_top.constant = 30
            
            enterUserId_height.constant = 45
            
        }
        
        
        
        print()
        
        self.selectUser_tableView.reloadData()
        
        
    }
    
   
}
