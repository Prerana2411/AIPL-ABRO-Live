//
//  ComboOfferViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/28/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ComboOfferViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: outlets
  //1
    @IBOutlet var fullView_View: UIView!
    
    @IBOutlet var productImage_CollectionView: UICollectionView!
    
    @IBOutlet var image_PageControl: UIPageControl!
//2
    
    @IBOutlet var makeOrder_button: UIButton!
    
    @IBOutlet var descriptionOuterView_View: UIView!
    
    @IBOutlet var descriptionInnerView_View: UIView!
    
    @IBOutlet var offerName_label: UILabel!
    
    @IBOutlet var description_label: UILabel!
//3
    @IBOutlet var comboOffer_TableView: UITableView!
    
    @IBOutlet var comboOfferTable_height: NSLayoutConstraint!
    
//4
    @IBOutlet weak var freeProducts_label: UILabel!
    
    
    
    @IBOutlet var offerProduct_TableView: UITableView!
    
    @IBOutlet var offerProductTable_height: NSLayoutConstraint!
    
    
    //MARK: Variables
    
    
    var comboProductData : NSArray = []
    
    var comboFreeData : NSArray = []
    
    var comboId = String()
    
    var imageArray : NSArray = []
    
    var offerName = String()
    
    var offerDescription = String()
    
    var conn = webservices()
    
    var productID = Int()
    
    //////
    
    var child_productTotal : NSMutableArray = []
    
    var Product_id : NSMutableArray = []
    
    var Quantity : NSMutableArray = []
    
    var offerType : NSMutableArray = []
    
    var post_total : NSMutableArray = []
    
    var price : NSMutableArray = []
    
    var final_total = 0
    
    var discount : NSMutableArray = []
    
    var voucher_id : NSMutableArray = []
    
    var voucher_id_forRedeemOffer = ""
    
    var product_idForRedeemOffer = ""
    
    var after_discount_totalPrice : NSMutableArray = []
    

    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.image_PageControl.numberOfPages = imageArray.count
        
        makeOrder_button.layer.masksToBounds = true
        
        makeOrder_button.layer.cornerRadius = makeOrder_button.frame.height/2
///////
        fullView_View.layer.masksToBounds = true
        
        fullView_View.layer.cornerRadius = 8
        
        fullView_View.giveShadow(Outlet: fullView_View)
/////////
        descriptionOuterView_View.layer.masksToBounds = true
        
        descriptionOuterView_View.layer.cornerRadius = 8
        
        descriptionOuterView_View.giveShadow(Outlet: descriptionOuterView_View)
///////
        descriptionInnerView_View.layer.masksToBounds = true
        
        descriptionInnerView_View.layer.cornerRadius = 8
        
        descriptionInnerView_View.giveShadowinnerview(Outlet: descriptionInnerView_View)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Combo Offer"
        
        productImage_CollectionView.delegate = self
        
        productImage_CollectionView.dataSource = self
        
        productImage_CollectionView.delegate = self
        
        productImage_CollectionView.dataSource = self
        
        productImage_CollectionView.reloadData()
        
        self.connection()
        
        self.offerName_label.text = "Offer Name : " + offerName
        
        self.description_label.text = offerDescription
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        self.comboProductData = []
        
        self.comboFreeData = []
    }
    
    
    //MARK: Collection View Delegates DataSource
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        image_PageControl.currentPage = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
            return CGSize(width : productImage_CollectionView.frame.width  , height: productImage_CollectionView.frame.height )
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if imageArray.count == 0 {
            
            return 1
            
        }else{
            
            return imageArray.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if imageArray.count == 0 {
            
            let cell = productImage_CollectionView.dequeueReusableCell(withReuseIdentifier: "comboImage_Identifier", for: indexPath) as! ComboOfferCollectionViewCell
            
            return cell
            
            
        }else{
            
            let cell = productImage_CollectionView.dequeueReusableCell(withReuseIdentifier: "comboImage_Identifier", for: indexPath) as! ComboOfferCollectionViewCell
            
            if  (((imageArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  ((imageArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") ) is NSNull{
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith((NSURL(string : comboImage_url + ((imageArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
            }
            
            return cell
            
        }
        
    }
    
    
    //MARK: Table View Delegates DataSource

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == comboOffer_TableView{
            
            return comboProductData.count
            
        }else{
            
            return comboFreeData.count
            
        }
        
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == comboOffer_TableView{
       
            let cell = comboOffer_TableView.dequeueReusableCell(withIdentifier: "comboOffer_Identifier") as! ComboOfferTableViewCell
            
            cell.viewOffer_button.tag = indexPath.row
            
            cell.fullView_View.layer.masksToBounds = true
            
            cell.fullView_View.layer.cornerRadius = 8
            
            cell.fullView_View.giveShadow(Outlet: cell.fullView_View)
            
            cell.title_label.text = String(describing:((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
            
            if  String(describing:((((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image"))!) == "<null>" ||  ((((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull{
                
                cell.productimage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
                
            }else{
                
                cell.productimage_ImageView.setImageWith((NSURL(string : productImage_url + ((((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            if String(describing: ((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "comboProductPrice"))!) == "<null>"{
                
              //  self.offerProduct_TableView.isHidden = true
                
                cell.price_label.text = "N/A"
                
            }else{
                
             cell.price_label.text = "Rs. " + String(describing: (((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "price") )!) + ".00"
            
            ////////
            
            var val = Int()
            
            val = (((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "price") as? Int )!
            
            self.child_productTotal.add(val)
            
            print(self.child_productTotal)
            
            
            self.Product_id.add((((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "product_id") as? Int)!)
            
            //MARK: OfferType
            
            self.offerType.add("COMBO")
            
            self.discount.add(0)
            
            self.voucher_id.add(0)
            
            self.Quantity.add(1)
                
            self.final_total = val + final_total
             
                
            }
        
            return cell
            
            
        }else{
            
            let cell = offerProduct_TableView.dequeueReusableCell(withIdentifier: "offerProduct_Identifier") as! ComboOfferTableViewCell
            
            cell.freeViewOffer_button.tag = indexPath.row
            
            cell.freeFullView_View.layer.masksToBounds = true
            
            cell.freeFullView_View.layer.cornerRadius = 8
            
            cell.freeFullView_View.giveShadow(Outlet: cell.freeFullView_View)
            
            cell.freeTitle_label.text = (((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "name") as? String)!
            
            cell.freePrice_label.text = "Rs. " + String(describing: ((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "price") )! ) + ".00"

            
            if  ((((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey:"All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  (((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey:"All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull{
                
                cell.freeProductimage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.freeProductimage_ImageView.setImageWith((NSURL(string : productImage_url + (((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey:"All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
           
            self.Product_id.add(((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "product_id") as? Int)!)
            
            var price = ((((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "comboProductPrice") as? NSDictionary)?.value(forKey: "price") as? Int)!
                     
            
            self.offerType.add("COMBO")
            
            self.discount.add(0)
            
            self.voucher_id.add(0)
            
            self.Quantity.add(1)
            
            self.child_productTotal.add(price)
            
//            for i in 0..<child_productTotal.count{
//
//                self.final_total = (child_productTotal[i] as? Int)! + final_total
//
//            }
            
            return cell            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == comboOffer_TableView{

            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = ((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int )!
            
            self.productID = ((comboProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int )!
            
            vc.parentVC = "ComboOfferViewController"
            
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "id") as? Int)!
            
            self.productID = (((comboFreeData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "id") as? Int)!
            
            vc.parentVC = "ComboOfferViewController"
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    //MARK: connection for combo offer product
    
    func connection() {
        
        var parameters : [NSString: NSObject] = [:]
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type") != nil{
                
                parameters = ["combo_id": comboId as NSObject , "user_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject]
                
            }
            
        }else{
            
            parameters = ["combo_id": comboId as NSObject ]
            
        }
        
        //parameters = ["combo_id": comboId as NSObject , "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type") as? String)! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("comboofferproducts", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.comboProductData = (receivedData.value(forKey: "combobuyproduct") as? NSArray)!
                    
                    print(self.comboProductData)
                    
                    self.comboFreeData = (receivedData.value(forKey: "combofreeProduct") as? NSArray)!
                    
                    print(self.comboFreeData)
               ///////////
                    if self.comboProductData.count == 0 || String(describing : (self.comboProductData.object(at: 0))) == "<null>"{
                        
                        self.comboOfferTable_height.constant = 0
                        
                    }else{
                        
                        self.comboOfferTable_height.constant = CGFloat(108 * self.comboProductData.count)
                        
                        self.comboOffer_TableView.delegate = self
                        
                        self.comboOffer_TableView.dataSource = self
                        
                        self.comboOffer_TableView.tableFooterView = UIView()
                        
                        self.comboOffer_TableView.reloadData()
                        
                    }
                ///////////
                    if self.comboFreeData.count == 0{
                        
                        self.freeProducts_label.isHidden = true
                        
                        self.offerProductTable_height.constant = 0
                        
                    }else{
                        
                        self.freeProducts_label.isHidden = false
                        
                        self.offerProductTable_height.constant = CGFloat(108 * self.comboProductData.count)
                        
                        self.offerProduct_TableView.delegate = self
                        
                        self.offerProduct_TableView.dataSource = self
                        
                        self.offerProduct_TableView.tableFooterView = UIView()
                        
                        self.offerProduct_TableView.reloadData()
                       
                    }
                    ///////////
                }else{
                    
                    //
                    
                }
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
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
    
    //MARK: Action
    
    @IBAction func makeOrder_Button(_ sender: UIButton) {
        
        
        if self.comboProductData.count == 0 || String(describing : (self.comboProductData.object(at: 0))) == "<null>"{
            
            
        }else{
            
            var parameters : [NSString: NSObject] = [:]
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                if self.post_total.count != 0{
                    
                    parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                                  "product_id" : self.Product_id.componentsJoined(by: ",") as NSObject,
                                  "quantity":self.Quantity.componentsJoined(by: ",")as NSObject,
                                  "subtotal":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "discount":self.discount.componentsJoined(by: ",") as NSObject,
                                  "voucher_id":self.voucher_id.componentsJoined(by: ",") as NSObject,
                                  "total":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "final_total": self.final_total as NSObject ,
                                  "offertype" : self.offerType.componentsJoined(by: ",") as NSObject ]
                    
                }else{
                    
                    parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject  ,
                                  "product_id" : self.Product_id.componentsJoined(by: ",") as NSObject,
                                  "quantity":self.Quantity.componentsJoined(by: ",")as NSObject,
                                  "subtotal":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "discount":self.discount.componentsJoined(by: ",") as NSObject ,
                                  "voucher_id":self.voucher_id.componentsJoined(by: ",") as NSObject,
                                  "total":self.child_productTotal.componentsJoined(by: ",") as NSObject,
                                  "final_total": self.final_total as NSObject ,
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
                        
                        self.alert(message: receivedData.value(forKey: "message") as! String)
                        
                    }else{
                        
                        self.alert(message: receivedData.value(forKey: "message") as! String)
                        
                    }
                    
                    
                }else {
                    
                    self.alert(message: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
        }
        
    }
    
    
    @IBAction func comboViewAll_Button(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.parentVC = "ComboOfferViewController"
        
        vc.productId = ((comboProductData.object(at: (sender as AnyObject).tag) as? NSDictionary)?.value(forKey: "id") as? Int )!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func offerViewAll_Button(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.parentVC = "ComboOfferViewController"
        
        vc.productId = (((comboFreeData.object(at: (sender as AnyObject).tag) as? NSDictionary)?.value(forKey: "rewardProductdescription") as? NSDictionary)?.value(forKey: "id") as? Int)!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
