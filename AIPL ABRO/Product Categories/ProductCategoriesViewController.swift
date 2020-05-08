//
//  ProductCategoriesViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ProductCategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: Variables
    var productArray: NSArray =  []
  //  var productArray = ["Hardware Products", "Car Care Products", "Abrasive Products","waterproofing & Construction Chem"]
    
    var productArr = [String]()
    
    var subProductArray : NSArray = []
    
  //  var subProductArray = ["Adhesive Tapes", "Mirror Mounting Tape", "GHB Tape","Masking Tape","Bopp Packing Tape"]
    
    var subProductArr = [String]()
    
    var selectedItemIndex : Int!
    
    var data : NSDictionary!
    
    var heading = ""
    
    //MARK: Outlets
    
    @IBOutlet weak var productCategories_TableView: UITableView!
    
    @IBOutlet weak var productSubCategories_TableView: UITableView!
    
    @IBOutlet var triangleImage_ImageView: UIImageView!
    
    
    //MARK: WEB service Variables
    
    var validation = Validation()
    
    var conn = webservices()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        productCategories_TableView.tableFooterView = UIView()
        
        productSubCategories_TableView.tableFooterView = UIView()
        
        productCategories_TableView.sectionHeaderHeight = 0
        
        productSubCategories_TableView.sectionHeaderHeight = 60
        
        productCategories_TableView.layer.masksToBounds = false
        
        productCategories_TableView.layer.shadowColor = UIColor.darkGray.cgColor
        
        productCategories_TableView.layer.shadowOpacity = 1.0
        
        productCategories_TableView.layer.shadowOffset = CGSize(width: 2,height:0)
        
        productCategories_TableView.layer.shadowRadius = 5
        
        
        
        triangleImage_ImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = "Product Categories"
        
//        self.productCategories_TableView.delegate = self
//        
//        self.productCategories_TableView.dataSource = self
        
        self.connection()
        
        productCategories_TableView.frame.origin.x = 0
        
        productSubCategories_TableView.isHidden = true
        
        self.setNavBar()
        
     //   self.tabBarController?.tabBar.isHidden = true
        
        triangleImage_ImageView.isHidden = true
    }
    
    
    //MARK: Actions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == productCategories_TableView{
            
            return productArray.count
            
        }else{
            
            return subProductArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == productCategories_TableView{
            
            let cell = productCategories_TableView.dequeueReusableCell(withIdentifier: "productCategories_Identifier") as! ProductCategoriesTableViewCell
            
            //cell.productName_label.text = productArray[indexPath.row]
            
            cell.productName_label.text = String(describing: ((self.productArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "name")!))
            
           // heading = cell.productName_label.text!
            
          //  print("sec heading =  \(heading)")
            
            return cell
            
        }else{
            
            let cell = productSubCategories_TableView.dequeueReusableCell(withIdentifier: "productSubCategories_Identifier") as! ProductCategoriesTableViewCell
            
            cell.productSubCategory_label.text = String(describing: ((self.subProductArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "name")!))
                        
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == productCategories_TableView{
            
            
          //  heading = productArr[indexPath.row]
            
            heading = String(describing: ((self.productArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "name")!))
            
            if productCategories_TableView.frame.origin.x == 0{
            
            productCategories_TableView.frame.origin.x = -(productCategories_TableView.frame.width - 75)
            
            productSubCategories_TableView.frame.origin.x = 80
            
            triangleImage_ImageView.isHidden = false
                
            productSubCategories_TableView.isHidden = false
            
            productCategories_TableView.layer.masksToBounds = false
            
            productCategories_TableView.layer.shadowColor = UIColor.darkGray.cgColor
            
            productCategories_TableView.layer.shadowOpacity = 1.0
            
            productCategories_TableView.layer.shadowOffset = CGSize(width: 2,height:0)
            
            productCategories_TableView.layer.shadowRadius = 5
            
            subProductArray = (self.productArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "sub_category") as! NSArray
            
          //  print(subProductArray)
            
            productSubCategories_TableView.delegate = self
            
            productSubCategories_TableView.dataSource = self
            
            triangleImage_ImageView.isHidden = false
                
            self.productSubCategories_TableView.reloadData()
            
            }else{
                
                productCategories_TableView.frame.origin.x = 0
                
                productSubCategories_TableView.isHidden = true
                
                triangleImage_ImageView.isHidden = true
                
            }
            
            
        }else{

            let vc = storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
            
        //    vc.subCategory = subProductArray
            
            vc.selected = indexPath.row
            
            print(subProductArray)
            
            print("hhhhhh")
            
            vc.category = heading
            
            self.navigationController?.pushViewController(vc, animated: true)
//            productCategories_TableView.frame.origin.x = 0
//
//            productSubCategories_TableView.isHidden = true
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == productCategories_TableView{
            
            return UIView()
            
        }else{
            
            let view = UIView(frame : CGRect(x: 0 , y: 0 , width: self.view.frame.width, height: 60))
            
            view.layer.backgroundColor = UIColor(red: 235/255, green:  235/255, blue:  235/255, alpha: 1.0).cgColor
            
            let label = UILabel()
            
            label.frame = CGRect(x: 20 , y: 20 , width: self.view.frame.width - 50, height: 20)
            
            label.text = heading
            
            label.font = UIFont(name: "Arcon", size: 20)
            
            label.textColor = UIColor.darkGray
            
            view.addSubview(label)
            
            return view
            
        }
        
    }
    
    //MARK: Functions
    
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
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
//
//        vc.selectedIndex = 0
//
//        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    //MARK: Connection
    
    func connection(){
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithStringGetType(getUrlString: "category"){
            
            (receivedData) in
            
            Indicator.shared.hideProgressView()
            
       //     print(receivedData)
            
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as! Int == 1{
                    
                    self.productArray  =  receivedData.value(forKey: "data") as! NSArray
                    
                    self.productCategories_TableView.delegate = self
                    
                    self.productCategories_TableView.dataSource = self
                    
                    self.productCategories_TableView.reloadData()
                    
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else{
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
    }
   
    //
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
    
}
