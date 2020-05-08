//
//  BestSellingProductDetailViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/8/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class BestSellingProductDetailViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    //MARK: Outlets
    
    @IBOutlet var bestSellingProduct_CollectionView: UICollectionView!
    
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
        
        bestSellingProduct_CollectionView.dataSource = self
        
        bestSellingProduct_CollectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Best Selling Products"
        
        fetch(offset: offset, limit: limit)
        
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
        
        if ((bestSellingProduct_CollectionView.contentOffset.y + bestSellingProduct_CollectionView.frame.size.height) >= bestSellingProduct_CollectionView.contentSize.height)
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
        
        parameters = ["offset": offset as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("selling_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as! Int == 1 {
                    
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
                        
                        self.bestSellingProduct_CollectionView.isHidden = true
                        
                        
                    } else {
                        
                        self.bestSellingProduct_CollectionView.isHidden = false
                        
                    }
                    
                    self.bestSellingProduct_CollectionView.reloadData()
                    
                }
                
            } else {
                
                // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    
    //MARK: Datasource Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       //return 10
        return self.myData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = bestSellingProduct_CollectionView.dequeueReusableCell(withReuseIdentifier: "BestSellingProductDetail_Identifier", for: indexPath) as! BestSellingProductDetailCollectionViewCell
        
        cell.cart_ImageView.image = cell.cart_ImageView.image!.withRenderingMode(.alwaysTemplate)
        
        cell.cart_ImageView.tintColor = UIColor.lightGray
        
        cell.addToCart_Button.tag = indexPath.row
        
        cell.addToCart_Button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        cell.addToCart_Button.border(Outlet: cell.addToCart_Button)
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 8
        
        cell.fullView_View.shadow(Outlet: cell.fullView_View)
        
        if String(describing:((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "video1"))!) == ""{
            
            cell.playImage_ImageView.isHidden = true
            
        }else{
            
            cell.playImage_ImageView.isHidden = false
            
        }
        
        if ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "SellingCartProductDetails")) is NSNull || ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "SellingCartProductDetails") as? String) == "<null>" {
            
            cell.addToCart_Button.setTitle("Add to cart", for: .normal)
            
            cell.addToCart_Button.backgroundColor = UIColor.white
            
            cell.addToCart_Button.setTitleColor(UIColor.darkGray, for: .normal)
            
            cell.cart_ImageView.image = #imageLiteral(resourceName: "cartw")
            
            cell.cart_ImageView.image = cell.cart_ImageView.image!.withRenderingMode(.alwaysTemplate)
            
            cell.cart_ImageView.tintColor = UIColor.darkGray
            
        }else{
            
            cell.addToCart_Button.setTitle("Added", for: .normal)
            
            cell.addToCart_Button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
            
            cell.addToCart_Button.setTitleColor(UIColor.white, for: .normal)
            
            cell.cart_ImageView.image = #imageLiteral(resourceName: "redtick")
            
            cell.cart_ImageView.image = cell.cart_ImageView.image!.withRenderingMode(.alwaysTemplate)
            
            cell.cart_ImageView.tintColor = UIColor.white
            
            
        }
        
        if ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String) != nil{
            
            cell.productTitle_label.text = ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)
            
        }
        
        if (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductDetails") as? NSDictionary)?.value(forKey: "price") as? Int) != nil{
            
            cell.productPrice_label.text = "Rs. " + String(describing: (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductDetails") as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
            
        }
   /////image
        if ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey : "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey : "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") ) is NSNull {
            
            cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
            
        }else{
            
            cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey : "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
        }
        
        return cell
        
    }
    
    @objc func addToCartAction(sender:UIButton){
        
        if UserDefaults.standard.bool(forKey: "Login_Status"){
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.myData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            alert(message: "Please login to add product to cart")
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
            return CGSize(width : bestSellingProduct_CollectionView.frame.width/2 - 7.5 , height: bestSellingProduct_CollectionView.frame.height/2 - 52)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: alert
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}


