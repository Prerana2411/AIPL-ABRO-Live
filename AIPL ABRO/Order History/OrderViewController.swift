//
//  OrderViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/23/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //MARK: Outlet
    
    @IBOutlet weak var order_TableView: UITableView!
    
    
    
    let conn = webservices()
    
    var data : NSArray = []
    
    var tag = Int()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        order_TableView.delegate = self
        
        order_TableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.backItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Order History"
        
        self.setNavBar()
       
        print(tag)

        if tag == 0{
            self.get_data()
            
        }else{
            self.get_sampleData()
        }
       
    }
    
    //MARK: setNavBar
    
    func setNavBar(){
        
        let btn1 = UIButton(type: .custom)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn1.tag = 0
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        ///////////
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "cartw"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.tag = 0
        
        btn2.addTarget(self, action: #selector(self.btn2Action), for: .touchUpInside)
        
        
        var item2 = UIBarButtonItem(customView: btn2)
        
        if singleton.sharedInstance.cartCount == 0{
            
            item2 = UIBarButtonItem(customView: btn2)
            
            
        }else{
            
            var countLabel = UILabel()
            
            countLabel.frame = CGRect(x: 10, y: 1, width: 11, height: 11)
            
            countLabel.font = UIFont(name: "Arcon", size: 7)
            
            countLabel.textAlignment = .center
            
            countLabel.textColor = UIColor.white
            
            countLabel.backgroundColor = UIColor(red: 34/255, green: 81/255, blue: 139/255, alpha: 1.0)
            
            countLabel.layer.cornerRadius = countLabel.frame.size.height/2
            
            countLabel.layer.masksToBounds = true
            
            countLabel.text = String(describing: singleton.sharedInstance.cartCount)
            
            let cardView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            
            cardView.addSubview(btn2)
            
            cardView.addSubview(countLabel)
            
            item2 = UIBarButtonItem(customView: cardView)
            
        }
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [item2 , item1]
        
        //////
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn2Action(){
        
        self.tabBarController?.selectedIndex = 2
        
    }
    
    @objc func btn3Action(){
       
        //self.navigationController?.popToRootViewController(animated: true)
     //   self.tabBarController?.navigationController?.popViewController(animated: true)
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        
      //  self.tabBarController?.navigationController?.popToViewController(vc, animated: true)
        //self.?tabBarController?.selectedIndex = 3
        
         self.navigationController?.popViewController(animated: true)
    }

    
    //MARK: table delegates datasource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
        
        vc.data = ((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "OrderHistoryProduct")as? NSArray)!
        
        vc.order_id = ((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "order_no")as? String)!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = order_TableView.dequeueReusableCell(withIdentifier: "Order_Identifier") as! OrderTableViewCell
        
        cell.oderView_View.layer.masksToBounds = true
        
        cell.oderView_View.layer.cornerRadius = 8
        
        cell.oderView_View.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.oderView_View.shadow(Outlet: cell.oderView_View)
        
        
        cell.orderId_label.text = "Order Id : " +  String(describing:((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "order_no"))!)
        
        cell.ordre_priceLbl.text =  "Rs " + String(describing:((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "final_total"))!) 
        
        let date_placed = ((self.data.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "created_at") as? String)?.components(separatedBy: "T")
        
        if ((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "order_status_id") as? Int) == 1{
            
            cell.orderStatus_label.text = "Delivery Pending"
            
            singleton.sharedInstance.deliveryStatus = "Delivery Pending"
            
        }else if ((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "order_status_id") as? Int) == 2 {
            
            cell.orderStatus_label.text = "Delivery Completed"
            
            singleton.sharedInstance.deliveryStatus = "Delivery Completed"
            
        }else{
            
            cell.orderStatus_label.text = "N/A"
            
        }
        
        cell.orderDate_label.text = date_placed?[0]
        
        singleton.sharedInstance.bookDate = date_placed![0]
        
        if ((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "delivery_date")) is NSNull{
            
            singleton.sharedInstance.deliveryDate = "N/A"
            
        }else{
        
            singleton.sharedInstance.deliveryDate = String(describing:((self.data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "delivery_date"))!)
            
        }
        
        return cell
    }
    
    
    func get_data(){
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            var parameters : [NSString: NSObject] = [:]
            
            parameters = ["user_id":((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject]
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("order_historySecond", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    //self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                    self.data = (receivedData.value(forKey: "data") as! NSArray).reversed() as NSArray
                    
                    self.order_TableView.reloadData()
                    
                }else {
                    
                    self.alert(message: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
        }
    }
    
    //MARK: sample order
    func get_sampleData(){
        
     //   if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            var userId = ""
            var parameters : [NSString: NSObject] = [:]
            
            if (UserDefaults.standard.value(forKey: "Login_Flow") as? String)! == "corp_flow" {
                
                let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
                
                if userData != [:] {
                    
                    userId = userData.value(forKey: "Code") as? String ?? ""
                    parameters = ["user_id":userId as NSObject]
                    
                }
            }
                
                
                else{
                     parameters = ["user_id":((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject]
                
                }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("order_history_sample", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    //self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                    self.data = (receivedData.value(forKey: "data") as! NSArray).reversed() as NSArray
                    
                    self.order_TableView.reloadData()
                    
                }else {
                    
                    self.alert(message: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
      //  }
    }
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
