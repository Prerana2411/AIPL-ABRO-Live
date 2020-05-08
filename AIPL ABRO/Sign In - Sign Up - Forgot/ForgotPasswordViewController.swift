//
//  ForgotPasswordViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK:Outlets
    
    
    @IBOutlet weak var email_textField: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var recoverPassword_button: UIButton!
    
    
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
        
       // self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Arcon", size: 20)!]
        
        recoverPassword_button.layer.cornerRadius =  23
        
        recoverPassword_button.layer.masksToBounds = true
        
//        email_textField.selectedTitle = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Forgot Password"

        self.setNavBar()
        
    }

    //MARK: SetNavBar

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
    
    //MARK: Actions
    
    @IBAction func recoverPassword_Button(_ sender: UIButton) {
        
        //Email
        if email_textField.text!.isEmpty{
            
            self.alertWithHandler(message: "Email cannot be empty"){
                
                self.email_textField.becomeFirstResponder()
            }
            
            
        }else if self.validation.isValidEmail(email_textField.text!) == false{
            
            self.alertWithHandler(message: "Invalid Email Id"){
                
                self.email_textField.becomeFirstResponder()
            }
            
        }else{
            
            self.connection()
            
        }
        
        
    }
    
    //MARK: connection function
    
    func connection(){
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["email": email_textField.text! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("forget-password", method_type: .post, params: parameters as [NSString : NSObject]){
            
            (receivedData) in
        
            print(receivedData)
            
        Indicator.shared.hideProgressView()
        
        if self.conn.responseCode == 1{
        
            if receivedData.value(forKey: "response") as! Int == 1{
        
                let  alert = UIAlertController(title: "AIPL ABRO", message: receivedData.value(forKey: "message") as? String, preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
        
                    //PushViewController
        
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
                    self.navigationController?.pushViewController(vc, animated: true)
        
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

}
