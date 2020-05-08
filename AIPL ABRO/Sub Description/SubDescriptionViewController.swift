//
//  SubDescriptionViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 10/03/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

import AVKit

import AVFoundation


class SubDescriptionViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource{
    
    //MARK: Outlets
    
    @IBOutlet weak var mainProduct_ImageView: UIView!
    
    //// 1
    @IBOutlet var productImage_CollectionView: UICollectionView!
    
    @IBOutlet var productTitle_label: UILabel!
    
    @IBOutlet weak var offerPrice_label: UILabel!
    
    @IBOutlet var productNewPrice_label: UILabel!
    
    @IBOutlet var productOldPrice_label: UILabel!
    
    @IBOutlet weak var cutView_View: UIView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var pageControl_height: NSLayoutConstraint!
    
    //// 2
    
    @IBOutlet var descriptionOuter_View: UIView!
    
    @IBOutlet var descriptionInner_View: UIView!
    
    @IBOutlet var descriptionText_label: UILabel!
    
    //// 3
    
    @IBOutlet weak var productVideo_View: UIView!
    
    @IBOutlet weak var productVideoView_height: NSLayoutConstraint!
    
    
    @IBOutlet weak var productVideo_CollectionView: UICollectionView!
    
    @IBOutlet weak var video_pageControl: UIPageControl!
    
    @IBOutlet weak var videoPageControl_height: NSLayoutConstraint!
    
    @IBOutlet weak var noVideo_label: UILabel!
    
    @IBOutlet weak var videoCollectionView_height: NSLayoutConstraint!
    
    //// 4
    
    @IBOutlet var featureOuter_View: UIView!
    
    @IBOutlet var featureInner_View: UIView!
    
    @IBOutlet var featureTableView_TableView: UITableView!
    
    @IBOutlet weak var featureTableView_height: NSLayoutConstraint!
    
    //// 5
    
    @IBOutlet var applicationOuter_View: UIView!
    
    @IBOutlet var applicationInner_View: UIView!
    
    @IBOutlet var applicationTableView_TableView: UITableView!
    
    @IBOutlet weak var applicationTableView_height: NSLayoutConstraint!
    
    
    //MARK: Variables
    
    var pack_id = ""
    
    var player:AVPlayer?
    
    var playerController = AVPlayerViewController()
    
    var NewMediaArray = ["https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                         "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                         ]
    
    var productId = Int()
    
    var id = String()
    
    var myData : NSDictionary = [:]
    
    var featured_data : NSArray = []
    
    var application_data : NSArray = []
    
    var pricee = ""
    
    var newPricee = ""

    var priceee = NSMutableArray()
    
    var newPriceee = NSMutableArray()
    
    var indexx = Int()
    
    @IBOutlet weak var fullScroll_ScrollView: UIScrollView!
    
    
    //Webservice
    
    var conn = webservices()
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.id = ""
        
        self.productId = 0
        
        myData = [:]
        
        featured_data  = []
        
        application_data = []
        
        pricee = ""
        
        newPricee = ""
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fullScroll_ScrollView.isHidden = true
        
        mainProduct_ImageView.layer.masksToBounds = true
        
        mainProduct_ImageView.layer.cornerRadius = 6
        
        self.giveShadow()
        
        print(productId)
        
        if newPriceee.object(at: indexx) as! String == "" {
            
            self.offerPrice_label.text = "Price : "
            
            self.productOldPrice_label.isHidden = true
            
            self.cutView_View.isHidden = true
            
            self.productNewPrice_label.text = "Rs." + String(describing:(priceee.object(at: indexx)) )
            
        }else{
            
            self.offerPrice_label.text = "Offer Price : "
            
            self.productOldPrice_label.isHidden = false
            
            self.cutView_View.isHidden = false
            
            self.productNewPrice_label.text =  "Rs. " + String(describing:(newPriceee.object(at: indexx)))
            
            self.productOldPrice_label.text =  "Rs." + String(describing:(priceee.object(at: indexx)))
            
        }

        
//        if newPricee == ""{
//
//            self.offerPrice_label.text = "Price : "
//
//            self.productOldPrice_label.isHidden = true
//
//            self.cutView_View.isHidden = true
//
//            self.productNewPrice_label.text = pricee
//
//        }else{
//
//            self.offerPrice_label.text = "Offer Price : "
//
//            self.productOldPrice_label.isHidden = false
//
//            self.cutView_View.isHidden = false
//
//            self.productNewPrice_label.text = newPricee
//
//            self.productOldPrice_label.text = pricee
//
//        }
        noVideo_label.isHidden = false
        
        productVideo_CollectionView.isHidden = true
        
        videoCollectionView_height.constant = 30
        
        video_pageControl.isHidden = true
        
        videoPageControl_height.constant = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.title = "Detail"
        
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                self.connection()
                
            }
            
           
            
        }
         self.connectionForProductDetail()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.myData = [:]
        
        self.featured_data = []
        
        self.application_data = []
        
    }
    
    //MARK: Functions
    
    func giveShadow(){
        //////
        descriptionOuter_View.layer.masksToBounds = true
        
        descriptionOuter_View.layer.cornerRadius = 8
        
        descriptionOuter_View.giveShadow(Outlet: descriptionOuter_View)
        
        descriptionInner_View.layer.masksToBounds = true
        
        descriptionInner_View.layer.cornerRadius = 8
        
        descriptionInner_View.giveShadowinnerview(Outlet: descriptionInner_View)
       
        //////
        productVideo_View.layer.masksToBounds = true
        
        productVideo_View.layer.cornerRadius = 8
        
        productVideo_View.giveShadow(Outlet:  productVideo_View)
        //////
        featureOuter_View.layer.masksToBounds = true
        
        featureOuter_View.layer.cornerRadius = 8
        
        featureOuter_View.giveShadow(Outlet: featureOuter_View)
        
        featureInner_View.layer.masksToBounds = true
        
        featureInner_View.layer.cornerRadius = 8
        
        featureInner_View.giveShadowinnerview(Outlet: featureInner_View)
        //////
        applicationOuter_View.layer.masksToBounds = true
        
        applicationOuter_View.layer.cornerRadius = 8
        
        applicationOuter_View.giveShadow(Outlet: applicationOuter_View)
        
        applicationInner_View.layer.masksToBounds = true
        
        applicationInner_View.layer.cornerRadius = 8
        
        applicationInner_View.giveShadowinnerview(Outlet: applicationInner_View)
        
    }
    
    //MARK: connection
    
    //add recent product service
    func connection() {
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["product_id": productId as NSObject , "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("add_recent_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: connection1
    
    //particular product detail service
    
    func connectionForProductDetail() {
        
        var parameters : [NSString: NSObject] = [:]
        
      
        parameters = ["id": productId as NSObject ]
        
        print(parameters)
       
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("particularchildProductDeatils", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as? Int == 1 {
                    
                    self.fullScroll_ScrollView.isHidden = false
                    
                    self.myData = receivedData
                    
                    if ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails")) is NSNull{
                        
                        
                    }else{
                        
                        self.featured_data = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey:"particularProductfeatured") as? NSArray)!
                        
                        if self.featured_data.count == 0{
                            
                            
                        }else{
                            
                            self.featureTableView_TableView.delegate = self
                            
                            self.featureTableView_TableView.dataSource = self
 
                            self.featureTableView_TableView.reloadData()
                            
                            self.featureTableView_height.constant = self.featureTableView_TableView.contentSize.height
                        }
                        ///////
                        self.application_data = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey:"particularProductApplications")as? NSArray)!
                        
                        if self.application_data.count == 0{
                            
                            
                        }else{
                            
                            self.applicationTableView_TableView.delegate = self
                            
                            self.applicationTableView_TableView.dataSource = self
  
                            self.applicationTableView_TableView.reloadData()
                            
                            self.applicationTableView_height.constant = self.applicationTableView_TableView.contentSize.height
                        }
                        
                        self.fetch()
                        
                    }
                    
                    
                    
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: fetch
    
    func fetch(){
        //1
        if ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails")) is NSNull{
            
            
        }else{
            
            if (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "Particular_All_images") as? NSArray)!.count == 0{
                
                
            }else{
                
                if ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "name") is NSNull{
                    
                }else{
                    
                    self.productTitle_label.text = String(describing:(((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "name"))! )
                    
                }
                //
//                if (myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") is NSNull{
//
//                    if ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")is NSNull) {
//
//                    }else{
//
//                        self.productNewPrice_label.text = "Rs." + String(describing:(((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price"))!)  + ".00"
//                    }
//
//                    self.offerPrice_label.text = "Price"
//
//                    self.productOldPrice_label.isHidden = true
//
//                    self.cutView_View.isHidden = true
//
//                }
                
                self.descriptionText_label.text = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "description") as? String)!
                
                ////////
                self.productImage_CollectionView.delegate = self
                
                self.productImage_CollectionView.dataSource = self
                
                self.pageControl.numberOfPages = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "Particular_All_images") as? NSArray)!.count
                
              //  self.video_pageControl.numberOfPages = (self.myData.value(forKey: "all_videos") as! NSArray).count
                
            }
            
        }
        
        if (self.myData.value(forKey: "all_videos") as! NSArray).count == 0  {
            
            noVideo_label.isHidden = false
            
            productVideo_CollectionView.isHidden = true
            
            videoCollectionView_height.constant = 30
            
            video_pageControl.isHidden = true
            
            videoPageControl_height.constant = 0
            
        }else{
            
            noVideo_label.isHidden = true
            
            productVideo_CollectionView.isHidden = false
            
            videoCollectionView_height.constant = 75
            
            video_pageControl.isHidden = false
            
            videoPageControl_height.constant = 18
            
            self.productVideo_CollectionView.delegate = self
            
            self.productVideo_CollectionView.dataSource = self
            
            
            self.video_pageControl.numberOfPages = (self.myData.value(forKey: "all_videos") as! NSArray).count
            
        }
        
        
       
    
    }

    
    //MARK: Alert Function
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if collectionView == productImage_CollectionView{
            
            return CGSize(width : productImage_CollectionView.frame.width  , height: productImage_CollectionView.frame.height )
            
        }else{
            
            return CGSize(width : productVideo_CollectionView.frame.width  , height: productVideo_CollectionView.frame.height )
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == productImage_CollectionView{
            
            
            return ((((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "Particular_All_images") as? NSArray)!.count)
            
        }else{
            
            return ((self.myData.value(forKey: "all_videos") as? NSArray)!.count)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productImage_CollectionView{
            
            let cell = productImage_CollectionView.dequeueReusableCell(withReuseIdentifier: "SubDescriptionCollectionViewCell", for: indexPath) as! SubDescriptionCollectionViewCell
            
            if  ((((((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "Particular_All_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>"{
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith((NSURL(string : productImage_url + (((((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"Childproductdetails") as? NSDictionary)?.value(forKey: "Particular_All_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            return cell
            
        }else{
            
            
            let cell = productVideo_CollectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            
            
            let fileURL = URL(string: (((self.myData.value(forKey: "all_videos") as? NSArray)?.object(at :indexPath.row ) as? NSDictionary)?.value(forKey: "video") as? String)!)
            
            print(fileURL!)
            
            cell.thumbnail_ImageView.image = #imageLiteral(resourceName: "placeholder1")
           
            return cell
            
         
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == productImage_CollectionView{
            
            
        }else{
            
            UIApplication.shared.open(URL(string: (((self.myData.value(forKey: "all_videos") as? NSArray)?.object(at :indexPath.row ) as? NSDictionary)?.value(forKey: "video") as? String)!)!, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: { (_) in})
            

        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == productImage_CollectionView{
            
            pageControl.currentPage = indexPath.row
            
        }else{
            
            video_pageControl.currentPage = indexPath.row
            
        }
        
    }
    

    //MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == featureTableView_TableView{
            
            return featured_data.count
            
        }else{
            
            return application_data.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == featureTableView_TableView{
            
            let cell = featureTableView_TableView.dequeueReusableCell(withIdentifier: "SubDescriptionTableViewCell") as! SubDescriptionTableViewCell
            
            cell.featured_descLbl.text = (self.featured_data.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "name") as? String
            
            return cell
            
        }else{
            
            let cell = applicationTableView_TableView.dequeueReusableCell(withIdentifier: "SubDescriptionTableViewCell") as! SubDescriptionTableViewCell
            
            cell.appli_descLbl.text = ((self.application_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")as? String)!
            
            return cell
            
        }
        
    }
    

  

}
