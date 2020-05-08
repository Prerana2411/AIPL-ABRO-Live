//
//  CartProductsViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/27/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

//protocol child_productTotal {
//
//    func child_Total(price:NSMutableArray)
//}

class CartProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    //MARK: Outlets
    
    @IBOutlet var cart_TableView: UITableView!
    
    
    //MARK: Variables
    
    var product_id = ""
    
    var childProductsData : NSArray = []
    
    var discountData : NSDictionary = [:]
    
    let conn = webservices()
    
    var child_total : NSMutableArray = []
    
    var orderDate = String()
    
   // var delegate : child_productTotal?
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
        cart_TableView.delegate = self
        
        cart_TableView.dataSource = self
        
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.child_total.removeAllObjects()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = "Sub Cart"
        
        if childProductsData.count == 0{
            
            
        }else{
            
            cart_TableView.delegate = self
            
            cart_TableView.dataSource = self
            
           // cart_TableView.tableFooterView = UIView()
            
          //  cart_TableView.reloadData()
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        childProductsData = []
        
    }
    
    //MARK: table delegate datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return childProductsData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cart_TableView.dequeueReusableCell(withIdentifier: "cart_Identifier") as! CartProductsTableViewCell
        
        cell.cross_btn.tag = indexPath.row
        
        cell.cross_btn.addTarget(self, action: #selector(self.delete_childProduct), for: .touchUpInside)
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 8
        
        cell.fullView_View.giveShadow(Outlet: cell.fullView_View)
        
        cell.productCode_label.text = "Product Code : " + String(describing: (((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "product_code"))!)
        
        cell.quantity_label.text = "Quantity : " + String(describing: ((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "quantity"))!)
        
        let date_placed = orderDate.components(separatedBy: "T")

        cell.date_label.text = date_placed[0]
        
        if self.discountData == [:]{
            
            cell.price_label.text = "Rs: " + String(describing:((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) * (((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!))
            
        }else{
            
            var discPrice = Int()
            
            if self.discountData.value(forKey: "discount_type") as! Int == 1{
                
                discPrice = Int((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) - (Int((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Int((self.discountData.value(forKey: "discount_price") as? Int)!) / 100)
                
                cell.price_label.text = "Rs: " + String(describing:((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) * discPrice))
                
            }
            
            
            if self.discountData.value(forKey: "discount_type") as! Int == 2{
                
                discPrice = Int((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as! Int)) -  Int(self.discountData.value(forKey: "discount_price") as! Int)
                
                cell.price_label.text = "Rs: " + String(describing:((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) * discPrice))
                
            }
            
        }
        
        
        
        
        //self.child_total.add((((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) * (((childProductsData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!)
        
       // print(self.child_total)
        
        return cell
        
    }

    @objc  func delete_childProduct(sender:UIButton){

        var parameters : [NSString: NSObject] = [:]
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
            
            parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                          "product_id" : self.product_id as NSObject,"product_pack_id":((self.childProductsData.object(at: sender.tag)as? NSDictionary)?.value(forKey: "product_pack_id")as? Int)! as NSObject]
            
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("delete_child_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    //self.delegate?.child_Total(price: self.child_total)
                    
                    //self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                    self.navigationController?.popViewController(animated: true)              
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
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
