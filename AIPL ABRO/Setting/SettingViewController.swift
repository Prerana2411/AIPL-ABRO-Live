//
//  SettingViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/5/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    
    @IBOutlet var settingTableView_TableView: UITableView!
    
    @IBOutlet weak var bell_NavigationItem: UIBarButtonItem!
    
    
    //MARK: Variables
    
    var sectionHeading = ["SETTINGS"]
    
    var dataArray = ["Contact Us" , "About Us" , "Privacy Policy" ,"Notifications" ,"Logout"]

    var notification_status : Int = Int()
    
    let conn = webservices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        settingTableView_TableView.delegate = self
        
        settingTableView_TableView.dataSource = self
        
        settingTableView_TableView.sectionHeaderHeight = 50.0
        
        settingTableView_TableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
              
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Settings"
        
        
        
    }
    
    //MARK: functions
    
    @IBAction func bell_NavigationItem(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: Delegates and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return  sectionHeading.count
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame : CGRect(x: 0 , y: 0 , width: self.view.frame.width, height: 50))
        
        view.layer.backgroundColor = UIColor(red: 235/255, green:  235/255, blue:  235/255, alpha: 1.0).cgColor
        
        var label = UILabel()
        
        label.frame = CGRect(x: 25 , y: 10 , width: self.view.frame.width - 50, height: 30)
        
        label.text = sectionHeading[section]
        
        label.font = UIFont(name: "Arcon", size: 18)
        
        label.textColor = UIColor.darkGray
        
        view.addSubview(label)
        
        return view
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = settingTableView_TableView.dequeueReusableCell(withIdentifier: "settingTableView_Identifier") as! SettingTableViewCell
        
        cell.settingLabel_label.text = dataArray[indexPath.row]
        
        cell.arrowImage_ImageView.isHidden = false
        
        cell.notification_Switch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        if indexPath.row == 3{

            cell.notification_Switch.addTarget(self, action: #selector(toggleSwitch) , for: UIControl.Event.valueChanged)
            
            cell.notification_Switch.isHidden = false
            
            cell.arrowImage_ImageView.isHidden = true
            
            cell.status_label.isHidden = false
            
        }


        if indexPath.row == 4{

            cell.notification_Switch.isHidden = true

            cell.arrowImage_ImageView.isHidden = true

        }

        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        
        case 0 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1 : let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        
        vc.parentVC = "AboutUs"
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        case 2 : let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        
        vc.parentVC = "Privacy"
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        case 3 : break
            
        case 4 : UserDefaults.standard.set(false, forKey: "Login_Status")
        
        UserDefaults.standard.removeObject(forKey: "LoginData")
        
        singleton.sharedInstance.cartCount = 0
        
        singleton.sharedInstance.notificationCount = 0
        
        self.delete_device()
        
        self.navigationController?.popViewController(animated: true)
            
//        self.tabBarController?.selectedIndex = 0
//
//        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        
     //   let vc = storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        
      //  self.navigationController?.popToViewController(vc, animated: true)
            
//        let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
//
//            vc.selectedIndex = 0
//
//            self.navigationController?.pushViewController(vc, animated: false)
            
            
        default: break
            
        }
        
    }
    
    //MARK: deleteDevice service
    
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
                    
                    self.alert(message: "Something went wrong")
                    
                }
                
            }
            else {
                self.alert(message: (receivedData.value(forKey: "Error") as? String)!)
                
            }
            
            
        }
        
    }
    //Function
    
    
    @objc func toggleSwitch(){

        let index_path = NSIndexPath(row: 3, section: 0)
        
        let cell = self.settingTableView_TableView.cellForRow(at: index_path as IndexPath) as! SettingTableViewCell
        
        if (cell.notification_Switch.isOn == true){

            cell.status_label.text = "On"
            
            self.notification_status = 1
            
            self.status_chnge()
            
        }
        
        if (cell.notification_Switch.isOn == false){

            cell.status_label.text = "Off"
            
            self.notification_status = 0
            
            self.status_chnge()
            
        }
    }


    func status_chnge(){
        
        var parameters: [NSString:NSObject] = [:]
        
        let user_id = ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)!
        
        print(user_id)
        
        parameters = [ "user_id" : user_id as NSObject ,"status" : self.notification_status as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("update_user_notification", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject]){receivedData in
            
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
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}

