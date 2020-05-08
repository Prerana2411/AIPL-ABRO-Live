//
//  RecentlyViewedViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/8/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class RecentlyViewedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //MARK: Outlets
    
    @IBOutlet var recentlyViewed_TableView: UITableView!
    
    //MARK: Variables
    
    var myData:NSMutableArray = []
    
    //For Pagination
    
    var isDataLoading:Bool=false
    
    var pageNo:Int = 0
    
    var limit:Int = 16
    
    var offset:Int = 0 //pageNo*limit
    
    var didEndReached:Bool=false
    
    var upToLimit = 0
    
    //Webservice
    
    var conn = webservices()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Recently Viewed"
        
        fetch(offset: offset, limit: limit)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.myData.removeAllObjects()
    }
    
    //MARK:- ScrollView Delegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //  print("scrollViewDidEndDecelerating")
        
    }
    
    //Pagination
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((recentlyViewed_TableView.contentOffset.y + recentlyViewed_TableView.frame.size.height) >= recentlyViewed_TableView.contentSize.height)
        {
            
            isDataLoading = true
            
            self.pageNo = self.pageNo + 1
            
            offset = limit
            
            limit = limit + 16
            
            if !isDataLoading{
                
                if self.limit >= (upToLimit + 16) {
                    
                    
                }else if self.limit >= upToLimit && self.offset < upToLimit{
                    
                    fetch(offset: self.offset , limit: upToLimit )
                    
                }
                    
                else{
                    
                    fetch(offset: self.offset , limit: self.limit)
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: connection
    
    func fetch(offset: Int, limit: Int) {
        
        var parameters : [NSString: NSObject] = [:]
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                parameters = ["offset": offset as NSObject  , "id" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject , "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject ]
                
            }
            
        }else{
            
            parameters = ["offset": offset as NSObject]
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("recent_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as! Bool {
                    
                    if offset == 0 {
                        
                        //    let recData = NSKeyedArchiver.archivedData(withRootObject: ((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray))
                        //
                        //
                        //    print(recData.count)
                        
                        //UserDefaults.standard.set(recData, forKey: "Data")
                        
                        self.myData = []
                        
                    }
                    
                    self.upToLimit = (receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "count") as! Int
                    
                    print(self.upToLimit)
                    
                    for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                        
                        self.myData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                        
                    }
                    
                    if self.myData.count == 0 {
                        
                        self.recentlyViewed_TableView.isHidden = true
                        
                    } else {
                        
                        self.recentlyViewed_TableView.isHidden = false
                        
                        self.recentlyViewed_TableView.dataSource = self
                        
                        self.recentlyViewed_TableView.delegate = self
                        
                        self.recentlyViewed_TableView.reloadData()
                        
                        self.recentlyViewed_TableView.tableFooterView = UIView()
                        
                    }
                    
                }
                
            } else {
                
                // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                
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
    
    //MARK: Datasource delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return 10
        return self.myData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recentlyViewed_TableView.dequeueReusableCell(withIdentifier: "RecentlyViewedDetail_Identifier") as! RecentlyViewedDetailTableViewCell
        
        //fetch data
        
        if (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails")) is NSNull){
            
            
            
        }else{
    //name
        if (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value(forKey: "name") as? String) != nil{
            
            cell.productTitle_label.text = (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value(forKey: "name") as? String)!
            
        }
        
    //price new
            
       if ((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") ) is NSNull{
            
            
       }else{
        
        //image
        if (((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") ) is NSNull {
            
            cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
            
        }else{
            
            cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + (((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
        }
        
            cell.oldPrice_label.isHidden = true
            
            cell.oldPrice_height.constant = 0
            
            cell.cutView_View.isHidden = true
            
            cell.offerPrice_label.text = "Price : "
            
            cell.newPrice_label.text = "Rs. " + String(describing: ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value (forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
        
        
        if ((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer")  is NSNull{
        
            
        }else{
            
            //price
            if (((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer")  is NSNull{
                
            }else{
                
                if ((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type")  is NSNull{
            
          //call
            
                }else if ((((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 1 {
                        
         //multiply
                    
                    let price = (Float(((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!) - ( Float((((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(Float(((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!)) / 100 ))
                    
                    print(price)
                    
                    cell.newPrice_label.text = "Rs. " + String(describing: price) + "0"
                    
                    cell.oldPrice_label.isHidden = false
                    
                    cell.oldPrice_height.constant = 20
                    
                    cell.cutView_View.isHidden = false
                    
                    cell.offerPrice_label.text = "Offer Price : "
                    
                    cell.oldPrice_label.text = "Rs. " + String(describing: ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value (forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price"))!  )
                    
                   
                }else if ((((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type")as? Int)!) == 2{
          //minus
                    let price = Float((((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!) - (((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductoffer") as? NSDictionary)?.value(forKey: "RecentProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!)
                    
                    cell.newPrice_label.text = "Rs. " + String(describing: price)
                    
                    cell.newPrice_label.text = "Rs. " + String(describing: price)
                    
                    cell.oldPrice_label.isHidden = false
                    
                    cell.oldPrice_height.constant = 20
                    
                    cell.cutView_View.isHidden = false
                    
                    cell.offerPrice_label.text = "Offer Price : "
                    
                    cell.oldPrice_label.text = "Rs. " + String(describing: ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value (forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price"))!  )
               
                }else{
                
                
                }
           
            }
       
        }
        
            }
       
        }
        
        
//            cell.oldPrice_label.isHidden = false
//
//            cell.oldPrice_height.constant = 20
//
//            cell.cutView_View.isHidden = false
//
            //1
//            if ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value (forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int) != nil{
//
//                cell.offerPrice_label.text = "Price : "
//
//                cell.newPrice_label.text = "Rs. " + String(describing: ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "AllRecentProductDetails") as?  NSDictionary)?.value (forKey: "RecentProductPricing") as? NSDictionary)?.value(forKey: "price"))!  )
//
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = (((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "product_id") as? Int)!)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}
