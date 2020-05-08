//
//  FeaturedProductDetailViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/8/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class FeaturedProductDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: Outlets
    
    @IBOutlet var featuredProduct_CollectionView: UICollectionView!
    
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
        
        self.title = "Featured Products"
        
        fetch(offset: offset, limit: limit)
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//
//        myData.removeAllObjects()
//
//    }
    
    //MARK:- ScrollView Delegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //  print("scrollViewDidEndDecelerating")
        
    }
    
    //Pagination
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((featuredProduct_CollectionView.contentOffset.y + featuredProduct_CollectionView.frame.size.height) >= featuredProduct_CollectionView.contentSize.height)
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
        
        self.conn.startConnectionWithSting("featured_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
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
    
                        self.featuredProduct_CollectionView.isHidden = true
    
                    } else {
    
                        self.featuredProduct_CollectionView.isHidden = false
                        
                        self.featuredProduct_CollectionView.dataSource = self
                        
                        self.featuredProduct_CollectionView.delegate = self
                        
                        self.featuredProduct_CollectionView.reloadData()
                        
                    }
                }
    
            } else {
   
                // self.alert(msg: receivedData.value(forKey: "Error") as! String)
   
            }

        }
    
    }
    
    
    //MARK: Datasource Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return 10

        return self.myData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*
        let cell = featuredProduct_CollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductDetail_Identifier", for: indexPath) as! FeaturedProductDetailCollectionViewCell
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 8
        
        cell.fullView_View.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.fullView_View.shadow(Outlet: cell.fullView_View)
        
        return cell
 */
        let cell = featuredProduct_CollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductDetail_Identifier", for: indexPath) as! FeaturedProductDetailCollectionViewCell
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 8
        
        cell.fullView_View.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.fullView_View.shadow(Outlet: cell.fullView_View)
        
        if String(describing:((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "video1"))!) == ""{
            
            cell.playImage_ImageView.isHidden = true
            
        }else{
            
            cell.playImage_ImageView.isHidden = false
            
        }
        
        if ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String) != nil{
            
            cell.productTitle_label.text = ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)
            
        }
        
        if (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary)?.value(forKey: "price") as? Int) == nil || String(describing:(((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary)?.value(forKey: "price"))) == "<null>" || (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary)?.value(forKey: "price")) is NSNull  {
            
             cell.price_label.text = "N/A"
           
        }else{
            
            cell.price_label.text = String(describing: (((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary)?.value(forKey: "price"))! ) + ".00"
            
        }
        
        if ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") ) is NSNull {
            
            cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
            
        }else{
            
            cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
        }
        
       /*
        if  (myData.).value(forKey: "image") as? String == "<null>" ||  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") is NSNull{
            
            cell.productImage_ImageView.image  = #imageLiteral(resourceName: "placeholder")
            
        }else{
            ///var/www/html/aipl_api/images/
            
           cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ( (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
        }
        
       */
        print(self.myData)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
            
            return CGSize(width : featuredProduct_CollectionView.frame.width/2 - 7.5 , height: featuredProduct_CollectionView.frame.height/2 - 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = ((myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
                
    
}
