//
//  HardwareProductsViewController.swift

//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class HardwareProductsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UISearchBarDelegate{
    
    //MARK: OUTLETS
    
    @IBOutlet var searchView_View: UIView!
    
    @IBOutlet weak var search_SearchBar: UISearchBar!
    
    @IBOutlet weak var productSubCategory_CollectionView: UICollectionView!
    
    @IBOutlet weak var hardwareProducts_TableView: UITableView!
    
    @IBOutlet weak var hardwareProducts_CollectionView: UICollectionView!
    
    @IBOutlet weak var grid_Button: UIButton!
    
    @IBOutlet weak var list_Button: UIButton!    
    
    @IBOutlet weak var overlay_View: UIView!
    
    @IBOutlet var overlayChild_View: UIView!
    
    @IBOutlet weak var sortByAlphabet_button: UIButton!
    
    @IBOutlet weak var SortByLowToHigh_button: UIButton!
    
    @IBOutlet weak var sortByHighToLow_button: UIButton!
    
    
    //MARK: Variable
    
    var search = ""
    
    var category = String()
    
    var subCategory : NSArray = []
    
    var subCategoryId = Int()
    
    var selected = Int()
    
    var check = NSMutableArray()
    
    ///////////
    
    var id = Int() //from aiplhome vc and offer vc
    
    var offerType = String() //from aipl home vc
    
    var parentVC = String() //from aiplhome vc and offer vc
    
    var myData : NSMutableArray = []
    
    var SubCategoryData : NSMutableArray = []
    
    var filterData : NSMutableArray = []
    
    var SubCatecorySearch : NSMutableArray = []
    
    var searchBy = ""
    
    //For Pagination
    
    var isDataLoading:Bool=false
    
    var pageNo:Int = 0
    
    var limit:Int = 16
    
    var offset:Int = 0
    
    var didEndReached:Bool=false
    
    var upToLimit = 0
    
    var conn = webservices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        offset = 0
        
        limit = 0
        
        self.hardwareProducts_TableView.isHidden = true
        
        self.search_SearchBar.delegate = self

        hardwareProducts_CollectionView.delegate = self
        
        hardwareProducts_CollectionView.dataSource = self
        
        hardwareProducts_TableView.delegate = self
        
        hardwareProducts_TableView.dataSource = self
        
        searchView_View.layer.masksToBounds = true
        
        searchView_View.layer.cornerRadius =  searchView_View.frame.height/2
        
        hardwareProducts_TableView.tableFooterView = UIView()
        
        grid_Button.isHidden = true
        
        list_Button.isHidden = false
        
        search = "F"
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.set(false, forKey: "pushToCart")
        
        self.setNavBar()
        
       // let defaultTextAttribs = [NSAttributedString.Key.font.rawValue: UIFont(name: "Arcon", size : 11), NSAttributedString.Key.foregroundColor.rawValue:UIColor.black]
        
        let defaultTextAttribs = [NSAttributedString.Key.font:UIFont(name: "Arcon", size: 11),NSAttributedString.Key.foregroundColor:UIColor.black]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = defaultTextAttribs as [NSAttributedString.Key : Any]
        
        if #available(iOS 13.0, *) {
                   
//                   let textField = search_SearchBar.searchTextField
//                  textField.clearButtonMode = .never
               
               } else {
                   
                  let textField = search_SearchBar.value(forKey: "_searchField") as? UITextField
                   textField?.clearButtonMode = .never
               }
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.title = singleton.sharedInstance.categoryHeading
        
      //  self.title = category
                
    //    self.title = singleton.sharedInstance.categoryHeading
        
     //
        print("1230")
        
        print(singleton.sharedInstance.sub_category)

        print(check)
        
        if singleton.sharedInstance.sub_category.count == 0{
            
       
        }else{
            
            for i in 0..<singleton.sharedInstance.sub_category.count{
                
                if i == selected{
                    
                    check.add(1)
                    
                }else{
                    
                    check.add(0)
                   
                }
                
            }
            
            productSubCategory_CollectionView.delegate = self
            
            productSubCategory_CollectionView.dataSource = self
            
        }
        
        if UserDefaults.standard.bool(forKey: "hardwareHeading"){
            
            UserDefaults.standard.set(false, forKey: "hardwareHeading")
            
            self.setNavigation()
            
        }
        
        self.fetchData()
        
    }
    
    func setNavigation(){
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
      //  self.title = singleton.sharedInstance.categoryHeading
        self.navigationController?.navigationBar.topItem?.title = singleton.sharedInstance.categoryHeading
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
       // myData.removeAllObjects()
        
      //  filterData.removeAllObjects()
        
        self.search_SearchBar.text = ""
            
        self.search_SearchBar.resignFirstResponder()
//
    }

    //MARK: touch func
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch = touches.first!
        
        if touch.view != overlayChild_View {
            
            self.overlay_View.isHidden = true
            
        }
        
    }
    
    
    
    //MARK: search bar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        search = "T"
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        
        search = "T"
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if self.search_SearchBar.text?.replacingOccurrences(of: " ", with: "") == ""{
            
            self.search_SearchBar.endEditing(true)
            
            search = "F"
            
            offset = 0
            
            limit = 0
            
            fetchData()
            
        }else{
            
            search = "T"
            
            self.search_SearchBar.endEditing(true)
            
            self.filterData.removeAllObjects()
            
            isDataLoading = false
            
            pageNo = 0
            
            limit = 16
            
            offset = 0
            
            didEndReached = false
            
            upToLimit = 0
            
            searchGrid()
            
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.search_SearchBar.text?.replacingOccurrences(of: " ", with: "") == ""{
            
            self.search_SearchBar.endEditing(true)
            
            search = "F"
            
            offset = 0
            
            limit = 0
            
            fetchData()
            
            
        }else{
            
            search = "T"
            
            self.search_SearchBar.endEditing(true)
            
            self.filterData.removeAllObjects()
            
            isDataLoading = false
            
            pageNo = 0
            
            limit = 16
            
            offset = 0
            
            didEndReached = false
            
            upToLimit = 0
            
            searchGrid()
            
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        
       // self.fetchGrid(offset: 0 , limit: 16)
        
    }
    
    //MARK: Function SetNavBar
    
    func setNavBar(){
        
        let btn1 = UIButton(type: .custom)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn1.tag = 0
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        ///////////
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "cartw"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn2.tag = 0
        
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
        
        self.navigationItem.rightBarButtonItems = [item2 , item1]
        
        //////////////////
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
        
    }
    
    @objc func btn2Action(){
        
        self.navigationController?.popViewController(animated: false)
        
        UserDefaults.standard.set(true, forKey: "pushToCart")
        
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue : "goToCart"), object: nil, userInfo: nil)
        
    }
    
    @objc func btn3Action(){
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    //MARK: Scroll View delegates
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//        isDataLoading = false
//
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//
//    }
//
//    //MARK: Scroll Pagination
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        if search == "T"{
//
//            if hardwareProducts_TableView.isHidden == true{
//
//                if ((hardwareProducts_CollectionView.contentOffset.y + hardwareProducts_CollectionView.frame.size.height) >= hardwareProducts_CollectionView.contentSize.height){
//
//                    isDataLoading = true
//
//                    self.pageNo = self.pageNo + 1
//
//                    offset = limit
//
//                    limit = limit + 16
//
//                    if !isDataLoading{
//
//                        if self.limit >= (upToLimit + 16) {
//
//
//                        }else if self.limit >= upToLimit && self.offset < upToLimit{
//
//                            //   fetch(offset: self.offset , limit: upToLimit )
//
//                        }
//
//                        else{
//
//                            //    fetch(offset: self.offset , limit: self.limit)
//
//                        }
//
//                    }
//
//                }
//
//            }else{
//
//                if ((hardwareProducts_TableView.contentOffset.y + hardwareProducts_TableView.frame.size.height) >= hardwareProducts_TableView.contentSize.height){
//
//                    isDataLoading = true
//
//                    self.pageNo = self.pageNo + 1
//
//                    offset = limit
//
//                    limit = limit + 16
//
//                    if !isDataLoading{
//
//                        if self.limit >= (upToLimit + 16) {
//
//
//                        }else if self.limit >= upToLimit && self.offset < upToLimit{
//
//                            //   fetch(offset: self.offset , limit: upToLimit )
//
//                        }
//
//                        else{
//
//                            //    fetch(offset: self.offset , limit: self.limit)
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//
//
//        }
//
//        if search == "F" {
//
//            if hardwareProducts_TableView.isHidden == true{
//
//                if ((hardwareProducts_CollectionView.contentOffset.y + hardwareProducts_CollectionView.frame.size.height) >= hardwareProducts_CollectionView.contentSize.height){
//
//                    isDataLoading = true
//
//                    self.pageNo = self.pageNo + 1
//
//                    offset = limit
//
//                    limit = limit + 16
//
//                    if !isDataLoading{
//
//                        if self.limit >= (upToLimit + 16) {
//
//
//                        }else if self.limit >= upToLimit && self.offset < upToLimit{
//
//                            //   fetch(offset: self.offset , limit: upToLimit )
//
//                        }
//
//                        else{
//
//                            //    fetch(offset: self.offset , limit: self.limit)
//
//                        }
//
//                    }
//
//                }
//
//            }else{
//
//                if ((hardwareProducts_TableView.contentOffset.y + hardwareProducts_TableView.frame.size.height) >= hardwareProducts_TableView.contentSize.height){
//
//                    isDataLoading = true
//
//                    self.pageNo = self.pageNo + 1
//
//                    offset = limit
//
//                    limit = limit + 16
//
//                    if !isDataLoading{
//
//                        if self.limit >= (upToLimit + 16) {
//
//
//                        }else if self.limit >= upToLimit && self.offset < upToLimit{
//
//                            //   fetch(offset: self.offset , limit: upToLimit )
//
//                        }
//
//                        else{
//
//                            //    fetch(offset: self.offset , limit: self.limit)
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//
//        }
//
//
//
//    }
    
    
    //MARK: FETCHDATA()
    
    func fetchData() {
        
        self.myData.removeAllObjects()
        
        self.myData = []
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        
        var parameters : [NSString: NSObject] = [:]
        
        
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                parameters = ["offset": offset as NSObject ,
                              "id": id as NSObject ,
                              "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject
                ]
                
                print(parameters)
                
            }
            
        }else{
            
            parameters = ["offset": offset as NSObject ,"id": id as NSObject]
            
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("All_product_categoryswise", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as! Int == 1 {
                    
//                    if offset == 0 {
//
//                        self.myData = []
//
//                    }
                    
//                    self.upToLimit = (receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "count") as! Int
//
//                    print(self.upToLimit)
                    
                    for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                        
                        self.myData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                        
                    }
                    
                    print (self.myData)
                    
                    if self.myData.count == 0 {
                        
                        self.hardwareProducts_TableView.isHidden = true
                        
                        self.hardwareProducts_CollectionView.isHidden = true
                        
                    } else {
                        
                        self.dataAccordingSubCategory()
            
                    }
                    
                }else{
                    
                   // self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            } else {
                
                 self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    func dataAccordingSubCategory(){
        
        self.SubCategoryData.removeAllObjects()
        
        for i in 0..<self.myData.count{
            
            if self.subCategoryId == ((self.myData.object(at: i) as? NSDictionary)?.value(forKey: "sub_category_id") as? Int)!{
                
                self.SubCategoryData.add((self.myData.object(at: i) as! NSDictionary))
                
            }
            
        }
        
        print(self.SubCategoryData)
        
        if self.hardwareProducts_TableView.isHidden == true{
            
            self.hardwareProducts_CollectionView.delegate = self
            
            self.hardwareProducts_CollectionView.dataSource = self
            
            self.hardwareProducts_TableView.isHidden = true
            
            self.hardwareProducts_CollectionView.isHidden = false
            
            self.hardwareProducts_CollectionView.reloadData()
            
        }
        
        if self.hardwareProducts_CollectionView.isHidden == true{
            
            self.hardwareProducts_TableView.delegate = self
            
            self.hardwareProducts_TableView.dataSource = self
            
            self.hardwareProducts_CollectionView.isHidden = true
            
            self.hardwareProducts_TableView.isHidden = false
            
            self.hardwareProducts_TableView.reloadData()
            
          //  self.hardwareProducts_TableView.isHidden = false
        }
        
    }
    
    //MARK: searchGrid()
    
    func searchGrid(){
        
        self.filterData.removeAllObjects()
        
        var parameters : [NSString: NSObject] = [:]
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type") != nil{
                
                parameters = ["search_name": search_SearchBar.text! as NSObject ,
                              "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id")!) as! NSObject ,
                              "offset" : offset as NSObject ,
                              "id": id as NSObject ]
                
            }
            
        }else{
            
            parameters = ["search_name": search_SearchBar.text! as NSObject ,
                          "offset" : offset as NSObject ,
                          "id": id as NSObject]
            
        }
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("categorieswiseSearching", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
//                    if self.offset == 0 {
//
//                        self.filterData.removeAllObjects()
//                    }
//
//                    self.upToLimit = (receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "count") as! Int
//
//                    print(self.upToLimit)
                    
                    for i in 0..<((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).count {
                        
                        self.filterData.add(((receivedData.value(forKey: "data") as! NSDictionary).value(forKey: "rows") as! NSArray).object(at: i))
                        
                    }
                    
                    print (self.filterData)
                    
                    if self.filterData.count == 0 {
                        
                        self.hardwareProducts_TableView.isHidden = true
                        
                        self.hardwareProducts_CollectionView.isHidden = true
                        
                    }else{
                        
                        self.searchAccordingToSubCategory()
                        
                    }
                                        
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else {
                
                //   self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: SearchAccordingToSubCategory
    
    func searchAccordingToSubCategory(){
        
        self.SubCatecorySearch.removeAllObjects()
        
        for i in 0..<self.filterData.count{
            
            if self.subCategoryId == ((self.filterData.object(at: i) as? NSDictionary)?.value(forKey: "sub_category_id") as? Int)!{
                
                self.SubCatecorySearch.add((self.myData.object(at: i) as! NSDictionary))
                
            }
            
        }
        
        print(self.SubCatecorySearch)
        
        if self.hardwareProducts_CollectionView.isHidden == true{
            
            self.hardwareProducts_TableView.isHidden = false
            
            self.hardwareProducts_TableView.delegate = self
            
            self.hardwareProducts_TableView.dataSource = self
            
            self.hardwareProducts_CollectionView.isHidden = true
            
            self.hardwareProducts_TableView.reloadData()
            
        }
        
        if self.hardwareProducts_TableView.isHidden == true{
            
            self.hardwareProducts_CollectionView.isHidden = false
            
            self.hardwareProducts_CollectionView.delegate = self
            
            self.hardwareProducts_CollectionView.dataSource = self
            
            self.hardwareProducts_TableView.isHidden = true
            
            self.hardwareProducts_CollectionView.reloadData()
            
        }
        
    }
    
    
    //MARK: table view delegates and datasourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search == "T"{
            
            return SubCatecorySearch.count
            
        }else{
        
            return SubCategoryData.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = hardwareProducts_TableView.dequeueReusableCell(withIdentifier: "hardwareProductsTableViewCell_Identifier") as! HardwareProductsTableViewCell
        
        cell.fullView_View.layer.masksToBounds = true
        
        cell.fullView_View.layer.cornerRadius = 8
        
        cell.fullView_View.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.fullView_View.shadow(Outlet: cell.fullView_View)
        
        cell.addToCart_button.tag = indexPath.row
        
        cell.addToCart_button.layer.cornerRadius =  cell.addToCart_button.frame.height/2
        
        cell.addToCart_button.layer.borderWidth = 1
        
        cell.addToCart_button.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor
        
        cell.addToCart_button.tag = indexPath.row
        
        cell.addToCart_button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
        
        cell.cartImage_ImageView.tintColor = UIColor.darkGray
        
        
        if search == "T"{
            
            if ((SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "categoryCartProductDetails")) is NSNull{
                
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
            
            //////
            if ((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                
                cell.productDescription_label.text = (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
            }
            
            if ((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") ) is NSNull || String(describing:((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer"))! ) == "<null>"{
                
                cell.newPrice_label.text = "Rs. " + String(describing: (((SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as?  NSDictionary)?.value(forKey: "price"))!  ) + ".00"
          
                cell.oldPrice_label.text = "Rs. " + String(describing: (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                            
            
                if ((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image1") as? String) == "<null>" || (self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image1") is NSNull {
                
                    cell.productImage_imageView.image = #imageLiteral(resourceName: "placeholder")
           
                }else{
                
                    cell.productImage_imageView.setImageWith(NSURL(string: productImage_url + ((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image1") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
                }
            
        }
            
        }else if search == "F"{
            
            if ((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "categoryCartProductDetails")) is NSNull{
                
                
            }else{
                
                cell.addToCart_button.setTitle("Added", for: .normal)
                
                cell.addToCart_button.contentHorizontalAlignment = .center
                
                cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                
                cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                
                cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                
                cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                
                cell.cartImage_ImageView.tintColor = UIColor.white
                
            }
            
            if ((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                
                cell.productDescription_label.text = (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
            }
            
            if ((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") ) is NSNull{
                
                cell.newPrice_label.text = "Rs. " + String(describing: (((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as?  NSDictionary)?.value(forKey: "price"))!  ) + ".00"
                
            }else{
                
//                cell.oldPrice_label.isHidden = true
                
                
                if ((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount")  is NSNull{
                    
                    
                }else{
                    
                    //price
                    if (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount") )  is NSNull{
                        
                    }else{
                        
                        if ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "categoryrangeProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type"))  is NSNull{
                            
                            //call
                            
                        }else if (((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 1 {
                            
                            //multiply
                            
                            let price = Float((((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)!) - ( Float(((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)!)) / 100 )
                            
                            cell.newPrice_label.text = "Rs. " + String(describing: price) + "0"
                            
//                            cell.oldPrice_label.isHidden = false
//
//                            cell.oldPrice_label.text = "Rs. " + String(describing: (((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))!  )
                            
                            
                        }else if (((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 2 {
                            //minus
                            let price = (((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as?  NSDictionary)?.value(forKey: "price") as? Int)! -  ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductoffer") as? NSDictionary)?.value(forKey: "allcategorywiseProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                            
                            cell.newPrice_label.text = "Rs. " + String(describing: price)  + ".00"
                            
//                            cell.oldPrice_label.isHidden = false
//
//                            cell.oldPrice_label.text = "Rs. " + String(describing: (((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))!  )
                            
                        }else{
                            
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            ///////////
            if (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSDictionary)?.value(forKey: "image")) is NSNull {
                
                cell.productImage_imageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_imageView.setImageWith(NSURL(string: productImage_url + ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
        }else{
            
        }
        
        
        return cell
        
    }
    
    @objc func addToCartAction(sender:UIButton){
        
        if UserDefaults.standard.bool(forKey: "Login_Status"){
            
            if search == "T"{
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
                
                vc.productId = (((self.filterData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                navigationController?.pushViewController(vc, animated: true)
                
            }else{
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
                
                vc.productId = (((self.myData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            alert(message: "Please login to add product to cart")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if search == "T"{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    //MARK: Colloection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(myData)
        
        if collectionView == hardwareProducts_CollectionView{
            
            if search == "T"{
                
                return SubCatecorySearch.count
                
            }else{
                
                return SubCategoryData.count
                
            }
            
        }else{
            
            return singleton.sharedInstance.sub_category.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hardwareProducts_CollectionView{
         
            let cell = hardwareProducts_CollectionView.dequeueReusableCell(withReuseIdentifier: "hardwareProductsCollectionViewCell_Identifier", for: indexPath) as! HardwareProductsCollectionViewCell
            
            cell.containerView_View.layer.masksToBounds = true
            
            cell.containerView_View.layer.cornerRadius = 8
            
            cell.containerView_View.giveShadow(Outlet: cell.containerView_View)
        
            cell.addToCart_button.layer.cornerRadius = cell.addToCart_button.frame.height/2
        
            cell.addToCart_button.layer.borderWidth = 1
     
            cell.addToCart_button.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor
    
            cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
       
            cell.cartImage_ImageView.tintColor = UIColor.darkGray
            
            
            if search == "T"{
                
                if ((SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "categoryCartProductDetails")) is NSNull{
                    
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                if ((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                    
                    cell.productTitle_label.text = (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                    
                }
                //old price
                if (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.productPrice_label.text = String(describing: ((((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                }
                
                if ((((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                //////////
                
            }else{
                
                if ((SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "categoryCartProductDetails")) is NSNull{
                    
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cartImage_ImageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cartImage_ImageView.image = cell.cartImage_ImageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cartImage_ImageView.tintColor = UIColor.white
                    
                }
                
                if ((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name")) != nil{
                    
                    cell.productTitle_label.text = (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                    
                }
                //old price
                if (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.productPrice_label.text = String(describing: ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                }
           ////
                if ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                
                
            }
            
            return cell
            
            
        }else{
            
            let cell = productSubCategory_CollectionView.dequeueReusableCell(withReuseIdentifier: "hardwareProductsCollectionViewCell_Identifier", for: indexPath) as! HardwareProductsCollectionViewCell
            
            cell.subCategory_Button.text = (singleton.sharedInstance.sub_category.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
           // }
            
            cell.subCategory_Button.layer.cornerRadius = cell.subCategory_Button.frame.size.height/2
            
            cell.subCategory_Button.layer.masksToBounds = true
            
            
            if check.object(at: indexPath.row) as! Int == 0{
                
                cell.subCategory_Button.backgroundColor = UIColor(red: 236/255, green:  50/255, blue:  56/255, alpha: 1.0)
                
                cell.subCategory_Button.textColor = UIColor.white
                
                
                
            }else{
                
                cell.subCategory_Button.backgroundColor = UIColor.white
                
                cell.subCategory_Button.textColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
               
               // id = ((singleton.sharedInstance.sub_category.object(at: indexPath.row) as! NSDictionary).value(forKey: "category_id") as? Int)!
                
              //  self.fetchData(offset: offset, limit: limit)
                
               // var su = (((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                
            }
            
            return cell
            
        }
        
    }
    
//    @objc func buttonClick(sender:UIButton){
//
//        for i in 0..<check.count{
//
//            if i == sender.tag{
//
//                check.replaceObject(at: sender.tag, with: 1)
//
//            }else{
//
//                check.replaceObject(at: i, with: 0)
//
//            }
//
//        }
//
//        productSubCategory_CollectionView.reloadData()
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == hardwareProducts_CollectionView{
            
            if search == "F"{
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
                
                vc.productId = (((self.SubCategoryData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                navigationController?.pushViewController(vc, animated: true)
                
            }else{
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
                
                vc.productId = (((self.SubCatecorySearch.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            if search == "F"{
                
                for i in 0..<check.count{
                    
                    if i == indexPath.row{
                        
                        check.replaceObject(at: indexPath.row, with: 1)
                        
                    }else{
                        
                        check.replaceObject(at: i, with: 0)
                        
                    }
                    
                }
                
                self.subCategoryId = ((singleton.sharedInstance.sub_category.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                print(self.subCategoryId)
                
                //     self.subCategoryId = (((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                // print(((((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
                
                print(check)
                
                //    self.id = indexPath.row
                
                //hardwareProducts_CollectionView.isHidden = true
                
                // hardwareProducts_TableView.isHidden = false
                
                //  list_Button.isHidden = true
                
                //  grid_Button.isHidden = false
                
                
                //            isDataLoading = false
                //
                //            limit = 16
                //
                //            offset = 0
                //
                //            didEndReached = false
                //
                //            upToLimit = 0
                //
                //            if search == "T"{
                //
                //                self.filterData.removeAllObjects()
                //
                //                searchGrid(offset: offset, limit: limit)
                //
                //
                //            }else{
                //
                //                self.myData.removeAllObjects()
                //
                //                self.myData = []
                //
                //                fetchData(offset: offset, limit: limit)
                //
                //            }
                
                for i in 0..<self.myData.count{
                    
                    if self.subCategoryId == ((self.myData.object(at: i) as? NSDictionary)?.value(forKey: "sub_category_id") as? Int)!{
                        
                        self.SubCategoryData.add((self.myData.object(at: i) as! NSDictionary))
                        
                    }
                    
                    
                }
                //
                print(self.SubCategoryData)
                
                self.dataAccordingSubCategory()
                
                productSubCategory_CollectionView.reloadData()
                
            }else{
                
                for i in 0..<check.count{
                    
                    if i == indexPath.row{
                        
                        check.replaceObject(at: indexPath.row, with: 1)
                        
                    }else{
                        
                        check.replaceObject(at: i, with: 0)
                        
                    }
                    
                }
                
                self.subCategoryId = ((singleton.sharedInstance.sub_category.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                print(self.subCategoryId)
               
                print(check)
             
                for i in 0..<self.filterData.count{
                    
                    if self.subCategoryId == ((self.filterData.object(at: i) as? NSDictionary)?.value(forKey: "sub_category_id") as? Int)!{
                        
                        self.SubCatecorySearch.add((self.filterData.object(at: i) as! NSDictionary))
                        
                    }
                    
                }
                //
                print(self.SubCatecorySearch)
                
                self.searchAccordingToSubCategory()
                
                productSubCategory_CollectionView.reloadData()
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if collectionView == hardwareProducts_CollectionView{
            
            return CGSize(width : self.hardwareProducts_CollectionView.frame.width/2 - 10 , height: hardwareProducts_CollectionView.frame.height/3 - 10)

        }else{
            
            return CGSize(width: self.productSubCategory_CollectionView.frame.width/2 - 5 , height: 36 )
            
        }
    }
    
    //MARK: Actions
    
    @IBAction func gridButton(_ sender: UIButton) {
        
        if search == "T"{
            
            grid_Button.isHidden = true
            
            list_Button.isHidden = false
            
            hardwareProducts_CollectionView.isHidden = false
            
            hardwareProducts_TableView.isHidden = true
            
            filterData.removeAllObjects()
            
            offset = 0
            
            limit = 0
            
            searchGrid()
            
        }else{
            
            hardwareProducts_CollectionView.isHidden = false
            
            hardwareProducts_TableView.isHidden = true
            
            grid_Button.isHidden = true
            
            list_Button.isHidden = false
            
            self.myData.removeAllObjects()
            
            isDataLoading = false
            
            pageNo = 0
            
            limit = 16
            
            offset = 0 //pageNo*limit
            
            didEndReached = false
            
            upToLimit = 0
            
            self.fetchData()
            
        }
        
        
      
    }
    
    @IBAction func listButton(_ sender: UIButton) {
        
        if search == "T"{
            
            list_Button.isHidden = true
            
            grid_Button.isHidden = false
            
            hardwareProducts_CollectionView.isHidden = true
            
            hardwareProducts_TableView.isHidden = false
            
            filterData.removeAllObjects()
            
            offset = 0
            
            limit = 0
            
            searchGrid()
            
            
        }else{
            
            hardwareProducts_CollectionView.isHidden = true
            
            hardwareProducts_TableView.isHidden = false
            
            list_Button.isHidden = true
            
            grid_Button.isHidden = false
            
            self.myData.removeAllObjects()
            
            isDataLoading = false
            
            pageNo = 0
            
            limit = 16
            
            offset = 0 //pageNo*limit
            
            didEndReached = false
            
            upToLimit = 0
            
           // self.fetchData(offset: offset, limit: limit)
            
            
        }
        
        
        
    }
    
    @IBAction func sortByButton(_ sender: UIButton) {
        
        overlay_View.isHidden = false
        
    }
    
       
    
    @IBAction func sortByAlphabet_Button(_ sender: UIButton) {
        
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        overlay_View.isHidden = true
        
        
        if search == "T"{
            
            for i in 0..<self.SubCatecorySearch.count{
                
                for j in 0..<self.SubCatecorySearch.count{
                    //((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)
                    
                    print(((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] , ((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] )
                    
                    if ((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] < ((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] {
                 
                        
                        let temp = self.SubCatecorySearch[i]
                        
                        self.SubCatecorySearch[i] = self.SubCatecorySearch[j]
                        
                        self.SubCatecorySearch[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
            self.hardwareProducts_TableView.reloadData()
            
            self.hardwareProducts_CollectionView.reloadData()
            
            
        }else{
            
            for i in 0..<self.SubCategoryData.count{
                
                for j in 0..<self.SubCategoryData.count{
                    //((self.myData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)
                    
                  //  print(((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] , ((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] )
                    
                    if ((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] < ((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters[(((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).characters.startIndex)] {
                        
                  //      print((((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "name") as! String).startIndex))
                        
                  //      print((((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "name") as! String).startIndex))
                        
                        let temp = self.SubCategoryData[i]
                        
                        self.SubCategoryData[i] = self.SubCategoryData[j]
                        
                        self.SubCategoryData[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
            self.hardwareProducts_TableView.reloadData()
            
            self.hardwareProducts_CollectionView.reloadData()
            
        }
        
        
        
    }
    
    @IBAction func SortByLowToHigh_Button(_ sender: UIButton){
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        overlay_View.isHidden = true
        
        if search == "T"{
            
            for i in 0..<self.SubCatecorySearch.count{
                
                for j in 0..<self.SubCatecorySearch.count{
                    
                    if (((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! < (((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                        
                        let temp = SubCatecorySearch[i]
                        
                        SubCatecorySearch[i] = SubCatecorySearch[j]
                        
                        SubCatecorySearch[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
        }else{
            
            for i in 0..<self.SubCategoryData.count{
                
                for j in 0..<self.SubCategoryData.count{
                    
                    if (((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! < (((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                        
                        let temp = SubCategoryData[i]
                        
                        SubCategoryData[i] = SubCategoryData[j]
                        
                        SubCategoryData[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
        }

        self.hardwareProducts_TableView.reloadData()
        
        self.hardwareProducts_CollectionView.reloadData()
        
        //print(self.myData)

    }
    
    
    @IBAction func sortByHighToLow_Button(_ sender: UIButton) {
        
        sortByAlphabet_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        SortByLowToHigh_button.setImage(#imageLiteral(resourceName: "btn"), for: .normal)
        
        sortByHighToLow_button.setImage(#imageLiteral(resourceName: "btnselected"), for: .normal)
        
        overlay_View.isHidden = true
        
        if search == "T"{
            
            for i in 0..<self.SubCatecorySearch.count{
                
                for j in 0..<self.SubCatecorySearch.count{
                    
                    if (((self.SubCatecorySearch.object(at: i) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! > (((self.SubCatecorySearch.object(at: j) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                        
                        let temp = SubCatecorySearch[i]
                        
                        SubCatecorySearch[i] = SubCatecorySearch[j]
                        
                        SubCatecorySearch[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
        }else{
            
            for i in 0..<self.SubCategoryData.count{
                
                for j in 0..<self.SubCategoryData.count{
                    
                    if (((self.SubCategoryData.object(at: i) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)! > (((self.SubCategoryData.object(at: j) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price") as? Int)!{
                        
                        let temp = SubCategoryData[i]
                        
                        SubCategoryData[i] = SubCategoryData[j]
                        
                        SubCategoryData[j] = temp
                        
                    }else{
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        self.hardwareProducts_TableView.reloadData()
        
        self.hardwareProducts_CollectionView.reloadData()
        
        
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
    
}
