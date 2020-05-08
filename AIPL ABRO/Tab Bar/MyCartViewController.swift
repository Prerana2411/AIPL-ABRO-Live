//
//  MyCartViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    //MARK: Outlets
    
    @IBOutlet weak var shopNow_button: UIButton!
    //non empty cart
    
    @IBOutlet weak var myCart_tableView: UITableView!
    
    @IBOutlet weak var makeOrder_button: UIButton!
    
    @IBOutlet weak var overlay_View: UIView!
    
    @IBOutlet weak var redeemCode_View: UIView!
    
    @IBOutlet weak var total_amtView: UIView!
    
    @IBOutlet weak var redeemCode_textfield: SkyFloatingLabelTextField!
    
    @IBOutlet weak var rate_lbl: UILabel!
    //MARK: variables
    
    var conn = webservices()
    
    var myCartData : NSMutableArray = []
    
    var deleteId = Int()
    
    var redeem_offerCheck : NSMutableArray = []
    
    var child_productTotal : NSMutableArray = []
    
    var image = [UIImage]()
    
    var Title = ["Self Adhesive " , "Self Adhesive " , "Self Adhesive "]
    
    var Description = ["30 Rolls" , "30 Rolls" , "30 Rolls "]
    
    var Product_id : NSMutableArray = []
    
    var Quantity : NSMutableArray = []
    
    var offerType : NSMutableArray = []
    
    // var pre_total : NSMutableArray = []
    
    var post_total : NSMutableArray = []
    
    var final_total = ""
    
    var discount = Float()
    
    var voucher_id : NSMutableArray = []
    
    var voucher_id_forRedeemOffer = ""
    
    var product_idForRedeemOffer = ""
    
    /////// Child product Details
    
   
    
    var subDiscount : NSMutableArray = []
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(setNavigation), name: NSNotification.Name(rawValue: "goToCart"), object: nil)
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//
//        self.tabBarController?.navigationController?.navigationBar.topItem?.title = ""
//
//        self.tabBarController?.navigationController?.navigationBar.backItem?.title = ""
//
//        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "My Cart"
//
//        self.tabBarController?.navigationItem.title = "My Cart"
//    }
    
//    func setNavigation(){
//
//        self.setNavBar()
//
//        self.tabBarController?.navigationController?.navigationBar.topItem?.title = ""
//
//        self.tabBarController?.navigationController?.navigationBar.backItem?.title = ""
//
//        self.title = "My Cart"
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //empty cart
        
        UserDefaults.standard.set(false, forKey: "pushToCart")
        
        self.rt_btn()
        
        self.myCart_tableView.delegate = self
        
        self.myCart_tableView.dataSource = self
        
        shopNow_button.layer.cornerRadius = 23
        
        shopNow_button.layer.masksToBounds = true
        
        makeOrder_button.layer.cornerRadius = 23
        
        makeOrder_button.layer.masksToBounds = true
        
        redeemCode_View.layer.cornerRadius = 13
        
        redeemCode_View.layer.masksToBounds = true
        
        self.total_amtView.shadow(Outlet: total_amtView)
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = "My Cart"
        
        self.Quantity.removeAllObjects()
        
        self.child_productTotal.removeAllObjects()
        
        self.Product_id.removeAllObjects()
        
        self.offerType.removeAllObjects()
        
        self.post_total.removeAllObjects()
        
        self.setNavBar()
        
        self.tabBarController?.tabBar.isHidden = false
        
        if UserDefaults.standard.bool(forKey: "Login_Status"){
            
            self.connection()
            
            
        }else{
            
            myCart_tableView.isHidden = true
            
        }
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "goToCart"), object: nil, queue: nil) { (Notification) in
//            
//            self.tabBarController?.selectedIndex = 2
//            
//        }
        
    }
    
    //MARK: Touch function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch = touches.first!
        
        if touch.view != redeemCode_View {
            
            self.overlay_View.isHidden = true
            
        }
    }
    
    //MARK: Connection - cart product service
    
    func connection() {
        
        var parameters : [NSString: NSObject] = [:]
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
            
            parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                          "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject]
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.myCartData.removeAllObjects()
                    
                    self.myCartData = (receivedData.value(forKey: "data") as! NSArray).mutableCopy() as! NSMutableArray
                    
                    for _ in 0..<self.myCartData.count{
                        
                        self.redeem_offerCheck.add(0)
                        
                    }
                    
                    if self.myCartData.count == 0 {
                        
                        self.myCart_tableView.isHidden = true
                        
                        self.myCart_tableView.reloadData()
                        
                    }else{
                        
                        for i in 0..<self.myCartData.count{
                            
                            if ((self.myCartData.object(at: i) as! NSDictionary).value(forKey: "CartchildProduct") as! NSArray).count == 0{
                                
                                self.deleteId = ((self.myCartData.object(at: i) as? NSDictionary)?.value(forKey: "product_id") as! Int)
                                
                                self.deleteParentProduct()
                                
                                self.myCartData.removeObject(at: i)
                            
                            }
                        }
                        
                        self.myCart_tableView.isHidden = false
                        
                        self.myCart_tableView.reloadData()
                        
                    }
                }else{
                    
                    self.myCart_tableView.isHidden = true
                    
                    self.myCartData = []
                    
                    self.myCart_tableView.reloadData()
                    
                }
                
                if self.post_total.count == 0 {
                    
                    let swiftArray = NSArray(array:self.child_productTotal) as! Array<Float>
                    
                    self.rate_lbl.text =  "Rs: " + String(describing:(swiftArray.reduce(0) { $0 + $1 }))
                    
                }else{
                    
                    if self.child_productTotal.count != 0 {
                        
                        for i in 0..<self.post_total.count{
                            
                            if Float((self.post_total.object(at: i)as? Float)!) == 0.0 {
                                
                                self.post_total.replaceObject(at: i, with: self.child_productTotal.object(at: i))
                                
                            }else{
                                
                            }
                        }
                        
                    }else{
                        
                    }
                    
                    let swiftArray = NSArray(array:self.post_total) as! Array<Float>
                    
                    self.rate_lbl.text =  "Rs: " + String(describing:(swiftArray.reduce(0) { $0 + $1 }))
                }
                
            }else {
                
                //self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
        }
    }
    
    //MARK: SetNavBar Actions
    
    func setNavBar(){
        
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
        
        ///////////
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "cartw"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.tag = 0
        
        var item2 = UIBarButtonItem(customView: btn2)
        
        if singleton.sharedInstance.cartCount == 0{
            
            item2 = UIBarButtonItem(customView: btn2)
            
            self.myCart_tableView.isHidden = true
            
            
        }else{
            
            self.myCart_tableView.isHidden = false
            
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
        
        //////////////////
        
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
    
    //    @objc func btn2Action(){
    //
    //        let vc = storyboard?.instantiateViewController(withIdentifier: "AIPLHomeViewController") as! AIPLHomeViewController
    //
    //        self.navigationController?.pushViewController(vc, animated: true)
    //
    //    }
    
    @objc func btn3Action(){
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    //empty cart
    
    @IBAction func shopNow_button(_ sender: UIButton) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    //non empty cart
    
    @IBAction func makeOrder(_ sender: UIButton) {
        
        if self.redeem_offerCheck.contains(1){
            
            alert(message: "Please redeem offer to Make Order")
            
        }else{
            
            
            var parameters : [NSString: NSObject] = [:]
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                if self.post_total.count != 0{
                    
                    parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                                  "product_id" : self.Product_id.componentsJoined(by: ",") as NSObject,
                                  "quantity":self.Quantity.componentsJoined(by: ",")as NSObject,
                                  "subtotal":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "discount":self.subDiscount.componentsJoined(by: ",") as NSObject,
                                  "voucher_id":self.voucher_id.componentsJoined(by: ",") as NSObject,
                                  "total":self.post_total.componentsJoined(by: ",") as NSObject,
                                  "final_total": self.rate_lbl.text!.components(separatedBy: " ")[1] as NSObject ,
                                  "offertype" : self.offerType.componentsJoined(by: ",") as NSObject ]
                    
                }else{
                    
                    parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                                  "product_id" : self.Product_id.componentsJoined(by: ",") as NSObject,
                                  "quantity":self.Quantity.componentsJoined(by: ",")as NSObject,
                                  "subtotal":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "discount":self.subDiscount.componentsJoined(by: ",") as NSObject,
                                  "voucher_id":self.voucher_id.componentsJoined(by: ",") as NSObject,
                                  "total":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "final_total": self.rate_lbl.text!.components(separatedBy: " ")[1] as NSObject ,
                                  "offertype" : self.offerType.componentsJoined(by: ",") as NSObject]
                }
                
            }
            
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("insert_into_order", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    if receivedData.value(forKey: "response") as! Bool == true{
                        
                        singleton.sharedInstance.cartCount = 0
                        
                        self.alertWithHandler(message: receivedData.value(forKey: "message") as! String, block: {
                            
                            self.setNavBar()
                            
                        })
                        
                    }else{
                        
                        self.alert(message: receivedData.value(forKey: "message") as! String)
                        
                    }
                    
                    
                }else {
                    
                    self.alert(message: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: Shopping Button
    
    @IBAction func continueShopping_Button(_ sender: UIButton) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    
    //MARK: TAbleview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myCartData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myCart_tableView.dequeueReusableCell(withIdentifier: "myCart_Identifier") as! MyCartTableViewCell
        
        cell.reedemOffer_button.isHidden = false
        
        cell.cutView_View.isHidden = false
        
        cell.cross_btn.tag = indexPath.row
        
        cell.cross_btn.addTarget(self, action: #selector(self.delete_product), for: .touchUpInside)
        
        if ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription")is NSNull) || String(describing: ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription"))!) == "<null>"{
            
            
            
        }else{
            
            cell.productCode_label.text = "Product Code : " + String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "product_code"))!)
            
            cell.productName_label.text = String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "name"))!)
            
            if String(describing:(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as?NSDictionary)?.value(forKey: "image") )!) == "<null>" || (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as?NSDictionary)?.value(forKey: "image") is NSNull){
                
                cell.image_imageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.image_imageView.setImageWith((NSURL(string : productImage_url + ((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as?NSDictionary)?.value(forKey: "image") as? String)!)) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
        }
        
        var val = Float()
        
        var Qty = Int()
        
        
        if ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count > 1{
            
            for j in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                
//                val = (((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) + val
//
//
//                Qty = (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) + Qty
                
                
                if String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>"{
               /*         */
                    self.child_productTotal.add((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                    
                    val = (Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) + val
                    
                    
                    Qty = (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) + Qty
                    
                }else{
                    
                    if String(describing :((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount"))!) == "<null>"{
                        
                        
                    }else{
                        
                        if ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as! Int == 1{
                  
                            
                            let discPrice = Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) - ((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as! Int))/100)
                            
                            /*         */
                            self.child_productTotal.add(Float(discPrice * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                            
                            val = (Float(discPrice * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) + Float(val))
                            
                        }
                        
                        
                        if ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as! Int == 2{
                            
                            let discPrice = Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) - Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as! Int)
                            
                            self.child_productTotal.add(Float(discPrice * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                            
                            val = Float(discPrice * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) + Float(val)
                            
                        }
                        
                        Qty = (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!) + Qty
                    
                    }
                
                }
              
                /*///sub child product details data*/
                
                self.Quantity.add((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!))
                
                self.Product_id.add((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "product_pack_id")as? Int)!))

            }
            
            cell.price_label.text = "Rs. " + String(describing:val) //+ ".00"
            
            cell.quantity_label.text = String(describing:Qty) + " Units  "
            
            /* before */
            
           // self.child_productTotal.add(val)
            
           // self.Quantity.add(Qty)
 
            print(Quantity)
            
          
            
        }else{
            
            for i in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                
                cell.quantity_label.text = String(describing:((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity"))!) + " Units  "
                
                  self.Product_id.add((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "product_pack_id")as? Int)!))
                
                self.Quantity.add((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!))
               
/////////Gursant
                var discPrice = Int()
                
                if String(describing:((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription"))!) == "<null>"{
                    
                    
                }else{
                    
                    if String(describing :(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>"{
   ///
                        self.child_productTotal.add((((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                    
                        
                        
                        cell.price_label.text = "Rs. " + String(describing:(((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))

                        
                    }else{
                        
                        if String(describing :((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount"))!) == "<null>"{
                            
                            
                        }else{
                            
                            if ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as! Int == 1{
                                
                                discPrice = (Int((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) - ((Int((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (Int(((((myCartData.object(at: i) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as! Int))/100)))
                                
                                cell.price_label.text = "Rs. " + String(describing:(discPrice * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                                
                            }
                            
                            
                            if ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as! Int == 2{
                                
                                discPrice = Int((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) -  Int(((((myCartData.object(at: i) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as! Int)
                                
                                cell.price_label.text = "Rs. " + String(describing:(discPrice * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                                
                            }
                            
                            
                        }
                        
                        self.child_productTotal.add((discPrice * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                        
                        
                        cell.price_label.text = "Rs. " + String(describing:(discPrice * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                        
                        
                    }
                   
                    
                }
               
    ////////gur end
                
                
                //////shivani mam
                
//                self.child_productTotal.add((((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
//
//
//                cell.price_label.text = "Rs. " + String(describing:(((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)))
                
                ///mam end
                
                
                //gur start
                
                
            
                //gur end
            }
            
            
        }
        
        
        print(self.child_productTotal)
        
        /* before */
      //  self.Product_id.add(((self.myCartData.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "product_id")as? Int)!) */
        
        //self.rate_lbl.text = "Rs: " + String(describing:(self.child_productTotal.reduce(0){$0+ $1}))
        
        cell.reedemOffer_button.tag = indexPath.row
        
        cell.reedemOffer_button.addTarget(self, action: #selector(redeemAction) , for: .touchUpInside )
        
        cell.shadow_view.layer.cornerRadius = 5
        
        cell.shadow_view.layer.masksToBounds = true
        
        cell.shadow_view.shadow(Outlet: cell.shadow_view)
        
        
        //MARK: OfferType
   ///////////////
        
   ////////////
        
        if String(describing:((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription"))!) == "<null>" || ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription")) is NSNull{
            
            
        }else{
            
            if (((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")is NSNull) || String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>"  && (((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere")is NSNull) || String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!) == "<null>" {
                
                self.offerType.add("")
                
                
                
            }else  if (((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")is NSNull) || String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>" {
                
                self.offerType.add("REWARD")
                
            }else if (((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere")is NSNull) || String(describing:(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!) == "<null>"{
                
                self.offerType.add("COMBO")
                
            }else{
                
                self.offerType.add("")
                
            }
            
            
            if (((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")is NSNull) || (String(describing:((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!)) == "<null>" || ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))is NSNull)){
                
                self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 0)
                
                cell.reedemOffer_button.isHidden = true
                
                cell.cutView_View.isHidden = true
                
                self.discount = 0
                
                self.subDiscount.add(0)
                
                self.voucher_id.add(0)
                
                for i in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as! NSArray).count{
                
                self.post_total.add(0.0)
                }
                
            }else{
                
                
                if (String(describing:((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!)) == "<null>" || ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))is NSNull)) && (String(describing:((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!)) == "<null>" || ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere"))is NSNull)) {
                    
                    self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 0)
                    
                    cell.reedemOffer_button.isHidden = true
                    
                    cell.cutView_View.isHidden = true
                    
                }else{
                    
                    cell.reedemOffer_button.isHidden = false
                    
                    cell.cutView_View.isHidden = false
                    
                    self.redeemCode_textfield.text = (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "code")as? String)!
                    
                    
                    if  String(describing:(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "reedemOfferProductdiscount"))!) == "<null>" || (((((myCartData.object(at:  indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "reedemOfferProductdiscount")is NSNull){
                        
                        self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 1)
                        
                    }else{
                        
                        self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 0)
                    }
                    
                    //9966409f9e0e16a0fa6d18f9ae60ffaa92f942d5e9819f2a424876fd7b711dc2
                    
                    if  String(describing:(((((myCartData.object(at:  indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere")as? NSDictionary)?.value(forKey: "Productrewardofferdetaile")as? NSDictionary)?.value(forKey: "reedemrewardoffer"))!) == "<null>" || (((((myCartData.object(at:  indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "Productrewardoffere")as? NSDictionary)?.value(forKey: "Productrewardofferdetaile")as? NSDictionary)?.value(forKey: "reedemrewardoffer")is NSNull){
                        
                        self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 1)
                        
                    }else{
                        self.redeem_offerCheck.replaceObject(at: indexPath.row, with: 0)
                    }
                }
                
                
                voucher_id.add((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "voucher_id")as? Int)!))
                
                var discounted_price = Float()
                
                if  (((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "discount_type")as? Int)! == 2{
                    
                    self.discount = Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "discount_price")as? Int)!)
                    
                    
                    if ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count > 1{
                        
                        for j in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                            
                            discounted_price = (Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) - discount + discounted_price
               
                            /*   sub product details data     */
                            
                            self.subDiscount.add(Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "discount_price")as? Int)!/100))
                            
                            self.post_total.add(((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!))-discount))
                        }
                        
                      /*  self.post_total.add(discounted_price)*/
                        
                        print("discounted_price\(post_total)")
                        
                        cell.price_label.text = "Rs. " + String(describing:discounted_price)
                        
                    }else{
                        
                        for i in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                            
                            self.post_total.add((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) - discount)
                            
                            self.subDiscount.add(discount)
                            
                            
                            cell.price_label.text = "Rs. " + String(describing:((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) - discount))
                        }
                    }
                    
                }else{
                    
                    self.discount = Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "cartProductdiscountamount")as? NSDictionary)?.value(forKey: "discount_price")as? Int)!)
                    
                    if ((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count > 1{
                        
                        for j in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                            
                            discounted_price = Float((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) * Float(discount) )/100   + Float(discounted_price)
                            
                            self.post_total.add(Float((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: j) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:j) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) * Float(discount) )/100)
                            
                        }
                        
                       /* self.post_total.add(discounted_price)*/
                        
                        print("discounted_price\(post_total)")
                        
                        cell.price_label.text = "Rs. " + String(describing:discounted_price)
                        
                    }else{
                        
                        
                        for i in 0..<((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!.count{
                            
                            self.post_total.add(Float(((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) * Float(discount) )/100))
                            
                            
                            cell.price_label.text = "Rs. " + String(describing:Float(((Float((((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at: i) as? NSDictionary)?.value(forKey: "CartchildProductdetails") as? NSDictionary)?.value(forKey: "price")as? Int)!) * Float(((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)?.object(at:i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!)) * discount)/100))
                            
                        }
                    }
                }
            }
        }
        
        if post_total.count == 0 {

            let swiftArray = NSArray(array:child_productTotal) as! Array<Float>

            self.rate_lbl.text =  "Rs: " + String(describing:(swiftArray.reduce(0) { $0 + $1 }))

        }else{

            if child_productTotal.count != 0 {

                for i in 0..<post_total.count{

                    if Float((post_total.object(at: i)as? Float)!) == 0.0 {

                        self.post_total.replaceObject(at: i, with: self.child_productTotal.object(at: i))

                    }else{

                    }
                }

            }else{

            }

            let swiftArray = NSArray(array:post_total) as! Array<Float>

            self.rate_lbl.text =  "Rs: " + String(describing:(swiftArray.reduce(0) { $0 + $1 }))
        }
        
        return cell
        
    }
    
    @objc func redeemAction(sender:UIButton){
        
        
        overlay_View.isHidden = false
        
        if ((myCartData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "productdescription")is NSNull) || String(describing: ((myCartData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "productdescription"))!) == "<null>"{
            
            
            
        }else{
            
            if String(describing:(((myCartData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>"{
                
                
            }else{
                
                self.voucher_id_forRedeemOffer = String(describing:((((myCartData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer")as? NSDictionary)?.value(forKey: "voucher_id"))!)
                
            }
            
        }
        
        self.product_idForRedeemOffer = String(describing:((self.myCartData.object(at: sender.tag)as? NSDictionary)?.value(forKey: "product_id"))!)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartProductsViewController") as! CartProductsViewController
        
        vc.childProductsData = ((myCartData.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "CartchildProduct") as? NSArray)!
        
        vc.orderDate = ((myCartData.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "created_at") as! String)
        
        vc.product_id = String(describing:((self.myCartData.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "product_id"))!)
        
        
        if String(describing:((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as! NSDictionary)) == "<null>"{
            
            
        }else{
            
            if String(describing :(((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer"))!) == "<null>"{
                
                
            }else{
               
                if String(describing :((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount"))!) == "<null>"{
                    
                    vc.discountData = [:]
                    
                }else{
                    
                    vc.discountData = ((((myCartData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "productdescription") as? NSDictionary)?.value(forKey: "cartproductOffer") as? NSDictionary)?.value(forKey: "cartProductdiscountamount") as! NSDictionary)
                    
                }
                
            }

        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func cancel_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
    }
    
    @IBAction func save_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
        
        var parameters : [NSString: NSObject] = [:]
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
            
            parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                          "product_id" : self.product_idForRedeemOffer as NSObject,"voucher_id":self.voucher_id_forRedeemOffer as NSObject]
            
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("reedem_offer", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.alertWithHandler(message: (receivedData.value(forKey: "message") as? String)!, block: {
                        
                        self.overlay_View.isHidden = true
                        
                    })
                    
                    self.connection()
                    
                    self.redeem_offerCheck.removeAllObjects()
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
        
        
    }
    
    @objc func delete_product(sender:UIButton){
        
        var parameters : [NSString: NSObject] = [:]
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
            
            parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                          "product_id" : ((self.myCartData.object(at: sender.tag)as? NSDictionary)?.value(forKey: "product_id")as? Int)! as NSObject]
            
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("delete_parent_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    if  singleton.sharedInstance.cartCount != 0{
                        
                        singleton.sharedInstance.cartCount = singleton.sharedInstance.cartCount - 1
                        
                        self.setNavBar()
                    }
                    
                    self.connection()
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
        
    }
    
    func deleteParentProduct(){
        
        var parameters : [NSString: NSObject] = [:]
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
            
            parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                          "product_id" : self.deleteId as NSObject]
            
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("delete_parent_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    if  singleton.sharedInstance.cartCount != 0{
                        
                        singleton.sharedInstance.cartCount = singleton.sharedInstance.cartCount - 1
                        
                        self.setNavBar()
                    }
                    
                    self.connection()
                    
                }else{
                    
                    //  self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
                
            }else {
                
                //  self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    func alertWithHandler(message : String , block:  @escaping ()->Void ){
        
        let alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action : UIAlertAction) in
            
            block()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alert(message:String){
        
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rt_btn(){
        
        let btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
        
        let item = UIBarButtonItem.init(customView: btn)
        
        self.navigationItem.rightBarButtonItem = item
        
    }
    
}
