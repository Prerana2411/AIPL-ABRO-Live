//
//  CategoryViewController.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 22/02/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    //MARK: Outlets
    
    @IBOutlet weak var category_TableView: UITableView!
    
    //MARK: Variables
    
    var categoryArray: NSArray =  []
    
    var subCategoryArr : NSArray = []
    
    var check = NSMutableArray()
    
    var heading = ""
    
    //MARK: WEB service Variables
    
    var conn = webservices()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "call_controller"), object: nil, queue: nil) { (notification:Notification) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
            
            vc.selected = notification.userInfo?["selectedIndex"] as! Int
            
            vc.id = notification.userInfo?["id"] as! Int
            
            vc.subCategoryId = notification.userInfo?["sub_id"] as! Int
            
            vc.category = self.heading
            
            singleton.sharedInstance.categoryHeading = self.heading
            
            vc.subCategory = self.subCategoryArr
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
       // self.title = "Categories"
        
        self.navigationController?.navigationBar.topItem?.title = "Product Categories"
        
        self.connectionForCategory()
        
        self.setNavBar()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.categoryArray = []
                
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    

    //MARK: Connection
    
    func connectionForCategory(){
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithStringGetType(getUrlString: "category"){
            
            (receivedData) in
            
            Indicator.shared.hideProgressView()
            
            print(receivedData)
         
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as! Int == 1{
                    
                    self.categoryArray  =  receivedData.value(forKey: "data") as! NSArray
                    
                    self.check.removeAllObjects()
                    
                    for i in 0..<self.categoryArray.count{
                        
                        self.check.add(0)
                        
                    }
                    
                    self.category_TableView.delegate = self
                    
                    self.category_TableView.dataSource = self
                    
                    self.category_TableView.reloadData()
                    
                    self.category_TableView.tableFooterView = UIView()
                    
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else{
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
    }
    
    //MARK: TABLE delegate datasources
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            return self.categoryArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = category_TableView.dequeueReusableCell(withIdentifier: "category_Identifier") as! CategoryTableViewCell
     
        cell.categoryName_label.text = String(describing: ((self.categoryArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "name")!))
        
//        cell.categoryView_View.layer.masksToBounds = true
//
//        cell.categoryView_View.layer.cornerRadius = 8
//
//        cell.categoryView_View.giveShadowinnerview(Outlet: cell.categoryView_View)
//
        cell.subCategoryArr = []
        
        cell.subCategoryArr = (self.categoryArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "sub_category") as! NSArray
        
        cell.subCategory_TableView.delegate = cell
        
        cell.subCategory_TableView.dataSource = cell
        
        cell.subCategory_TableView.reloadData()
        
        if check.object(at: indexPath.row) as! Int == 0{
         
          //  self.category_TableView.rowHeight = 90
            
            cell.subCategoryTable_height.constant = 0
         
            cell.subCategory_TableView.isHidden = true
            
            cell.plus_Imageview.image = #imageLiteral(resourceName: "plus")
            
        }else{
            
            self.subCategoryArr = []

            self.subCategoryArr = (self.categoryArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "sub_category") as! NSArray
          
            cell.subCategoryTable_height.constant = CGFloat(((self.categoryArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "sub_category") as! NSArray).count * 45)
         
            cell.subCategory_TableView.isHidden = false
            
            cell.plus_Imageview.image = #imageLiteral(resourceName: "minus")
                        
            heading = String(describing: ((self.categoryArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "name")!))
        }
        

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if check.object(at: indexPath.row)as! Int == 0 {
        
        for i in 0..<check.count{
         
            if i == indexPath.row{
                
                check.replaceObject(at: indexPath.row, with: 1)
                
                
                
                
            }else{
             
                check.replaceObject(at: i, with: 0)
            
            }
           
            }
        }else{
            
            check.replaceObject(at: indexPath.row, with: 0)
           
        }
        
        self.category_TableView.reloadData()
  
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
    
    
    //MARK: SetNavBar
    
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
        
        //////////////////
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.tag = 0
        
        btn2.addTarget(self, action: #selector(self.btn2Action), for: .touchUpInside)
        
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [ ]
        
        //////
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn1Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        singleton.sharedInstance.notificationCount = 0
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn2Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn3Action(){
        
        self.tabBarController?.selectedIndex = 0
        
    }
}
