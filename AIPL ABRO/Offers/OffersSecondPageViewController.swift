//
//  OffersSecondPageViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/2/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OffersSecondPageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Outlets
    
    
    @IBOutlet weak var grid_button: UIButton!
    
    @IBOutlet weak var list_button: UIButton!
    
    @IBOutlet weak var sortBy_button: UIButton!
    
    @IBOutlet weak var overlay_View: UIView!
    
    @IBOutlet weak var overlayChild_View: UIView!
    
    @IBOutlet weak var sortByAlphabet_button: UIButton!
    
    @IBOutlet weak var SortByLowToHigh_button: UIButton!
    
    @IBOutlet weak var sortByHighToLow_button: UIButton!
    
    @IBOutlet weak var offer_CollectionView: UICollectionView!
    
    @IBOutlet weak var offer_TableView: UITableView!
    
    //MARK: Variables
    
    var id = Int() //from aiplhome vc and offer vc
    
    var offerType = String() //from aipl home vc
    
    var parentVC = String() //from aiplhome vc and offer vc
    
    var offerData : NSMutableArray = []
    
    var rewardData : NSMutableArray = []
    
    var fullData : NSMutableArray = []
    
    //For Pagination
    
    var isDataLoading:Bool=false
    
    var pageNo:Int = 0
    
    var limit:Int = 16
    
    var offset:Int = 0 //pageNo*limit
    
    var didEndReached:Bool=false
    
    var upToLimit = 0
    
    var cat_id = ""
    
    var sub_cat = ""
    
    //Webservice
    
    var conn = webservices()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //        offer_CollectionView.delegate = self
        //
        //        offer_CollectionView.dataSource = self
        
        print(self.id)
        
        offer_TableView.isHidden = false
        
        offer_CollectionView.isHidden = true
        
        self.fetchList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = "Offers"
        
        
    }
    
    //MARK: touch func
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch = touches.first!
        
        if touch.view != overlayChild_View {
            
            self.overlay_View.isHidden = true
            
        }
        
    }
    
    //MARK:- ScrollView Delegate
    
    //    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //
    //        isDataLoading = false
    //
    //    }
    //
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //
    //        //  print("scrollViewDidEndDecelerating")
    //
    //    }
    //
    //    //Pagination
    //
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //
    //        if ((offer_CollectionView.contentOffset.y + offer_CollectionView.frame.size.height) >= offer_CollectionView.contentSize.height)
    //        {
    //
    //            isDataLoading = true
    //
    //            self.pageNo = self.pageNo + 1
    //
    //            offset = limit
    //
    //            limit = limit + 16
    //
    //            if !isDataLoading{
    //
    //                if self.limit >= (upToLimit + 16) {
    //
    //
    //                }else if self.limit >= upToLimit && self.offset < upToLimit{
    //
    //                 //   fetch(offset: self.offset , limit: upToLimit )
    //
    //                }
    //
    //                else{
    //
    //                //    fetch(offset: self.offset , limit: self.limit)
    //
    //                }
    //
    //            }
    //
    //        }
    //
    //    }
    
    
    //MARK: fetchGrid()
    
    func fetchGrid() {
        
        self.offerData = []
        
        self.rewardData = []
        
        self.fullData = []
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        //
        var parameters : [NSString: NSObject] = [:]
        
        //OfferfirstVC
        if parentVC == "OfferViewController"{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
                
                if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                    
                    parameters = ["offset": offset as NSObject ,
                                  "id": cat_id as NSObject ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject ,
                                  "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject,
                                  "sub_category_id":sub_cat as NSObject]
                    
                    print(parameters)
                    
                }
                
            }else{
                
                parameters = ["offset": offset as NSObject ,"id": cat_id as NSObject,"sub_category_id":sub_cat as NSObject]
                
                
            }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("discount_range_roducts", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    if  receivedData.value(forKey: "response") as! Bool == true{
                        
                        //                        if offset == 0 {
                        //
                        //                            self.offerData = []
                        //
                        //                        }
                        //
                        //                        self.upToLimit = (receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "count") as! Int
                        //
                        //                        print(self.upToLimit)
                        //
                        for i in 0..<((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                            
                            self.offerData.add(((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                            self.fullData.add(((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                        }
                        
                        print (self.offerData)
                        ///
                        //                        var rewardDataCount = 0
                        //
                        //                        self.rewardDataCount = (receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "count") as! Int
                        //
                        //                        print(self.rewardDataCount)
                        
                        for i in 0..<((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                            
                            self.rewardData.add(((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                            self.fullData.add(((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                        }
                        
                        print (self.fullData)
                        
                        if self.offerData.count == 0 && self.rewardData.count == 0{
                            
                            self.offer_TableView.isHidden = true
                            
                            self.offer_CollectionView.isHidden = true
                            
                        }else{
                            
                            self.offer_CollectionView.delegate = self
                            
                            self.offer_CollectionView.dataSource = self
                            
                            self.offer_TableView.isHidden = true
                            
                            self.offer_CollectionView.isHidden = false
                            
                            self.offer_CollectionView.reloadData()
                            
                            
                        }
                        
                        
                    }
                    
                }else{
                    
                    // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
            
        }
        
        //AIPLVC
        if parentVC == "AIPLHomeViewController"{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
                
                if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                    
                    parameters = ["offset": offset as NSObject ,
                                  "id": id as NSObject ,
                                  "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject,
                                  "offer_type" : offerType as NSObject  ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id")) as! NSObject  ]
                    
                    print(parameters)
                    
                }
                
            }else{
                
                parameters = ["offset": offset as NSObject ,
                              "id": id as NSObject ,
                              "offer_type" : offerType as NSObject  ]
                
            }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("all_special_discount", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    if  receivedData.value(forKey: "response") as! Bool == true {
                        //
                        //                        if offset == 0 {
                        //
                        //                            self.offerData = []
                        //
                        //                        }
                        
                        //                        self.upToLimit = (receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "count") as! Int
                        //
                        //                        print(self.upToLimit)
                        
                        for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                            
                            self.offerData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                        }
                        
                        print (self.offerData)
                        
                        if self.offerData.count == 0 {
                            
                            self.offer_TableView.isHidden = true
                            
                            self.offer_CollectionView.isHidden = true
                            
                        } else {
                            
                            self.offer_CollectionView.delegate = self
                            
                            self.offer_CollectionView.dataSource = self
                            
                            self.offer_TableView.isHidden = true
                            
                            self.offer_CollectionView.isHidden = false
                            
                            self.offer_CollectionView.reloadData()
                            
                            
                        }
                        
                        self.offer_CollectionView.reloadData()
                        
                    }
                    
                } else {
                    
                    // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
            
        }
        
        
    }
    
    //MARK: fetchList()
    
    func fetchList() {
        
        self.offerData = []
        
        self.rewardData = []
        
        self.fullData = []
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        var parameters : [NSString: NSObject] = [:]
        
        //OfferVC
        if parentVC == "OfferViewController"{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
                
                if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                    
                    parameters = ["offset": offset as NSObject ,
                                  "id": cat_id as NSObject ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject ,
                                  "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject,
                                  "sub_category_id":sub_cat as NSObject]
                    
                    print(parameters)
                    
                }
                
            }else{
                
                parameters = ["offset": offset as NSObject ,"id": id as NSObject]
                
                
            }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("discount_range_roducts", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    if  receivedData.value(forKey: "response") as! Bool == true {
                        
                        //                        if offset == 0 {
                        //
                        //                            //    let recData = NSKeyedArchiver.archivedData(withRootObject: ((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray))
                        //                            //
                        //                            //
                        //                            //    print(recData.count)
                        //
                        //                            //UserDefaults.standard.set(recData, forKey: "Data")
                        //
                        //                            self.offerData = []
                        //
                        //                        }
                        
                        //     self.upToLimit = (receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "count") as! Int
                        
                        //    print(self.upToLimit)
                        
                        if self.parentVC == "OfferViewController"{
                            
                            for i in 0..<((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                                
                                self.offerData.add(((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                                self.fullData.add(((receivedData.value(forKey: "offerdata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                            }
                            
                            print (self.offerData)
                            
                            for i in 0..<((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                                
                                self.rewardData.add(((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                                self.fullData.add(((receivedData.value(forKey: "rewarddata") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                            }
                            print (self.rewardData)
                            
                            if self.offerData.count == 0 && self.rewardData.count == 0{
                                
                                self.offer_TableView.isHidden = true
                                
                                self.offer_CollectionView.isHidden = true
                                
                            }else {
                                
                                self.offer_TableView.delegate = self
                                
                                self.offer_TableView.dataSource = self
                                
                                self.offer_TableView.isHidden = false
                                
                                self.offer_CollectionView.isHidden = true
                                
                                self.offer_TableView.reloadData()
                                
                            }
                            ///home vc
                        }else{
                            
                            for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                                
                                self.offerData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                                self.fullData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                                
                            }
                            
                            print (self.fullData)
                            
                            
                            
                            if self.fullData.count == 0 {
                                
                                self.offer_TableView.isHidden = true
                                
                                self.offer_CollectionView.isHidden = true
                                
                            }else {
                                
                                self.offer_TableView.delegate = self
                                
                                self.offer_TableView.dataSource = self
                                
                                self.offer_TableView.isHidden = false
                                
                                self.offer_CollectionView.isHidden = true
                                
                                self.offer_TableView.reloadData()
                                
                            }
                        }
                        
                        
                        
                    }
                    
                } else {
                    
                    // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
            
        }
        
        //AIPL HOME VC
        if parentVC == "AIPLHomeViewController"{
            
            if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
                
                if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                    
                    parameters = ["offset": offset as NSObject ,
                                  "id": id as NSObject ,
                                  "customer_type" : ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as! NSObject,
                                  "offer_type" : offerType as NSObject ,
                                  "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id")!) as! NSObject]
                    
                    print(parameters)
                    
                }
                
            }else{
                
                parameters = ["offset": offset as NSObject ,
                              "id": id as NSObject ,
                              "offer_type" : offerType as NSObject  ]
                
            }
            
            print(parameters)
            
            Indicator.shared.showProgressView(self.view)
            
            self.conn.startConnectionWithSting("all_special_discount", method_type: .post, params: parameters as [NSString : NSObject]) {
                
                (receivedData) in
                
                print(receivedData)
                
                Indicator.shared.hideProgressView()
                
                if self.conn.responseCode == 1 {
                    
                    if  receivedData.value(forKey: "response") as! Bool == true{
                        
                        //                        if offset == 0 {
                        //
                        //                            //    let recData = NSKeyedArchiver.archivedData(withRootObject: ((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray))
                        //                            //
                        //                            //
                        //                            //    print(recData.count)
                        //
                        //                            //UserDefaults.standard.set(recData, forKey: "Data")
                        //
                        //                            self.offerData = []
                        //
                        //                        }
                        
                        //                        self.upToLimit = (((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "count") as! Int) - 1)
                        
                        //                        print(self.upToLimit)
                        
                        for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                            
                            self.offerData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                            
                        }
                        
                        print (self.offerData)
                        
                        if self.offerData.count == 0 {
                            
                            self.offer_TableView.isHidden = true
                            
                            self.offer_CollectionView.isHidden = true
                            
                        } else {
                            
                            self.offer_TableView.delegate = self
                            
                            self.offer_TableView.dataSource = self
                            
                            self.offer_TableView.isHidden = false
                            
                            self.offer_CollectionView.isHidden = true
                            
                            self.offer_TableView.reloadData()
                            
                            
                        }
                        
                        self.offer_CollectionView.reloadData()
                        
                    }
                    
                } else {
                    
                    // self.alert(msg: receivedData.value(forKey: "Error") as! String)
                    
                }
                
            }
            
        }
        
        
        
    }
    //MARK:Actions
    
    @IBAction func grid_Button(_ sender: UIButton) {
        
        list_button.isHidden = false
        
        grid_button.isHidden = true
        
        offer_TableView.isHidden = true
        
        offer_CollectionView.isHidden = false
        
        //For Pagination
        
        self.offerData.removeAllObjects()
        
        self.rewardData.removeAllObjects()
        //
        //        isDataLoading = false
        //
        //        pageNo = 0
        //
        //        limit = 16
        //
        //        offset = 0 //pageNo*limit
        //
        //        didEndReached = false
        //
        //        upToLimit = 0
        
        self.fetchGrid()
    }
    
    @IBAction func list_Button(_ sender: UIButton) {
        
        list_button.isHidden = true
        
        grid_button.isHidden = false
        
        offer_TableView.isHidden = false
        
        offer_CollectionView.isHidden = true
        
        //For Pagination
        
        self.offerData.removeAllObjects()
        
        self.rewardData.removeAllObjects()
        
        //        isDataLoading = false
        //
        //        pageNo = 0
        //
        //        limit = 16
        //
        //        offset = 0 //pageNo*limit
        //
        //        didEndReached = false
        //
        //        upToLimit = 0
        
        self.fetchList()
        
    }
    
    @IBAction func sortBy_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = false
        
    }
    
    @IBAction func sortByAlphabet_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        for i in 0..<self.fullData.count{
            
            for j in 0..<self.fullData.count{
                
                let name_i = (self.fullData.object(at: i) as? NSDictionary ?? [:]).value(forKey: "name") as? String ?? ""
                let name_j = (self.fullData.object(at: j) as? NSDictionary ?? [:]).value(forKey: "name") as? String ?? ""
                
                
                //  let name = fullDataDict.value(forKey: "name") as? String ?? ""
                
                
                if name_i.startIndex < name_j.startIndex{
                    
                    let temp = self.fullData[i]
                    
                    self.fullData[i] = self.fullData[j]
                    
                    self.fullData[j] = temp
                }else{
                    
                    
                }
                
                //                if ((self.fullData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.fullData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] < ((self.fullData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.fullData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] {
                //
                //                    let temp = self.fullData[i]
                //
                //                    self.fullData[i] = self.fullData[j]
                //
                //                    self.fullData[j] = temp
                //
                //                }else{
                //
                //
                //                }
                
            }
            
        }
        
        //        for i in 0..<self.rewardData.count{
        //
        //            for j in 0..<self.rewardData.count{
        //
        //                if ((self.rewardData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.rewardData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] < ((self.rewardData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.rewardData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] {
        //
        //                    let temp = self.rewardData[i]
        //
        //                    self.rewardData[i] = self.rewardData[j]
        //
        //                    self.rewardData[j] = temp
        //
        //                }else{
        //
        //
        //                }
        //
        //            }
        //
        //
        //        }
        //
        //        for i in 0...9990{
        //
        //            var a = i * 1
        //
        //        }
        
        self.offer_CollectionView.reloadData()
        
        self.offer_TableView.reloadData()
        
        print(self.offerData)
        
        
    }
    
    @IBAction func SortByLowToHigh_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        for i in 0..<self.fullData.count{
            
            for j in 0..<self.fullData.count{
                
                if (((self.fullData.object(at: i) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! < (((self.fullData.object(at: j) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                    
                    let temp = fullData[i]
                    
                    fullData[i] = fullData[j]
                    
                    fullData[j] = temp
                    
                }else{
                    
                    
                }
                
            }
            
        }
        //
        //        for i in 0..<self.rewardData.count{
        //
        //            for j in 0..<self.rewardData.count{
        //
        //                if (((self.rewardData.object(at: i) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! < (((self.rewardData.object(at: j) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
        //
        //                    let temp = rewardData[i]
        //
        //                    rewardData[i] = rewardData[j]
        //
        //                    rewardData[j] = temp
        //
        //                }else{
        //
        //
        //                }
        //
        //            }
        //
        //        }
        //        for i in 0...9990{
        //
        //            var a = i * 1
        //
        //        }
        
        self.offer_CollectionView.reloadData()
        
        self.offer_TableView.reloadData()
        
        print(self.offerData)
        
    }
    
    @IBAction func sortByHighToLow_Button(_ sender: UIButton) {
        
        overlay_View.isHidden = true
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        for i in 0..<self.fullData.count{
            
            for j in 0..<self.fullData.count{
                
                if (((self.fullData.object(at: i) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! > (((self.fullData.object(at: j) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                    
                    let temp = fullData[i]
                    
                    fullData[i] = fullData[j]
                    
                    fullData[j] = temp
                    
                }else{
                    
                    
                }
                
            }
            
        }
        
        //        for i in 0..<self.rewardData.count{
        //
        //            for j in 0..<self.rewardData.count{
        //
        //                if (((self.rewardData.object(at: i) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! > (((self.rewardData.object(at: j) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
        //
        //                    let temp = rewardData[i]
        //
        //                    rewardData[i] = rewardData[j]
        //
        //                    rewardData[j] = temp
        //
        //                }else{
        //
        //
        //                }
        //
        //            }
        //
        //        }
        //
        //        for i in 0...999{
        //
        //            var a = i * 1
        //
        //        }
        
        self.offer_CollectionView.reloadData()
        
        self.offer_TableView.reloadData()
        
    }
    
    //MARK: Collection View Delegate and datasource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        return CGSize(width : offer_CollectionView.frame.width/2 - 10 , height: offer_CollectionView.frame.height/2 - 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fullData.count
        
        // return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = offer_CollectionView.dequeueReusableCell(withReuseIdentifier: "OfferSecondPageCollectionViewCell_Identifier", for: indexPath) as! OfferSecondPageCollectionViewCell
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 6
        
        cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
        
        cell.cartImage_ImageView.tintColor = UIColor.lightGray
        
        if #available(iOS 13.0, *) {
            cell.addToCart_button.border(Outlet: cell.addToCart_button)
        } else {
            // Fallback on earlier versions
        }
        
        cell.addToCart_button.tag = indexPath.row
        
        cell.addToCart_button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        cell.oldPriceView_View.isHidden = true
        
        cell.oldPrice_label.isHidden = true
        
        cell.discount_ImageView.isHidden = true
        
        cell.offer_label.isHidden = true
        
        
        if self.parentVC == "OfferViewController"{
            
            if ((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productrewardoffere")) == nil{
                
                if ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails")) is NSNull || ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails") as? String) == "<null>" {
                    
                    cell.addToCart_button.setTitle("Add to cart", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor.white
                    
                    cell.addToCart_button.setTitleColor(UIColor.darkGray, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "cartw")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.darkGray
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.contentHorizontalAlignment = .center
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                //title
                if ((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                    
                    cell.productDescription_label.text = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                    
                }
                //old price
                if (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.oldPrice_label.text = "Rs. " + String(describing: ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                }
                
                //new price
                if (self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing")  != nil{
                    
                    if (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                        
                        if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type")) is NSNull{
                            
                            cell.oldPriceView_View.isHidden = true
                            
                            cell.oldPrice_label.isHidden = true
                            
                            cell.discount_ImageView.isHidden = true
                            
                            cell.offer_label.isHidden = true
                            
                        }else{
                            
                            cell.oldPrice_label.isHidden = false
                            
                            cell.oldPriceView_View.isHidden = false
                            
                            cell.discount_ImageView.isHidden = false
                            
                            cell.offer_label.isHidden = false
                            
                            if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 1 {
                                
                                //multiply
                                let price = Float((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!)  - ( Float(((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)!) / 100 )
                                
                                cell.newPrice_label.text =  String(describing: price) + "0"
                                
                                cell.offer_label.text = String(describing:((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + " % Off"
                                
                                
                            }else if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 2{
                                
                                let price = ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)! - ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                                
                                cell.newPrice_label.text = String(describing: price) + ".00"
                                
                                cell.offer_label.text = "Rs. " + String(describing:((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + "  Off"
                                
                            }else{
                                
                                cell.newPrice_label.text = "Rs. "
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                //image
                if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                /////////
                
            }else{
                /////////
                
                if ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails")) is NSNull || ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails") as? String) == "<null>" {
                    
                    cell.addToCart_button.setTitle("Add to cart", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor.white
                    
                    cell.addToCart_button.setTitleColor(UIColor.darkGray, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "cartw")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.darkGray
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.contentHorizontalAlignment = .center
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                //title
                cell.productDescription_label.text = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
                //old price
                if (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.newPrice_label.text = "Rs. " + String(describing: ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                    cell.oldPrice_label.isHidden = true
                    
                    cell.oldPriceView_View.isHidden = true
                    
                }
                
                //image
                if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                
            }
            
        }else{
            
            //AIPL HOME VC
            if ((offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "specialdiscountCartProductDetails")) is NSNull || ((offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "specialdiscountCartProductDetails") as? String) == "<null>" {
                
                
            }else{
                
                cell.addToCart_button.setTitle("Added", for: .normal)
                
                cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                
                cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                
                cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                
                cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                
                cell.cartImage_ImageView.tintColor = UIColor.white
                
                
            }
            
            //title
            if ((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                
                cell.productDescription_label.text = (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
            }
            //old price
            if (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                
                cell.oldPrice_label.text = "Rs. " + String(describing: ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                
            }
            
            //new price
            if (self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing")  != nil{
                
                
                if (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type")) is NSNull{
                        
                        
                    }else{
                        
                        if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 1 {
                            
                            //multiply
                            let price = Float((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!)  - ( Float(((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)!) / 100 )
                            
                            cell.newPrice_label.text =  String(describing: price) + "0"
                            
                            cell.offer_label.text = String(describing:((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + " % Off"
                            
                            
                        }else if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 2{
                            
                            let price = ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)! - ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                            
                            cell.newPrice_label.text = String(describing: price) + ".00"
                            
                            cell.offer_label.text = "Rs. " + String(describing:((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + "  Off"
                            
                        }else{
                            
                            cell.newPrice_label.text = "Rs. "
                            
                        }
                    }
                    
                }
            }
            
            
            //image
            if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") is NSNull {
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
        }
        
        return cell
        
    }
    
    @objc func addToCartAction(sender:UIButton){
        
        if UserDefaults.standard.bool(forKey: "Login_Status"){
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.offerData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            alert(message: "Please login to add product to cart")
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //MARK: Table View Delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fullData.count
        //        var count = (self.offerData.count + self.rewardData.count)
        //
        //        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = offer_TableView.dequeueReusableCell(withIdentifier: "OfferSecondPageTableViewCell_Identifier") as! OfferSecondPageTableViewCell
        
        if #available(iOS 13.0, *) {
            cell.addToCart_button.border(Outlet: cell.addToCart_button)
        } else {
            // Fallback on earlier versions
        }
        
        cell.addToCart_button.tag = indexPath.row
        
        cell.addToCart_button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
        
        cell.cartImage_ImageView.tintColor = UIColor.lightGray
        
        cell.container_View.layer.masksToBounds = true
        
        cell.container_View.layer.cornerRadius = 5
        
        if self.parentVC == "OfferViewController"{
            
            if ((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productrewardoffere")) == nil{
                
                if ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails")) is NSNull || ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails") as? String) == "<null>" {
                    
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.contentHorizontalAlignment = .center
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                
                //title
                cell.productDescription_label.text = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
                //old price
                if (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.oldPrice_label.text = "Rs. " + String(describing: ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                }
                
                //price new
                
                if ((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") ) is NSNull{
                    
                    
                }else{
                    
                    cell.oldPrice_label.isHidden = true
                    
                    cell.oldPrice_height.constant = 0
                    
                    cell.oldPrice_top.constant = 0
                    
                    cell.oldPrice_bottom.constant = 0
                    
                    cell.oldPriceView_View.isHidden = true
                    
                    cell.offerPrice_label.text = "Price : "
                    
                    cell.offerImageView_ImageView.isHidden = true
                    
                    cell.off_label.isHidden = true
                    
                    
                    cell.newPrice_label.text = "Rs. " + String(describing: (((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as?  NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                    
                    
                    if ((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount")  is NSNull{
                        
                        
                    }else{
                        
                        //price
                        if (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") )  is NSNull{
                            
                        }else{
                            
                            if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type"))  is NSNull{
                                
                                //call
                                
                            }else if (((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 1 {
                                
                                //multiply
                                
                                let price = Float((((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)!) - ( Float(((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)!)) / 100 )
                                
                                cell.newPrice_label.text = "Rs. " + String(describing: price) + "0"
                                
                                cell.oldPrice_label.isHidden = false
                                
                                cell.oldPrice_height.constant = 13
                                
                                cell.oldPrice_top.constant = 10
                                
                                cell.oldPrice_bottom.constant = 10
                                
                                cell.oldPriceView_View.isHidden = false
                                
                                cell.offerImageView_ImageView.isHidden = false
                                
                                cell.off_label.isHidden = false
                                
                                cell.offerPrice_label.text = "Offer Price : "
                                
                                cell.oldPrice_label.text = "Rs. " + String(describing: (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                                
                                cell.off_label.text =  String(describing: ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)! ) + " %  Off"
                                
                                
                            }else if (((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 2 {
                                //minus
                                let price = (((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)! -  ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                                
                                
                                cell.newPrice_label.text = "Rs. " + String(describing: price) + ".00"
                                
                                cell.oldPrice_label.isHidden = false
                                
                                cell.oldPrice_height.constant = 13
                                
                                cell.oldPrice_top.constant = 10
                                
                                cell.oldPrice_bottom.constant = 10
                                
                                cell.oldPriceView_View.isHidden = false
                                
                                cell.offerImageView_ImageView.isHidden = false
                                
                                cell.off_label.isHidden = false
                                
                                cell.offerPrice_label.text = "Offer Price : "
                                
                                cell.oldPrice_label.text = "Rs. " + String(describing: (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                                
                                cell.off_label.text =  "Rs. " + String(describing: ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "offerDetailsOnProduct") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)! ) + "  Off"
                                
                            }else{
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                //image
                if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                
            }else{
                //rewardData
                if ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails")) is NSNull || ((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "DiscountCartProductDetails") as? String) == "<null>" {
                    
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.contentHorizontalAlignment = .center
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                
                //title
                cell.productDescription_label.text = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
                //price new
                
                cell.oldPrice_label.isHidden = true
                
                cell.oldPrice_height.constant = 0
                
                cell.oldPrice_top.constant = 0
                
                cell.oldPrice_bottom.constant = 0
                
                cell.oldPriceView_View.isHidden = true
                
                cell.offerPrice_label.text = "Price : "
                
                cell.offerImageView_ImageView.isHidden = true
                
                cell.off_label.isHidden = true
                
                cell.newPrice_label.text = "Rs. " + String(describing: (((fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categoryrangeProductPricing") as?  NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                
                
                //image
                if ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                
            }
            
            
        }else{
            
            //AIPL HOME VC
            if ((offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "specialdiscountCartProductDetails")) is NSNull || ((offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "specialdiscountCartProductDetails") as? String) == "<null>" {
                
                
            }else{
                
                cell.addToCart_button.setTitle("Added", for: .normal)
                
                cell.addToCart_button.contentHorizontalAlignment = .center
                
                cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                
                cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                
                cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                
                cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                
                cell.cartImage_ImageView.tintColor = UIColor.white
                
                
            }
            
            //title
            if ((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                
                cell.productDescription_label.text = (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
            }
            //old price
            if (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                
                cell.oldPrice_label.text = "Rs. " + String(describing: ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                
            }
            
            //new price
            if (self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing")  != nil{
                
                
                if (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type")) is NSNull{
                        
                        
                        
                        
                    }else{
                        
                        if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 1 {
                            
                            //multiply
                            let price = Float((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!)  - ( Float(((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)!) / 100 )
                            
                            cell.newPrice_label.text =  String(describing: price) + "0"
                            
                            cell.off_label.text = String(describing:((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + " % Off"
                            
                            
                        }else if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)! == 2{
                            
                            let price = ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductPricing") as? NSDictionary)?.value(forKey: "price")) as? Int)! - ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                            
                            cell.newPrice_label.text = String(describing: price) + ".00"
                            
                            cell.off_label.text = "Rs. " + String(describing:((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategoryProductoffer") as? NSDictionary)?.value(forKey: "allcategoryProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price"))!  ) + "  Off"
                            
                        }else{
                            
                            cell.newPrice_label.text = "Rs. "
                            
                        }
                    }
                    
                    
                    
                }
            }
            
            
            //image
            if ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") is NSNull {
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.offerData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = (((self.fullData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: Alert Functions
    
    func alert(message : String){
        
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
