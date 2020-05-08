//
//  NotificationViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 24/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
   
    //MARK: Outlet
   
    @IBOutlet var searchView_View: UIView!
    
    @IBOutlet weak var notification_SearchBar: UISearchBar!
    
    @IBOutlet weak var noNotification_label: UILabel!
    
    @IBOutlet weak var notification_TableView: UITableView!
    
    //MARK: Variables
    
   // var sectionArr = [ "Today" , "Earlier" ]
    
    var old_data : NSArray = []
    
    var new_data : NSArray = []
    
    var filterOldArray = NSArray()
    
    var filterNewArray = NSArray()
    
    var searchEnabled = "F"
    
    let conn = webservices()
    
    var id_notification = ""
    
    var dateFormatter = DateFormatter()
    
    var dataArray : NSMutableArray = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        notification_SearchBar.delegate = self
        
         dateFormatter.dateFormat = "HH:mm"
        
        searchView_View.layer.masksToBounds = true
        
        searchView_View.layer.cornerRadius = searchView_View.frame.height/2
        
        notification_TableView.tableFooterView = UIView()

        notification_TableView.sectionHeaderHeight = 45
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.get_data()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.title = "Notifications"
        
        //let defaultTextAttribs = [NSAttributedString.Key.font.rawValue: UIFont(name: "Arcon", size : 11), NSAttributedString.Key.foregroundColor.rawValue:UIColor.black]
        
        let defaultTextAttribs = [NSAttributedString.Key.font:UIFont(name: "Arcon", size: 11),NSAttributedString.Key.foregroundColor:UIColor.black]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = defaultTextAttribs as [NSAttributedString.Key : Any]
        
        
        
        
        if #available(iOS 13.0, *) {
                   
//                   let textField = notification_SearchBar.searchTextField
//                   textField.clearButtonMode = .never
               
               } else {
                   
                  let textField = notification_SearchBar.value(forKey: "_searchField") as? UITextField
                   textField?.clearButtonMode = .never
               }
        
        notification_TableView.tableFooterView = UIView()
        
    }

    //MARK: search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
         self.search()
    }
    
    func search(){
        
        dataArray.removeAllObjects()
        
        if notification_SearchBar.text?.count != 0 {
            let predicate = NSPredicate(format: "notification contains[C] %@", notification_SearchBar.text!)
            
            if old_data.count != 0 {
                
                filterOldArray = old_data.filtered(using: predicate) as NSArray
                
                if new_data.count != 0 {
                    filterNewArray = new_data.filtered(using: predicate) as NSArray
                    
                    if filterNewArray.count != 0 {
                        
                        let dict = ["data_type": "Today","data_Array": self.filterNewArray] as [String : Any]
                        
                        self.dataArray.add(dict)
                    }
                }
                
                if filterOldArray.count != 0 {
                    
                    let dict = ["data_type": "Earlier","data_Array": self.filterOldArray] as [String : Any]
                    
                    self.dataArray.add(dict)
                    
                }
            }
            
           
        }else {
            
            self.view.endEditing(true)
            
            if self.new_data.count != 0 {
                
                let dict = ["data_type": "Today","data_Array": self.new_data] as [String : Any]
                
                self.dataArray.add(dict)
                
            }
            
            if self.old_data.count != 0 {
                
                let dict = ["data_type": "Earlier","data_Array": self.old_data] as [String : Any]
                
                self.dataArray.add(dict)
            }
        }
        
       
        
        notification_TableView.reloadData()
        
    }
    
    //MARK:Delegates datasource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return dataArray.count
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return ((self.dataArray.object(at: section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = notification_TableView.dequeueReusableCell(withIdentifier: "notification_Identifier") as! NotificationTableViewCell
            
            let date_format1 = DateFormatter()
            
            date_format1.dateFormat = "hh:mm a"
            
            var time = ""
            
            cell.notificationDescription_label.text = ((((self.dataArray.object(at: indexPath.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: indexPath.row)as? NSDictionary)?.value(forKey: "notification")as? String)!
            
            time = (((((self.dataArray.object(at: indexPath.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: indexPath.row)as? NSDictionary)?.value(forKey: "created_at")as? String))!.components(separatedBy: "T")[1]
            
            let get_time = time.components(separatedBy: ":")[0] + ":" + time.components(separatedBy: ":")[1]
            
            let start_conv = self.dateFormatter.date(from: get_time)
            
            cell.notificationTime_label.text = date_format1.string(from: start_conv!)

            return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let notification_type = String(describing:((((self.dataArray.object(at: indexPath.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: indexPath.row)as? NSDictionary)?.value(forKey: "notification_type"))!)
        
        switch(notification_type){
            
        case "0" : let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = ((((self.dataArray.object(at: indexPath.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: indexPath.row)as? NSDictionary)?.value(forKey: "event_id") as! Int)
        
        navigationController?.pushViewController(vc, animated: true)
            
        case "1" :navigationController?.popToRootViewController(animated: true)
           
        case "2" :let vc = storyboard?.instantiateViewController(withIdentifier: "AIPLHomeViewController") as! AIPLHomeViewController
        
        self.navigationController?.popViewController(animated: true)
            
        case "3" :let vc = storyboard?.instantiateViewController(withIdentifier: "OffersViewController") as! OffersViewController
        
        
        vc.categoryArr = singleton.sharedInstance.categoryArr
      //  vc.id = ((((self.dataArray.object(at: indexPath.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: indexPath.row)as? NSDictionary)?.value(forKey: "event_id") as! Int)
        
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        case "4" :let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        case "5" :let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        default: break
            
        }
        
    }

 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame : CGRect(x: 0 , y: 0 , width: self.view.frame.width, height: 50))
        
        view.layer.backgroundColor = UIColor(red: 235/255, green:  235/255, blue:  235/255, alpha: 1.0).cgColor
        
        var label = UILabel()
        
        label.frame = CGRect(x: 25 , y: 10 , width: self.view.frame.width - 50, height: 25)
        
        label.text = ((self.dataArray.object(at: section) as! NSDictionary).value(forKey: "data_type") as! String)
        
        label.font = UIFont(name: "Arcon", size: 18)
        
        label.textColor = UIColor.darkGray
        
        view.addSubview(label)
        
        return view
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

           return true
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let hide = UITableViewRowAction(style: .normal , title: "\u{2613}\n Hide") { action, index in
            
            self.id_notification = String(describing:((((self.dataArray.object(at: index.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: index.row)as? NSDictionary)?.value(forKey: "id"))!)
            
            self.delete_notification()
            
            print("hide button tapped")
            
            print(index.row)
            
        }
        
        hide.backgroundColor = .red
        
        return [hide]
        
        
//        if editActionsForRowAt.section == 0{
//
//            let hide = UITableViewRowAction(style: .normal , title: "\u{2613}\n Hide") { action, index in
//
//                self.id_notification = String(describing:((((self.dataArray.object(at: index.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: index.row)as? NSDictionary)?.value(forKey: "id"))!)
//
//                self.delete_notification()
//
//                print("hide button tapped")
//
//                print(index.row)
//
//            }
//
//                hide.backgroundColor = .red
//
//                return [hide]
//
//            }else{
//
//                let hide = UITableViewRowAction(style: .normal , title: "\u{2613}\n Hide") { action, index in
//
//                    self.id_notification = String(describing:((((self.dataArray.object(at: index.section) as! NSDictionary).value(forKey: "data_Array") as! NSArray).object(at: index.row)as? NSDictionary)?.value(forKey: "id"))!)
//
//                    self.delete_notification()
//
//                    print("hide button tapped")
//
//                    print(index.row)
//
//                }
//
//                hide.backgroundColor = .red
//
//                return [hide]
//
//            }

        
        ///////////////////////////
            
//        }else{
//
//            if editActionsForRowAt.section == 0{
//
//                let hide = UITableViewRowAction(style: .normal , title: "\u{2613}\n Hide") { action, index in
//
//                    self.id_notification = String(describing:((self.filterNewArray.object(at: index.row)as? NSDictionary)?.value(forKey: "id"))!)
//
//                    self.delete_notification()
//
//                    print("hide button tapped")
//
//                    print(index.row)
//
//                }
//
//                hide.backgroundColor = .red
//
//                return [hide]
//
//            }else{
//
//                let hide = UITableViewRowAction(style: .normal , title: "\u{2613}\n Hide") { action, index in
//
//                    self.id_notification = String(describing:((self.filterOldArray.object(at: index.row)as? NSDictionary)?.value(forKey: "id"))!)
//
//                    self.delete_notification()
//
//                    print("hide button tapped")
//
//                    print(index.row)
//
//                }
//
//                hide.backgroundColor = .red
//
//                return [hide]
//
//            }
//
//        }
        
    }
    
    
    func delete_notification(){
        
        var parameters: [NSString:NSObject] = [:]
        
        parameters = [ "id" : self.id_notification as NSObject]
        
        print(parameters)
        
       // Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("deletenotification", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject]){receivedData in
            
            print(receivedData)
            
       //     Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as? Bool == true  {
                    
                   // self.get_data()
                    
                    // self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                    if self.new_data.count != 0 {
                        
                        let dict = ["data_type": "Today","data_Array": self.new_data] as [String : Any]
                        
                        self.dataArray.add(dict)
                        
                    }
                    
                    if self.old_data.count != 0 {
                        
                        let dict = ["data_type": "Earlier","data_Array": self.old_data] as [String : Any]
                        
                        self.dataArray.add(dict)
                    }
                    
                    self.notification_TableView.reloadData()
                    
                }else{
                    
                    self.alert(message: "Something went wrong")
                    
                }
                
            }
            else {
                self.alert(message: (receivedData.value(forKey: "Error") as? String)!)
                
            }
            
            
        }
               
        
    }
    
    
    func get_data(){
        
        self.old_data = []
        
        self.new_data = []
        
        self.dataArray = []
        
        var parameters: [NSString:NSObject] = [:]
        
        let user_id = ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)!
        
        print(user_id)
        
        parameters = [ "user_id" : user_id as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("find_notification_detail", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject]){receivedData in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as? Bool == true  {
                    
                    self.old_data = (receivedData.value(forKey: "old_notifications")as? NSArray)!
                    
                    self.new_data = (receivedData.value(forKey: "new_notifications")as? NSArray)!
                    
                    if self.new_data.count != 0 {
                        
                        let dict = ["data_type": "Today","data_Array": self.new_data] as [String : Any]
                        
                        self.dataArray.add(dict)
                    }
                    
                    if self.old_data.count != 0 {
                        
                        let dict = ["data_type": "Earlier","data_Array": self.old_data] as [String : Any]
                        
                        self.dataArray.add(dict)
                    }
                    
                    if self.new_data.count == 0 && self.old_data.count == 0{
                        
                        self.notification_TableView.isHidden = true
                        
                        self.noNotification_label.isHidden = false
                        
                    }
                    
                    self.notification_TableView.delegate = self
                    
                    self.notification_TableView.dataSource = self
                    
                    self.notification_TableView.reloadData()
                    
                    // self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                }else{
                    
                    self.alert(message: "No Notification Found")
                    
                }
                
            }
            else {
                self.alert(message: (receivedData.value(forKey: "Error") as? String)!)
                
            }
        }
        
    }
    
    func alert(message : String){
       
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    
}
