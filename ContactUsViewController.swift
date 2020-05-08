//
//  ContactUsViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/5/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet var name_textField: SkyFloatingLabelTextField!
    
    @IBOutlet var email_textField: SkyFloatingLabelTextField!
    
    @IBOutlet var feedback_textView: UITextView!
    
    @IBOutlet var submit_button: UIButton!
    
    @IBOutlet weak var bell_NavigationItem: UIBarButtonItem!
    
    //MARK: variable
    var conn = webservices()
    
    var validation = Validation()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        name_textField.selectedTitle = ""
        
        email_textField.selectedTitle = ""
        
        feedback_textView.delegate = self
        
        submit_button.layer.masksToBounds = true
        
        submit_button.layer.cornerRadius = submit_button.frame.height/2
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Contact Us"
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String != nil{
                
                self.name_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String
                
            }
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String != nil{
                
                self.email_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String
                
            }
            
        }
        
    }
    
    //MARK: Textview delegate
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        
        if feedback_textView.text == "Write Feedback/Message"{
        
        feedback_textView.text = ""
        
            return true
            
        }else{
            
            return true
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if feedback_textView.text.isEmpty{
            
            feedback_textView.text = "Write Feedback/Message"
            
        }
        
    }
    
    
    @IBAction func bell_NavigationItem(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    //MARK: functions
    
    func setNavBar() {
        
        
        let btn1 = UIButton(type: .custom)
        
        btn1.setImage(#imageLiteral(resourceName: "bell"), for: .normal)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn1.tag = 0
        
        btn1.addTarget(self, action: #selector(self.btn1Action), for: .touchUpInside)
        
        var item1 = UIBarButtonItem(customView: btn1)
        
        if singleton.sharedInstance.notificationCount == 0{
            
            item1 = UIBarButtonItem(customView: btn1)
            
            
        }else{
            
            var notify_label = UILabel()
            
            notify_label.frame = CGRect(x: 10, y: 1, width: 11, height: 11)
            
            notify_label.font = UIFont(name: "Arcon", size: 7)
            
            notify_label.textAlignment = .center
            
            notify_label.textColor = UIColor.white
            
            notify_label.backgroundColor = UIColor(red: 34/255, green: 81/255, blue: 139/255, alpha: 1.0)
            
            notify_label.layer.cornerRadius = notify_label.frame.size.height/2
            
            notify_label.layer.masksToBounds = true
            
            notify_label.text = String(describing: singleton.sharedInstance.notificationCount)
            
            let cardView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            
            cardView.addSubview(btn1)
            
            cardView.addSubview(notify_label)
            
            item1 = UIBarButtonItem(customView: cardView)
            
        }
        
        self.tabBarController?.navigationItem.rightBarButtonItem = item1
        
    }
    
    @objc func btn1Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        singleton.sharedInstance.notificationCount = 0
        
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: Actions
    
    @IBAction func submit_Button(_ sender: UIButton) {
        
        if feedback_textView.text.replacingOccurrences(of: " ", with: "") == ""{
            
            alertWithHandler(message: "Please write something", block: {
                
                self.feedback_textView.text = ""
                
                self.feedback_textView.becomeFirstResponder()
                
            })
            
        }else if feedback_textView.text! == "Write Feedback/Message"{
            
            alertWithHandler(message: "Empty feedback not allowed", block: {
                
                self.feedback_textView.text = ""
                
                self.feedback_textView.becomeFirstResponder()
                
            })
            
        }else{
            
            self.connection()
            
        }
        
    }
    
    //MARK: connection contact us
    func connection() {
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["message": feedback_textView.text! as NSObject , "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("contactus", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.alertWithHandler(message: "Message send successfully", block: {
                        
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: ALERT Functions
    
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
}
