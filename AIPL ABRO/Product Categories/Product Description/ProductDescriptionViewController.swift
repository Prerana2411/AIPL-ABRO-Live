//
//  ProductDescriptionViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 25/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

import AVKit

import AVFoundation

import HCSStarRatingView

class ProductDescriptionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource,TotalPrice {
    
    //MARK: Outlets
    
    @IBOutlet weak var mainProduct_ImageView: UIView!
    
    //// 1
    @IBOutlet var products_CollectionView: UICollectionView!
    
    @IBOutlet var productTitle_label: UILabel!
    
    @IBOutlet weak var offerPrice_label: UILabel!
    
    @IBOutlet var productNewPrice_label: UILabel!
    
    @IBOutlet var productOldPrice_label: UILabel!
    
    @IBOutlet weak var cutView_View: UIView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var pageControl_height: NSLayoutConstraint!
    
    //// 2
    
    @IBOutlet weak var viewOfferButton_height: NSLayoutConstraint!
    
    @IBOutlet var viewOfferCutView_View: UIView!
    
    
    @IBOutlet weak var productOfferView_View: UIView!
    
    @IBOutlet weak var productOfferView_height: NSLayoutConstraint!
    
    @IBOutlet weak var voucher_label: UILabel!
    
    @IBOutlet var validTill_label: UILabel!
    
    
    //// 3
    
    @IBOutlet weak var viewOffer_button: UIButton!
    
    @IBOutlet var descriptionOuter_View: UIView!
    
    @IBOutlet var descriptionInner_View: UIView!
    
    @IBOutlet var descriptionText_label: UILabel!
    
    //// 4
    
    @IBOutlet var saleOuter_View: UIView!
    
    @IBOutlet var saleInner_View: UIView!
    
    @IBOutlet weak var saleInnerView_height: NSLayoutConstraint!
    
    @IBOutlet weak var sizeParent_TableView: UITableView!
    
    @IBOutlet weak var parentTable_height: NSLayoutConstraint!
    
    @IBOutlet weak var totalPriceHeading_label: UILabel!
    
    
    @IBOutlet weak var totalPrice_Label: UILabel!
    
    @IBOutlet weak var addToCart_button: UIButton!
    
    @IBOutlet weak var sample_btn: UIButton!
    //// 5
    
    @IBOutlet weak var productVideo_View: UIView!
    
    @IBOutlet weak var productVideoView_height: NSLayoutConstraint!
    
    @IBOutlet weak var productVideoHeading_label: NSLayoutConstraint! //25
    
    
    @IBOutlet weak var productVideo_CollectionView: UICollectionView!
    
    @IBOutlet weak var video_pageControl: UIPageControl!
    
    @IBOutlet weak var videoPageControl_height: NSLayoutConstraint!
    
    @IBOutlet weak var noVideo_label: UILabel!
    
    @IBOutlet weak var videoCollectionView_height: NSLayoutConstraint!
    
    //// 6
    
    @IBOutlet var featureOuter_View: UIView!
    
    @IBOutlet var featureInner_View: UIView!
    
    @IBOutlet var featureTableView_TableView: UITableView!
    
    @IBOutlet weak var featureTableView_height: NSLayoutConstraint!
    
    //// 7
    
    @IBOutlet var applicationOuter_View: UIView!
    
    @IBOutlet var applicationInner_View: UIView!
    
    @IBOutlet var applicationTableView_TableView: UITableView!
    
    @IBOutlet weak var applicationTableView_height: NSLayoutConstraint!
    
    ///
    
    @IBOutlet weak var noreview_View: UIView!
    
    @IBOutlet weak var review_TableView: UITableView!
    
    @IBOutlet weak var reviewTableView_height: NSLayoutConstraint!
    
    ///overlay
    
    @IBOutlet weak var overlay_View: UIView!
    
    @IBOutlet weak var overlayChild_View: UIView!
    
    @IBOutlet weak var quantity_textField: UITextField!
    
    
    @IBOutlet weak var fullScroll_ScrollView: UIScrollView!
    
    //MARK: Variables
    
    var pack_id = ""
    
    var pack_Id : Int =  0
    
    var productDetailId = String() //from multiple vc
    
    var player:AVPlayer?
    
    var playerController = AVPlayerViewController()
    
    var Integer = Int()
    
    var reviews_data : NSArray = []
    
    var NewMediaArray = ["https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                         "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                         ]
    
    var productId = Int() //from multiple vc & used for 3 services
    
    var parentVC = ""
    
    var myData : NSDictionary = [:]
    
    var imageData : NSDictionary = [:]
    
    var featured_data : NSArray = []
    
    var application_data : NSArray = []
    
    var sizePackaging_data : NSArray = []
    
    var cart_data : NSArray = []
    
    var sampleCart_data : NSArray = []
    
    var quantity = ""
    
    var detail : NSDictionary = [:]
    
    var rewardOrDiscount = ""
    
    var tableTag = Int()
    
    
    //for subdesc
    
    var pricee = ""
    
    var newPricee = ""
    
    
    //Webservice
    
    var conn = webservices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.fullScroll_ScrollView.isHidden = true
        
        self.totalPrice_Label.text = "00.00"
        
        mainProduct_ImageView.layer.masksToBounds = true
        
        mainProduct_ImageView.layer.cornerRadius = 6
        
        voucher_label.layer.cornerRadius = voucher_label.frame.height/2
        
        voucher_label.layer.masksToBounds = true
        
        review_TableView.tableFooterView = UIView()
        
        self.giveShadow()
        
        print(productId)
        
        reviewTableView_height.constant = 40
        
        review_TableView.isHidden = true
        
        self.sizeParent_TableView.delegate = self
        
        self.sizeParent_TableView.dataSource = self
        
        addToCart_button.layer.masksToBounds = true
        
        addToCart_button.layer.cornerRadius = addToCart_button.frame.height/2
        
        sample_btn.layer.masksToBounds = true
        
        sample_btn.layer.cornerRadius = sample_btn.frame.height/2
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "readMore"), object: nil, queue: nil) { (notification:Notification) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubDescriptionViewController") as! SubDescriptionViewController
            
            vc.productId = notification.userInfo?["id"] as! Int
            
            vc.priceee = notification.userInfo?["oldPrice"] as! NSMutableArray
            
            vc.newPriceee = notification.userInfo?["newPrice"] as! NSMutableArray
            
            vc.indexx = notification.userInfo?["index"] as! Int
                  
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Product Detail"
        
        UserDefaults.standard.set(true, forKey: "hardwareHeading")
 //
    //    self.quantity_textField.text = "0"
 //
        self.connectionForReviews()
        
        singleton.sharedInstance.addToCart = false
       
        if singleton.sharedInstance.addToCart == false{
            
            self.totalPrice_Label.isHidden = true
            
            self.totalPriceHeading_label.isHidden = true
            
        }else{
            
            self.totalPrice_Label.isHidden = false
            
            self.totalPriceHeading_label.isHidden = false
        }
        //self.connection()
        if parentVC == "ComboOfferViewController"{
            
            
            self.viewOffer_button.isHidden = true
            
            self.viewOfferButton_height.constant = 0
            
            self.viewOfferCutView_View.isHidden = true
            
            self.sizeParent_TableView.tableFooterView = UIView()
            
            self.connectionForComboDetail()
            
            self.productOfferView_View.isHidden = true
            
            self.productOfferView_height.constant = 0
            
        }else{
            
            self.viewOffer_button.isHidden = false
            
            self.viewOfferButton_height.constant = 18
            
            self.productOfferView_View.isHidden = false
            
            self.productOfferView_height.constant = 148
            
            self.connectionForProductDetail()
            
        }
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                self.connection()
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.myData = [:]
        
        self.imageData = [:]
        
        self.featured_data = []
        
        self.application_data = []
        
        self.sizePackaging_data = []
        
        self.detail = [:]
        
        singleton.sharedInstance.total_price.removeAllObjects()
        
       // self.productId = 0
        
    }
    
    //MARK: touch function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch = touches.first!
        
        if touch.view != overlayChild_View {
            
            self.overlay_View.isHidden = true
            
        }
        
    }
    
    //MARK: ViewOffer Action
    
    @IBAction func viewOffer_Button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewOfferViewController") as! ViewOfferViewController
        
        vc.offerDetail = detail
        
        vc.rewardOrDiscount = self.rewardOrDiscount
        
        self.navigationController?.pushViewController(vc, animated: false)
        
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
        saleOuter_View.layer.masksToBounds = true
        
        saleOuter_View.layer.cornerRadius = 8
        
        saleOuter_View.giveShadow(Outlet: saleOuter_View)
        
        saleInner_View.layer.masksToBounds = true
        
        saleInner_View.layer.cornerRadius = 8
        
        saleInner_View.giveShadowinnerview(Outlet:  saleInner_View)
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
        ////
        noreview_View.layer.masksToBounds = true
        
        noreview_View.layer.cornerRadius = 8
        
        noreview_View.giveShadowinnerview(Outlet: noreview_View)
        
        review_TableView.layer.masksToBounds = true
        
        review_TableView.layer.cornerRadius = 15
        
        review_TableView.giveShadow(Outlet:  review_TableView)
        
        self.overlay_View.layer.cornerRadius = 8
        
        self.overlay_View.layer.masksToBounds = true
        
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
                
//                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: connection1
    
    //particular product detail service
    
    func connectionForProductDetail() {
        
        var parameters : [NSString: NSObject] = [:]
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                parameters = ["id": productId as NSObject ,
                              "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject,
                              "user_id" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id")!) as! NSObject  ]
                
                print(parameters)
                
            }
            
        }else{
            
            parameters = ["id": productId as NSObject ]
            
            print(parameters)
            
        }
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("particular_Product_Details", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as! Bool == true {
                    
                    self.fullScroll_ScrollView.isHidden = false
                    
                    self.myData = receivedData
                    
                    if self.myData.value(forKey: "data") is NSNull{
                        
                        
                    }else{
                        
                        self.imageData = (self.myData.value(forKey: "data") as? NSDictionary)!
                        
                    }
                    
                    
                    ///////
                    self.featured_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularProductfeatured")as? NSArray)!
                    
                    if ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartid")) is NSNull || String(describing:((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartid"))! ) == "<null>"{
                        
                        //       if self.myData.value(forKey: "particularProductcartid") is NSNull{
                        
                    }else{
                        
                        self.cart_data = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartid") as? NSDictionary)?.value(forKey: "ParticularCartProductcartpacks")as? NSArray)!
                    }
                    
                    if ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartidSample")) is NSNull || String(describing:((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartidSample"))! ) == "<null>"{
                        
                        //       if self.myData.value(forKey: "particularProductcartid") is NSNull{
                        
                    }else{
                        
                        self.sampleCart_data = (((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey: "particularProductcartidSample") as? NSDictionary)?.value(forKey: "ParticularCartProductcartpacksSample")as? NSArray)!
                    }
                    
                    if self.featured_data.count == 0{
                        
                        
                    }else{
                        
                        self.featureTableView_TableView.delegate = self
                        
                        self.featureTableView_TableView.dataSource = self
                        
                        self.featureTableView_TableView.reloadData()
                        
                      //  self.featureTableView_TableView.rowHeight = UITableViewAutomaticDimension
                        
                        self.featureTableView_height.constant = self.featureTableView_TableView.contentSize.height
                        
                    }
                    ///////
                    self.application_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularProductApplications")as? NSArray)!
                    
                    if self.application_data.count == 0{
                        
                        
                    }else{
                        
                        self.applicationTableView_TableView.delegate = self
                        
                        self.applicationTableView_TableView.dataSource = self
                        
                        self.applicationTableView_TableView.reloadData()
                        
                        self.applicationTableView_height.constant = self.applicationTableView_TableView.contentSize.height
                    }
                    ///////
                    
                    
                    self.sizePackaging_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularSizeAndPackaging")as? NSArray)!
                    
                    if self.sizePackaging_data.count == 0{
                        
                        
                    }else{
                        
                        //                        self.sizeParent_TableView.delegate = self
                        //
                        //                        self.sizeParent_TableView.dataSource = self
                        
//                        if #available(iOS 10.0, *) {
//
//                            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
//
//                                self.sizeParent_TableView.reloadData()
//
//                            })
//                        } else {
//
//                            self.sizeParent_TableView.reloadData()
//
//                        }
                        
                        singleton.sharedInstance.quantity.removeAllObjects()
                        
                        singleton.sharedInstance.total_price.removeAllObjects()
                        
                        for _ in 0..<self.sizePackaging_data.count{
                            
                            singleton.sharedInstance.quantity.add(0)
                            
                            singleton.sharedInstance.total_price.add(0)
                        }
                        
                        self.sizeParent_TableView.reloadData()
                        
                    }
                    
                    self.fetch()
                    
                 
                    //self.featureTableView_TableView.rowHeight * CGFloat(self.featured_data.count)
                    
                    
                        //self.featureTableView_TableView.rowHeight * CGFloat(self.application_data.count)
                    
                    
                    
                    print (self.myData)
                    
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
        if self.imageData.count == 0{
            
            
        }else{
            
            if (self.imageData.value(forKey: "Particular_All_images") as? NSArray)!.count == 0{
                
                
            }else{
                
                //
                self.products_CollectionView.delegate = self
                
                self.products_CollectionView.dataSource = self
                
                self.pageControl.numberOfPages = (self.imageData.value(forKey: "Particular_All_images") as? NSArray)!.count
                
                
            }
            
        }

        //
        if self.myData.value(forKey: "all_videos")  is NSNull || (self.myData.value(forKey: "all_videos") as! NSArray).count == 0  {
            
//            noVideo_label.isHidden = false
//
//            productVideo_CollectionView.isHidden = true
//
//            videoCollectionView_height.constant = 75
//
//            video_pageControl.isHidden = true
//
//            // videoPageControl_top.constant = 100
//
//            videoPageControl_height.constant = 0
            
            self.productVideoView_height.constant = 0
            
            self.productVideo_View.isHidden = true
            
        }else{
            
            if parentVC == "ComboOfferViewController"{
                
                noVideo_label.isHidden = true
                
                self.productVideo_CollectionView.delegate = self
                
                self.productVideo_CollectionView.dataSource = self
                
                self.productVideoView_height.constant = 285
                
                self.productVideo_View.isHidden = false
                
             //   self.pageControl.numberOfPages = (self.imageData.value(forKey: "Particular_All_images") as! NSArray).count
                
                self.video_pageControl.numberOfPages = (self.myData.value(forKey: "all_videos") as! NSArray).count
                
            }else{
                
                noVideo_label.isHidden = true
                
                self.productVideo_CollectionView.delegate = self
                
                self.productVideo_CollectionView.dataSource = self
                
                self.productVideoView_height.constant = 285
                
                self.productVideo_View.isHidden = false
                
                //self.pageControl.numberOfPages = (self.imageData.value(forKey: "Particular_All_images") as! NSArray).count
                
                self.video_pageControl.numberOfPages = (self.myData.value(forKey: "all_videos") as! NSArray).count
                
            }
            
            //
            
            
        }
        //2
        if myData.value(forKey: "data") is NSNull{
            
        }else{
                
                if parentVC == "ComboOfferViewController"{
                    
                    
                    
                    
                }else{
                    
                    if (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") is NSNull) || (String(describing: ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer"))!) == "<null>")) && (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") is NSNull) || (String(describing: ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!) == "<null>")){
                        
                        self.viewOffer_button.isHidden = true
                        
                        self.viewOfferButton_height.constant = 0
                        
                        self.productOfferView_View.isHidden = true
                        
                        self.productOfferView_height.constant = 0
                        
                        self.viewOfferCutView_View.isHidden = true
                        
                        
                    }
                    
                    if (myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") is NSNull || String(describing: ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer"))!) == "<null>"{
                        
                    
                    }else{
                        
                        self.viewOffer_button.isHidden = false
                        
                        self.viewOfferButton_height.constant = 18
                        
                        self.productOfferView_View.isHidden = false
                        
                        self.productOfferView_height.constant = 148
                        
                        self.voucher_label.text = String(describing: (
                            (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") as? NSDictionary)?.value(forKey: "particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "code"))!)
                        
                        self.validTill_label.text = "Valid till " + String(describing: (
                            (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") as? NSDictionary)?.value(forKey: "particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "expiry_date"))!)
                        
                        if (myData.value(forKey: "particularProductoffer") as? NSDictionary)?.count == 0{
                            
                            
                            
                        }else{
                            
                            self.detail = (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") as? NSDictionary)?.value(forKey: "particularProductdiscountoffer") as? NSDictionary)!
                            
                            self.rewardOrDiscount = "Discount"
                            
                        }
                        
                        
                        
                        ////
                        if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).count != 0 {
                            
                            if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "name") as? String) != nil{
                                
                                self.validTill_label.text = "Valid till " + String(describing: (
                                    (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") as? NSDictionary)?.value(forKey: "particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "expiry_date"))!) + " | Offer only for" + (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)?.value(forKey: "name") as? String)!
                                
                            }
                            
                        }
                        
                    }
      //////////////////////////
                    if (myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") is NSNull || String(describing: ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere"))!) == "<null>"{
                        
                        
                    }else{
                        
                        if parentVC == "ComboOfferViewController"{
                            
                            
                            
                            
                        }else{
                            
                            self.viewOffer_button.isHidden = false
                            
                            self.viewOfferButton_height.constant = 18
                            
                            self.productOfferView_View.isHidden = false
                            
                            self.productOfferView_height.constant = 148
                            
                            self.voucher_label.text = String(describing: ((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") as? NSDictionary)?.value(forKey: "Productrewardofferdetaile") as? NSDictionary)?.value(forKey: "code"))!)
                            
                            self.validTill_label.text = "Valid till " + String(describing: ((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") as? NSDictionary)?.value(forKey: "Productrewardofferdetaile") as? NSDictionary)?.value(forKey: "expiry_date"))!)
                            
                            if (myData.value(forKey: "Productrewardoffere") as? NSDictionary)?.count == 0{
                                
                                
                                
                            }else{
                                
                                self.detail = (((self.myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") as? NSDictionary)?.value(forKey: "Productrewardofferdetaile") as? NSDictionary)!
                                
                                self.rewardOrDiscount = "Reward"
                                
                            }
                            
                            
                            
                            ////
                            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).count != 0 {
                                
                                if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "name") as? String) != nil{
                                    
                                    self.validTill_label.text = "Valid till " + String(describing: ((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "Productrewardoffere") as? NSDictionary)?.value(forKey: "Productrewardofferdetaile") as? NSDictionary)?.value(forKey: "expiry_date"))!) + " | Offer only for" + (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)?.value(forKey: "name") as? String)!
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }

            
            }
            //
            if (myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "name") is NSNull{
                
            }else{
                
                self.productTitle_label.text = String(describing:((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "name"))! )
                
            }
            //
            if (myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") is NSNull{
                
                if ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")is NSNull) {
                    
                }else{
                    
                    self.productNewPrice_label.text = "Rs." + String(describing:(((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price"))!)  + ".00"
                    
                    pricee = self.productNewPrice_label.text!
                }
                
                self.offerPrice_label.text = "Price"
                
                self.productOldPrice_label.isHidden = true
                
                self.cutView_View.isHidden = true
                
            }else{
                //
                if parentVC == "ComboOfferViewController"{
                    
                }else{
                    
                    if ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") is NSNull{
                        
                    }else{
                        
                        if (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type") is NSNull{
                            
                            
                        }else{
                            ///////////////
                            if (((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 1 {
                                
                                //multiply
                                
                                let price = Float((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price") as? Int)!)  -  (  Float(((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!)   *  Float(((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price") as? Int)!)) / 100 )
                                
                                self.productNewPrice_label.text = "Rs. " + String(describing: price) + "0"
                                
                                newPricee = self.productNewPrice_label.text!
                                
                                self.productOldPrice_label.isHidden = false
                                
                                // cell.oldPrice_height.constant = 20
                                
                                cutView_View.isHidden = false
                                
                                self.offerPrice_label.text = "Offer Price : "
                                
                                self.productOldPrice_label.text = "Rs. " + String(describing: (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                                
                                
                            }else if (((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 2{
                                //minus
                                let price = (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price") as? Int)!  -    ((((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer")as? NSDictionary)?.value(forKey:"particularProductdiscountoffer") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                                
                                self.productNewPrice_label.text = "Rs. " + String(describing: price) + ".00"
                                
                                newPricee = self.productNewPrice_label.text!
                                
                                self.productOldPrice_label.isHidden = false
                                
                                //cell.oldPrice_height.constant = 20
                                
                                cutView_View.isHidden = false
                                
                                self.offerPrice_label.text = "Offer Price : "
                                
                                self.productOldPrice_label.text = "Rs. " + String(describing: (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductpageDetails")as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                                
                            }else{
                                
                                
                                
                            }
                        }
                    }
                    
                }
                
            }
            
            self.descriptionText_label.text = ((self.myData.value(forKey: "data")as? NSDictionary)?.value(forKey: "description") as? String)!
            
        
        //3
        
        
    }
    
    
    
    //MARK: connectionForComboDetail
    
    func connectionForComboDetail(){
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["id": productId as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("comboparticularProductDeatils", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  (receivedData.value(forKey: "response") != nil) == true {
                    
                    self.fullScroll_ScrollView.isHidden = false
                    
                    self.myData = receivedData
                    ///////
                    self.featured_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularProductfeatured")as? NSArray)!
                    
                    if self.featured_data.count == 0{
                        
                        
                    }else{
                        
                        self.featureTableView_TableView.delegate = self
                        
                        self.featureTableView_TableView.dataSource = self
                        
                        self.featureTableView_TableView.reloadData()
//
//                        self.featureTableView_TableView.rowHeight =
                        
                        
                        
                       // self.featureTableView_TableView.contentSize.height + 10
                        
                    }
                    ///////
                    self.application_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularProductApplications")as? NSArray)!
                    
                    if self.application_data.count == 0{
                        
                        
                    }else{
                        
                        self.applicationTableView_TableView.delegate = self
                        
                        self.applicationTableView_TableView.dataSource = self
                        
                        self.applicationTableView_TableView.reloadData()
                        
                        self.applicationTableView_height.constant = self.applicationTableView_TableView.contentSize.height + 10
                    }
                    ///////
                    self.sizePackaging_data = ((self.myData.value(forKey:"data")as? NSDictionary)?.value(forKey:"particularSizeAndPackaging")as? NSArray)!
                    
                    if self.sizePackaging_data.count == 0{
                        
                        
                    }else{
                        
                        //                        self.sizeParent_TableView.delegate = self
                        //
                        //                        self.sizeParent_TableView.dataSource = self
                        
                        singleton.sharedInstance.quantity.removeAllObjects()
                        singleton.sharedInstance.total_price.removeAllObjects()
                        
                        for i in 0..<self.sizePackaging_data.count{
                            
                            singleton.sharedInstance.quantity.add(0)
                            
                            singleton.sharedInstance.total_price.add(0)
                        }
                        
                        self.sizeParent_TableView.reloadData()
                        
                    }
                    
                    self.fetch()
                    
                    
                        //self.featureTableView_TableView.rowHeight * CGFloat(self.featured_data.count)
                    
                    
                // self.applicationTableView_TableView.rowHeight * CGFloat(self.application_data.count)
                    
                    
                    
                    print (self.myData)
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
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
        
        if collectionView == products_CollectionView{
            
            return CGSize(width : products_CollectionView.frame.width  , height: products_CollectionView.frame.height )
            
        }else{
            
            return CGSize(width : productVideo_CollectionView.frame.width  , height: productVideo_CollectionView.frame.height )
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == products_CollectionView{
            
            
            return ((self.imageData.value(forKey: "Particular_All_images") as? NSArray)!.count)
            
        }else{
            
            return ((self.myData.value(forKey: "all_videos") as? NSArray)!.count)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == products_CollectionView{
            
            let cell = products_CollectionView.dequeueReusableCell(withReuseIdentifier: "ProductDescriptionCollectionViewCell_Identifier", for: indexPath) as! ProductDescriptionCollectionViewCell
            
            if  ((((self.imageData.value(forKey: "Particular_All_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>"{
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith((NSURL(string : productImage_url + (((self.imageData.value(forKey: "Particular_All_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            return cell
            
        }else{
            
            //  if (self.myData.value(forKey: "all_videos") as? NSArray)?.object(at :indexPath.row ).contains(".mp4") {
            
            let cell = productVideo_CollectionView.dequeueReusableCell(withReuseIdentifier: "ProductVideo_Identifier", for: indexPath) as! ProductVideoCollectionViewCell
            
            //  let fileURL = URL(string:NewMediaArray[indexPath.row])
            
            let fileURL = URL(string: (((self.myData.value(forKey: "all_videos") as? NSArray)?.object(at :indexPath.row ) as? NSDictionary)?.value(forKey: "video") as? String)!)
            
            print(fileURL!)
            
            cell.thumbnail_ImageView.image = #imageLiteral(resourceName: "placeholder1")
            
          
            return cell
            
            
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == products_CollectionView{
            
            
        }else{
            
            UIApplication.shared.open(URL(string: (((self.myData.value(forKey: "all_videos") as? NSArray)?.object(at :indexPath.row ) as? NSDictionary)?.value(forKey: "video") as? String)!)!, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: { (_) in})
    
        }
        
    }
 
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == products_CollectionView{
            
            pageControl.currentPage = indexPath.row
            
        }else{
            
            video_pageControl.currentPage = indexPath.row
            
        }
        
    }
    
    //MARK:Total Price
    
    func get_total_price(totalPrice: NSMutableArray, pack_id: Int, Qty: NSMutableArray) {
        
        //  self.totalPrice_Label.text = totalPrice
        
        if singleton.sharedInstance.addToCart == false{
            
            self.totalPrice_Label.isHidden = true
            
            self.totalPriceHeading_label.isHidden = true
            
        }else{
            
            self.totalPrice_Label.isHidden = false
            
            self.totalPriceHeading_label.isHidden = false
        }
        
        let packId : NSMutableArray = []
        
        let qty_chk : NSMutableArray = []
        
        
        for i in 0..<Qty.count{
            
            if Qty.object(at: i)as? Int != 0{
                
                qty_chk.add((Qty.object(at: i)as? Int)!)
                
                packId.add(((sizePackaging_data.object(at:i) as! NSDictionary).value(forKey:"id") as? Int!)!)
                
             //   singleton.sharedInstance.total_price.add((((sizePackaging_data.object(at: i) as! NSDictionary).value(forKey: "price")as? Int)! * (Qty.object(at: i)as? Int)!))
                
              // singleton.sharedInstance.total_price.replaceObject(at: i, with: Int(totalPrice)!)
               
            }else{
                
            }
            
        }
        
        self.pack_id = packId.componentsJoined(by: ",")
        
        print(singleton.sharedInstance.total_price)
        
        var val = 0
        
        for i in 0..<singleton.sharedInstance.total_price.count{
            
            val = (singleton.sharedInstance.total_price.object(at: i)as? Int)! + val
        }
        
        print(val)
        
        self.totalPrice_Label.text = String(describing:(val)) + ".00"
        
        print(pack_id)
        
        self.quantity = qty_chk.componentsJoined(by: ",")
        
        print(self.quantity)
    }
    
    
    
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == featureTableView_TableView{
            
            return featured_data.count
            
        }else if tableView == applicationTableView_TableView{
            
            return application_data.count
            
        }else if tableView == sizeParent_TableView{
            
            if parentVC == "ComboOfferViewController"{
                
                return sizePackaging_data.count
                
            }else{
                
                return sizePackaging_data.count
                
            }
            
        }else{
            
            return reviews_data.count
            
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if tableView == featureTableView_TableView{

            return UITableView.automaticDimension

        }else{

            return UITableView.automaticDimension

        }

    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if tableView == featureTableView_TableView{
//
//            return UITableViewAutomaticDimension
//
//        }else{
//
//            return UITableViewAutomaticDimension
//
//        }
//
//    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == featureTableView_TableView{
            
            let cell = featureTableView_TableView.dequeueReusableCell(withIdentifier: "ProductReviewTableViewCell_Identifier") as! ProductReviewTableViewCell
            
            cell.featured_descLbl.text = String(describing:((self.featured_data.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "name"))!)
            
            return cell
            
        }else if tableView == applicationTableView_TableView{
            
            let cell = applicationTableView_TableView.dequeueReusableCell(withIdentifier: "ProductReviewTableViewCell_Identifier") as! ProductReviewTableViewCell
            
            cell.appli_descLbl.text = String(describing:((self.application_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name"))!)
            
            return cell
            
        }else if tableView == sizeParent_TableView{
            
            if parentVC == "ComboOfferViewController"{
              
                let cell = sizeParent_TableView.dequeueReusableCell(withIdentifier: "parentTable_Identifier") as! SizeTableViewCell
                
               // productVideoView_height.constant = 0
                
                parentTable_height.constant = 0
                
                saleInnerView_height.constant = 0
                
                saleOuter_View.isHidden = true
//
                return cell
              
                
            }else{
                
                
                let cell = sizeParent_TableView.dequeueReusableCell(withIdentifier: "parentTable_Identifier") as! SizeTableViewCell
                
                saleInnerView_height.constant = 48
                
                saleOuter_View.isHidden = false
                
//                if cell.Quantity_TextField.text == "0"{
//                    
//                    singleton.sharedInstance.addToCart = false
//
//                    if singleton.sharedInstance.addToCart == false{
//
//                        self.totalPrice_Label.isHidden = true
//
//                        self.totalPriceHeading_label.isHidden = true
//
//                    }else{
//
//                        self.totalPrice_Label.isHidden = false
//
//                        self.totalPriceHeading_label.isHidden = false
//                    }
//                }
//
                singleton.sharedInstance.addToCart = false
                
                if singleton.sharedInstance.addToCart == false{
                    
                    self.totalPrice_Label.isHidden = true
                    
                    self.totalPriceHeading_label.isHidden = true
                    
                }else{
                    
                    self.totalPrice_Label.isHidden = false
                    
                    self.totalPriceHeading_label.isHidden = false
                }
                
                
                cell.blueTick_ImageView.isHidden = true
                
                cell.delegate = self
               
                cell.sizeChild_TableView.tag = indexPath.row
                
                cell.quantity_Button.tag = indexPath.row
              
                cell.quantity_Button.addTarget(self, action: #selector(changeQuantity), for: .touchUpInside)
                
                
                
                if self.cart_data.count != 0 {
                        
                        for i in 0..<self.cart_data.count{
                            
                            if ((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).value(forKey:"id") as? Int)! == ((self.cart_data.object(at: i) as? NSDictionary)?.value(forKey: "product_pack_id") as? Int)!{
                                
                                cell.Quantity_TextField.text = String(describing:((self.cart_data.object(at: i) as? NSDictionary)?.value(forKey: "quantity"))!)
                                
                                cell.blueTick_ImageView.isHidden = false
                                
                                self.totalPriceHeading_label.isHidden = false
                                
                                self.totalPrice_Label.isHidden = false
                                
                                cell.price_Label.text = String(describing:(((self.cart_data.object(at: i) as? NSDictionary)?.value(forKey: "quantity") as? Int)! * ((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).value(forKey:"price") as? Int)!))
                                
                                singleton.sharedInstance.total_price.replaceObject(at: i, with: (((self.cart_data.object(at: i) as? NSDictionary)?.value(forKey: "quantity") as? Int)! * ((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).value(forKey:"price") as? Int)!))
                                
                                var val = 0
                                
                                for i in 0..<singleton.sharedInstance.total_price.count{
                                    
                                    val = (singleton.sharedInstance.total_price.object(at: i)as? Int)! + val
                                }
                                
                                print(val)
                                
                                self.totalPrice_Label.text = String(describing:(val)) + ".00"
                                
                                singleton.sharedInstance.quantity.replaceObject(at: indexPath.row, with: (((self.cart_data.object(at: i) as? NSDictionary)?.value(forKey: "quantity")as? Int)!))
                                
                            }
                        }
                        
                        self.addToCart_button.setTitle("Edit Cart", for: .normal)
                        
                    }else  if self.sampleCart_data.count != 0 {
                    
                    self.sample_btn.setTitle("Delete", for: .normal)
                }
                else{
                    
                        cell.blueTick_ImageView.isHidden = true
                        
                        self.addToCart_button.setTitle("Add To Cart", for: .normal)
                    }
//                }
                
                
                cell.data = sizePackaging_data
                
                if ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") is NSNull) || (String(describing: ((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer"))!) == "<null>"){
                    
                    cell.discountDetails = [:]
                    
                    
                }else{
                    
                    cell.discountDetails = (((myData.value(forKey: "data") as? NSDictionary)?.value(forKey: "particularProductoffer") as? NSDictionary)?.value(forKey: "particularProductdiscountoffer") as? NSDictionary)!
                    
                }
                
                cell.keys = []
                
                cell.keys = (sizePackaging_data.object(at: indexPath.row) as! NSDictionary).allKeys as NSArray
                
                var key = NSMutableArray()
                
                for i in 0..<((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).allKeys as NSArray).count{
                    
                    if String(describing: (((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).allKeys as NSArray).object(at: i)))  == "id"{
                        
                        
                    }else{
                        
                        key.add(String(describing:(((sizePackaging_data.object(at: indexPath.row) as! NSDictionary).allKeys as NSArray).object(at: i)) ))
                        
                    }
                    
                }
                
                cell.key = key
                
                cell.sizeChild_TableView.delegate = cell
                
                cell.sizeChild_TableView.dataSource = cell
                
                cell.sizeChild_TableView.reloadData()
                
                cell.childTable_height.constant = CGFloat(30*cell.key.count)
                
                cell.sizeChild_TableView.frame.size.height = cell.childTable_height.constant
              
                self.parentTable_height.constant = ((CGFloat(self.sizePackaging_data.count))*(CGFloat(30*cell.key.count) + 40)) + 80
                
                return cell
                
            }
            
            
        }else{
            
            let cell = review_TableView.dequeueReusableCell(withIdentifier: "ProductReviewTableViewCell_Identifier") as! ProductReviewTableViewCell
            /////////
            
            cell.name_label.text = (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "name") as? String)!
            
            cell.description_label.text = ((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "message") as? String)!
            
            cell.starRating_View.value = CGFloat(Int(String(describing: ((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "rating"))!))!)
            
            cell.productImage_ImageView.layer.cornerRadius = cell.productImage_ImageView.frame.height/2
            
            cell.productImage_ImageView.layer.masksToBounds = true
            
            
            if (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image")) is NSNull || (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>"{
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith(NSURL(string: userImage_url + (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            
            
//            let UserType = (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "user_type") as? String)!
//            //1
//            if UserType == "1"{
//
//                if (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image")) is NSNull || (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>"{
//
//                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
//
//                }else{
//
//                    cell.productImage_ImageView.setImageWith(NSURL(string: distributorImage_url + (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }
//
//            }else if UserType == "2"{
//
//                if (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image")) is NSNull || (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>"{
//
//                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
//
//                }else{
//
//                    cell.productImage_ImageView.setImageWith(NSURL(string: directDealerImage_url + (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }
//
//                //3
//            }else if UserType == "3"{
//
//                if (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image")) is NSNull || (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>"{
//
//                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
//
//                }else{
//
//
//                    cell.productImage_ImageView.setImageWith(NSURL(string: retailerImage_url + (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }
//
//                //4
//            }else{
//
//                if (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image")) is NSNull || (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>"{
//
//                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
//
//                }else{
//
//                    cell.productImage_ImageView.setImageWith(NSURL(string: endUserImage_url + (((reviews_data.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductReviewUserdetails") as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }
//
//
//            }
            
            return cell
            
        }
        
    }
    
    //MARK: changeQuantity
    
    @objc func changeQuantity(sender:UIButton){
        
        tableTag = sender.tag
        
        self.quantity_textField.text = singleton.sharedInstance.quantitydetail
        
        self.overlay_View.isHidden = false
        
      
    }
    
    
    //MARK: connectionForReviews
    
    func connectionForReviews() {
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["product_id": productId as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("Find_all_reveiw", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.reviews_data = ((receivedData.value(forKey: "data") as? NSDictionary)?.value(forKey: "rows") as? NSArray)!
                    
                    print(self.reviews_data)
                    
                    if self.reviews_data.count == 0{
                        
                        self.review_TableView.isHidden = true
                        
                        self.noreview_View.isHidden = false
                        
                        let noReview_label = UILabel()
                        
                        noReview_label.frame = CGRect(x: self.noreview_View.frame.origin.x + 4 , y: self.noreview_View.frame.origin.y + 4, width: self.noreview_View.frame.size.width - 10, height: self.noreview_View.frame.size.height - 5)
                        
                        noReview_label.font = UIFont(name: "Arcon", size: 7)
                        
                        noReview_label.textAlignment = .center
                        
                        noReview_label.textColor = UIColor.darkGray
                        
                        noReview_label.text = "No reviews"
                        
                        self.noreview_View.addSubview(noReview_label)
                        
                        
                    }else{
                        
                        self.review_TableView.isHidden = false
                        
                        self.noreview_View.isHidden = true
                        
                        self.reviewTableView_height.constant = CGFloat(140 * self.reviews_data.count)
                        
                        self.review_TableView.delegate = self
                        
                        self.review_TableView.dataSource = self
                        
                        self.review_TableView.tableFooterView = UIView()
                        
                        self.review_TableView.reloadData()
                        
                    }
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    @IBAction func sampleCart_btn(_ sender: UIButton) {
        
        if sample_btn.titleLabel?.text == "Add To Sample Cart" {
    //if UserDefaults.standard.value(forKey: "Login_Status") as? Data == nil {
        
        
        if UserDefaults.standard.value(forKey: "Login_Status") as? Bool == false {
            
            let alert = UIAlertController(title: "AIPL ABRO", message: "First Login to add product in cart", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
            
         }else{
            
            let packId : NSMutableArray = []
            
            for i in 0..<sizePackaging_data.count {
                
                packId.add(((sizePackaging_data.object(at:i) as! NSDictionary).value(forKey:"id") as? Int!)!)
                print(packId)
                
                self.pack_id = packId.componentsJoined(by: ",")
                
                self.pack_Id = packId.object(at: 0) as! Int
                print(self.pack_Id)
                
            }
            
            var parameters : [NSString: NSObject] = [:]
            var userId = ""
            
            if (UserDefaults.standard.value(forKey: "Login_Flow") as? String)! == "corp_flow" {
                
                let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
                
                if userData != [:] {
                 userId = userData.value(forKey: "Code") as? String ?? ""
                
                parameters = ["product_id": productId as NSObject ,
                              "user_id": userId as NSObject,
                              "quantity":"1" as NSObject,
                              "product_pack_id":self.pack_Id as NSObject]
                    
            }
            }
             else{
                
                print(NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary)
                
                parameters = ["product_id": productId as NSObject ,
                              "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject,
                              "quantity":"1" as NSObject,
                              "product_pack_id":self.pack_Id as NSObject]
            }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("Add_cart_product_sample", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    singleton.sharedInstance.cartCount = singleton.sharedInstance.cartCount + 1
                    
                    self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                    
                    self.sample_btn.setTitle("Delete", for: .normal)
                    
                }else {
                    
                    self.alert(message: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
     
       
    }
            
        }else{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data == nil {
                
                let alert = UIAlertController(title: "AIPL ABRO", message: "First Login to add product in cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else{
              
                var parameters : [NSString: NSObject] = [:]
                
                if (UserDefaults.standard.value(forKey: "Login_Flow") as? String)! == "corp_flow" {
                    
                    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
                    
                    if userData != [:] {
                       let userId = userData.value(forKey: "Code") as? String ?? ""
                        
                        parameters = ["product_id": productId as NSObject ,
                                      "user_id": userId as NSObject]
                        
                    }
                }
                else{
                
                    parameters = ["product_id": productId as NSObject ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject]
                }
                
                
                print(parameters)
                
                Indicator.shared.showProgressView(self.view)
                
                self.conn.startConnectionWithSting("delete_parent_cart_product_Sample", method_type: .post, params: parameters as [NSString : NSObject]) {
                    
                    
                    (receivedData) in
                    
                    print(receivedData)
                    
                    Indicator.shared.hideProgressView()
                    
                    
                    if self.conn.responseCode == 1 {
                        
                        if receivedData.value(forKey: "response") as! Bool == true{
                            
                            if  singleton.sharedInstance.cartCount != 0{
                                
                                singleton.sharedInstance.cartCount = singleton.sharedInstance.cartCount - 1
                                
                                self.alert(message: receivedData.value(forKey: "message") as! String)
                                
                            }
                            self.sample_btn.setTitle("Add To Sample Cart", for: .normal)
                            
                            
                        }else{
                            
                            //  self.alert(message: receivedData.value(forKey: "message") as! String)
                            
                        }
                        
                        
                    }
//
//                    if self.conn.responseCode == 1 {
//
//                        self.alert(message: (receivedData.value(forKey: "message") as? String)!)
//
//                        self.addToCart_button.setTitle("Edit Cart", for: .normal)
//
//                    }
                    else {
                        
                        self.alert(message: receivedData.value(forKey: "Error") as! String)
                        
                    }
                    
                }
            }
        }
  
    }
    
    @IBAction func add_tocartBtn(_ sender: UIButton) {
        
        if addToCart_button.titleLabel?.text == "Add To Cart" {
            
           // if singleton.sharedInstance.quantity.contains(0){
            
            if singleton.sharedInstance.addToCart == false{
                
                alert(message: "Please select atleast one item")
                
            }else{
                
                
                
                if UserDefaults.standard.value(forKey: "LoginData") as? Data == nil {
                    
                    let alert = UIAlertController(title: "AIPL ABRO", message: "First Login to add product in cart", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    var parameters : [NSString: NSObject] = [:]
                    
                    parameters = ["product_id": productId as NSObject ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject,
                                  "quantity":self.quantity as NSObject,
                                  "product_pack_id":self.pack_id as NSObject]
                    
                    print(parameters)
                    
                    Indicator.shared.showProgressView(self.view)
                    
                    self.conn.startConnectionWithSting("Add_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
                        
                        (receivedData) in
                        
                        print(receivedData)
                        
                        Indicator.shared.hideProgressView()
                        
                        if self.conn.responseCode == 1 {
                            
                            singleton.sharedInstance.cartCount = singleton.sharedInstance.cartCount + 1
                            
                            self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                            
                            self.addToCart_button.setTitle("Edit Cart", for: .normal)
                            
                        }else {
                            
                            self.alert(message: receivedData.value(forKey: "Error") as! String)
                            
                        }
                        
                    }
                }
                
            
            
            
        }
            
        }else{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data == nil {
                
                let alert = UIAlertController(title: "AIPL ABRO", message: "First Login to add product in cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                var parameters : [NSString: NSObject] = [:]
                
                
                parameters = ["product_id": productId as NSObject , "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject,"quantity":self.quantity as NSObject,"product_pack_id":self.pack_id as NSObject]
                
                print(parameters)
                
                Indicator.shared.showProgressView(self.view)
                
                self.conn.startConnectionWithSting("update_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
                    
                    (receivedData) in
                    
                    print(receivedData)
                    
                    Indicator.shared.hideProgressView()
                    
                    if self.conn.responseCode == 1 {
                        
                        self.alert(message: (receivedData.value(forKey: "message") as? String)!)
                        
                        self.addToCart_button.setTitle("Edit Cart", for: .normal)
                        
                    }else {
                        
                        self.alert(message: receivedData.value(forKey: "Error") as! String)
                        
                    }
                    
                }
            }
        }
    }
    
    
    
    @IBAction func cancel_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
    }
    
    
    @IBAction func save_Button(_ sender: UIButton) {
        
        singleton.sharedInstance.quantitydetail = self.quantity_textField.text!
        
        let index = NSIndexPath(row: sender.tag, section: 0)
        
        print(index)
        
        let cell = sizeParent_TableView.cellForRow(at: index as IndexPath) as! SizeTableViewCell
        
        cell.Quantity_TextField.text = singleton.sharedInstance.quantitydetail
        
        
        cell.delegate = self
        
        cell.i =  Int(cell.Quantity_TextField.text!)!
        
        singleton.sharedInstance.quantitydetail = String(describing:cell.i)
        
        cell.Quantity_TextField.text = String(describing:(cell.i))
        
        let product :Int = (Int(cell.description_price)! * cell.i)
        
        cell.price_Label.text = String(describing:(product)) + ".00"
        
        singleton.sharedInstance.quantity.replaceObject(at: cell.sizeChild_TableView.tag, with: cell.i)
        
        singleton.sharedInstance.total_price.replaceObject(at: cell.sizeChild_TableView.tag, with: product)
        
        singleton.sharedInstance.addToCart = true
        
       // delegate?.get_total_price(totalPrice: singleton.sharedInstance.total_price,pack_id: self.pack_id,Qty: singleton.sharedInstance.quantity)
        
        cell.sizeChild_TableView.reloadData()
        
        cell.blueTick_ImageView.isHidden = false
        
        print(index.row)
        
        overlay_View.isHidden = true
        
    }
    
    
}

extension UIView {
    
    
    func borderCornerRadius(Outlet : UIView) {
        
        
        Outlet.layer.cornerRadius = 5
        
    }
    
}

extension UIView {
    
    func giveShadow(Outlet : UIView) {
        
        Outlet.layer.masksToBounds = false
        
        Outlet.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        Outlet.layer.shadowRadius = 3
        
        Outlet.layer.shadowOpacity = 0.5
        
        Outlet.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func giveShadowinnerview(Outlet : UIView) {
        
        Outlet.layer.shadowOffset = CGSize(width: 2, height: 0)
        
        Outlet.layer.shadowRadius = 3
        
        Outlet.layer.shadowOpacity = 1.0
        
        Outlet.layer.shadowColor = UIColor.lightGray.cgColor
        
        Outlet.layer.masksToBounds = false
        
    }
}

