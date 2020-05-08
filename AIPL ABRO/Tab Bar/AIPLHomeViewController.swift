//
//  AIPLHomeViewController.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 22/01/18.
//  Copyright © 2018 promatics. All rights reserved.1
//

import UIKit

class AIPLHomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource,UISearchBarDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var topCategory_CollectionView: UICollectionView!
    
    @IBOutlet weak var searchView_UIView: UIView!
    
    @IBOutlet weak var search_SearchBar: UISearchBar!
    
    @IBOutlet weak var search_CollectionView: UICollectionView!
    
    @IBOutlet weak var featuredProducts_ViewAll_button: UIButton!
    
    @IBOutlet weak var featuredProducts_CollectionView: UICollectionView!
    
    @IBOutlet weak var bestSellingProducts_ViewAll_button: UIButton!
    
    @IBOutlet weak var recentlyViewed_ViewAll_button: UIButton!
    
    @IBOutlet weak var bestSellingProducts_CollectionView: UICollectionView!
    
    @IBOutlet weak var recentlyViewed_TableView: UITableView!
    
    @IBOutlet weak var carousel_View: iCarousel!
    
    //combo offer
    
    @IBOutlet weak var comboOffer_label: UILabel!
    
    @IBOutlet weak var comboOfferLabel_height: NSLayoutConstraint!
    
    @IBOutlet weak var comboHeadingView_height: NSLayoutConstraint!
    
    @IBOutlet var comboCarouselView: iCarousel!
    
    @IBOutlet var comboCarousel_height: NSLayoutConstraint!
    
    
    //nsconstraint
    @IBOutlet weak var recentlyViewed_NSConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var recentlyViewedTable_NSConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var recentlyViewed_View: UIView!
    
    @IBOutlet weak var carousel_height: NSLayoutConstraint!
    
    //MARK: Variables
    
    var topCategoryImages = [#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "more")]
    
    var topCategoryTitle = ["Offers","More"]
    
    var totalTopCategories = 0
    
    var categoryArr : NSArray = []
    
    var selectedIndex = 0
    
    var carouselOfferType = ["On Special Discount" , "On Special Discount" ,"On Special Discount" , "On Special Discount" ]
    
    var carouselTitleHeading = ["Hardware Products","Hardware Products" , "Hardware Products" , "Hardware Products" ]
    
    var carouselProductImage = [#imageLiteral(resourceName: "duct_tape") , #imageLiteral(resourceName: "coolant") , #imageLiteral(resourceName: "duct_tape") , #imageLiteral(resourceName: "duct_tape")]
    
    var specialDiscountView:SpecialDiscountView!
    
    var comboView:ComboView!
    
    //
    var conn = webservices()
    //
    var featuredProductData : NSArray = []
    
    var bestSellingProductData : NSArray = []
    
    var productOfferData : NSArray = []
    
    var recentProductData : NSArray = []
    
    var comboProductData : NSArray = []
    
    //search
    
    var productData : NSArray = []
    
    var categoryData : NSArray = []
    
    var subCategoryData : NSArray = []
    
    var searchDataArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        search_SearchBar.delegate = self
        
        search_CollectionView.isHidden = true
        
        if   UserDefaults.standard.value(forKey: "Login_Status") == nil{
            
            UserDefaults.standard.set(false, forKey: "Login_Status")
            
        }else{
            
            
        }
        
        //self.connectionForCategory()
        
        searchView_UIView.layer.masksToBounds = true
        
        searchView_UIView.layer.cornerRadius = searchView_UIView.frame.height/2
        
        featuredProducts_ViewAll_button.layer.masksToBounds = true
        
        featuredProducts_ViewAll_button.layer.cornerRadius = featuredProducts_ViewAll_button.frame.height/2
        
        bestSellingProducts_ViewAll_button.layer.masksToBounds = true
        
        bestSellingProducts_ViewAll_button.layer.cornerRadius =  bestSellingProducts_ViewAll_button.frame.height/2
        
        recentlyViewed_ViewAll_button.layer.masksToBounds = true
        
        recentlyViewed_ViewAll_button.layer.cornerRadius = recentlyViewed_ViewAll_button.frame.height/2
        
        self.carousel_View.type = .linear
        
        self.carousel_View.centerItemWhenSelected = true
        
        self.carousel_View.isPagingEnabled = true
        
        //
        self.comboCarouselView.type = .linear
        
        self.comboCarouselView.centerItemWhenSelected = true
        
        self.comboCarouselView.isPagingEnabled = true
        
        recentlyViewed_NSConstraint.constant = 0
        
        recentlyViewedTable_NSConstraint.constant = 0
        
        comboHeadingView_height.constant = 0
     
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                self.countCartProduct()
               
            }
            
        }else{
            
            singleton.sharedInstance.cartCount = 0
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.connectionForCategory()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.title = "AIPL ABRO"
        
       // let defaultTextAttribs = [NSAttributedString.Key.font.rawValue: UIFont(name: "Arcon", size : 11), NSAttributedString.Key.foregroundColor.rawValue:UIColor.black]
        
        let defaultTextAttribs = [NSAttributedString.Key.font:UIFont(name: "Arcon", size: 11),NSAttributedString.Key.foregroundColor:UIColor.black]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = defaultTextAttribs as [NSAttributedString.Key : Any]
        
        if #available(iOS 13.0, *) {
            
//            let textField = search_SearchBar.searchTextField
//            textField.clearButtonMode = .never
            
     //       textField.textAlignment = .center
        } else {
            
            let textField = search_SearchBar.value(forKey: "_searchField") as? UITextField
            textField?.clearButtonMode = .never
            
            textField?.textAlignment = .center
        }
        
        
        
        
        
        bestSellingProducts_CollectionView.layer.masksToBounds = true
        
        bestSellingProducts_CollectionView.layer.cornerRadius =  5
        
        self.tabBarController?.tabBar.isHidden = false

        self.connection()
        
        self.setNavBar()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.search_SearchBar.text = ""
        
        self.search_CollectionView.isHidden = true
        
        self.search_SearchBar.resignFirstResponder()
        
    }
    
    //MARK: search bar
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if self.search_SearchBar.text?.replacingOccurrences(of: " ", with: "") == ""{
           
            self.search_SearchBar.endEditing(true)
            
            self.search_CollectionView.isHidden = true
        
        }else{
         
            search_CollectionView.isHidden = false
        
            self.search_SearchBar.endEditing(true)

            self.searchDataArray = []
        
            self.connectionForSearch()
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if self.search_SearchBar.text?.replacingOccurrences(of: " ", with: "") == ""{

            self.search_SearchBar.endEditing(true)

            self.search_CollectionView.isHidden = true

        }else{
      // search_CollectionView.isHidden = false
            
            self.searchDataArray = []

            self.connectionForSearch()

        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        search_CollectionView.isHidden = true
        
        self.view.endEditing(true)
        
        self.connection()
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
            
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            
            tap.delegate = self as! UIGestureRecognizerDelegate
            
            cardView.addGestureRecognizer(tap)
            
            
            
            cardView.addSubview(btn1)
            
            cardView.addSubview(notify_label)
            
            item1 = UIBarButtonItem(customView: cardView)
            
        }
        
//        var notify_label = UILabel()
//        
//        notify_label.frame = CGRect(x: 10, y: 1, width: 11, height: 11)
//        
//        notify_label.font = UIFont(name: "Arcon", size: 7)
//        
//        notify_label.textAlignment = .center
//        
//        notify_label.text = "4"
//        
//        notify_label.textColor = UIColor.white
//        
//        notify_label.backgroundColor = UIColor(red: 34/255, green: 81/255, blue: 139/255, alpha: 1.0)
//        
//        notify_label.layer.cornerRadius = notify_label.frame.size.height/2
//        
//        notify_label.layer.masksToBounds = true
//        
//        notify_label.text = String(describing: singleton.sharedInstance.cartCount)
//        
//        let cardView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
//        
//        cardView.addSubview(btn1)
//        
//        cardView.addSubview(notify_label)
//        
//        item1 = UIBarButtonItem(customView: cardView)
        
        //////////////////
        
        let btn2 = UIButton(type: .custom)
        
        btn2.setImage(#imageLiteral(resourceName: "cartw"), for: .normal)
        
        btn2.frame = CGRect(x: 0, y: -4, width: 20, height: 20)
        
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
       
        self.tabBarController?.navigationItem.rightBarButtonItems = [ item2 , item1]
       ///////
        
        let btn3 = UIButton(type: .custom)
       
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
       
        
    }
    
    @objc func btn1Action(){
        
        self.search_SearchBar.text = ""
        
        self.search_CollectionView.isHidden = true
        
        self.search_SearchBar.resignFirstResponder()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        singleton.sharedInstance.notificationCount = 0
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn2Action(){
        
        self.search_SearchBar.text = ""
        
        self.search_CollectionView.isHidden = true
        
        self.search_SearchBar.resignFirstResponder()
        
        //      let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        
        self.tabBarController?.selectedIndex = 2
        
        
        
    }
    
    //MARK: Delegate Datasource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if collectionView == topCategory_CollectionView{
            
            return CGSize(width : topCategory_CollectionView.frame.width/5 , height: topCategory_CollectionView.frame.height)
            
        }else  if collectionView == featuredProducts_CollectionView{
            
            return CGSize(width : featuredProducts_CollectionView.frame.width/2 - 15, height: featuredProducts_CollectionView.frame.height)
            
        }else if collectionView == search_CollectionView{
            
            return CGSize(width : search_CollectionView.frame.width/2 - 7.5 , height: search_CollectionView.frame.height/2 + 15)
            
            
        }else{
            
            return CGSize(width : bestSellingProducts_CollectionView.frame.width/2 - 7.5 , height: bestSellingProducts_CollectionView.frame.height/2 - 7.5)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCategory_CollectionView {
            
            if categoryArr.count >= 3{
                
                self.totalTopCategories = 5
                
                return 5
                
                
            }else{
                
                self.totalTopCategories = (categoryArr.count + 1)
                
                return (categoryArr.count + 1)
            }
            
        }else if collectionView ==  featuredProducts_CollectionView{
            
            // return 5
            return featuredProductData.count
            
        }else if collectionView == search_CollectionView{
            
        
            return searchDataArray.count
        
        }
        else{
            
            //   return 4
            return bestSellingProductData.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCategory_CollectionView {
            
            let cell = topCategory_CollectionView.dequeueReusableCell(withReuseIdentifier: "topCategory_Identifier", for: indexPath) as! AIPLHomeCollectionViewCell
            
            if self.totalTopCategories  == 5{
                
                if indexPath.row == 0{
                    
                    cell.image_ImageView.image = topCategoryImages[0]
                    
                    cell.title_label.text = topCategoryTitle[0]
                    
                }else if indexPath.row == 4{
                    
                    cell.image_ImageView.image = topCategoryImages[1]
                    
                    cell.title_label.text = topCategoryTitle[1]
                    
                }else{
                    
                    if  (((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") ) is NSNull{
                        
                        cell.image_ImageView.image = #imageLiteral(resourceName: "placeholder")
                        
                    }else{
                        
                        cell.image_ImageView.setImageWith((NSURL(string : categoryImage_url + ((self.categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                        
                        cell.image_ImageView.image = cell.image_ImageView.image!.withRenderingMode(.alwaysTemplate)
                        
                        cell.image_ImageView.tintColor = UIColor.white
                        
                    }
                    
                    cell.title_label.text = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                    
                }
                
            }else{
                
                if indexPath.row == 0{
                    
                    cell.image_ImageView.image = topCategoryImages[0]
                    
                    cell.title_label.text = topCategoryTitle[0]
                    
                }else{
                    
                    if  (((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") ) is NSNull{
                        
                        cell.image_ImageView.image = #imageLiteral(resourceName: "placeholder")
                        
                    }else{
                        
                        cell.image_ImageView.setImageWith((NSURL(string : categoryImage_url + ((self.categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                        
                        cell.image_ImageView.image = cell.image_ImageView.image!.withRenderingMode(.alwaysTemplate)
                        
                        cell.image_ImageView.tintColor = UIColor.white
                        
                    }
                    
                    cell.title_label.text = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                    
                }
                
                
            }
            
            
            
            return cell
            
        }else
            if collectionView ==  featuredProducts_CollectionView {
                
                let cell = featuredProducts_CollectionView.dequeueReusableCell(withReuseIdentifier: "featuredProducts_Identifier", for: indexPath) as! FeaturedProductsCollectionViewCell
                
                cell.featuredProductCell_View.layer.masksToBounds = true
                
                cell.featuredProductCell_View.layer.cornerRadius = 8
                
                cell.featuredProductCell_View.layer.borderColor = UIColor.lightGray.cgColor
                
                cell.featuredProductCell_View.shadow(Outlet: cell.featuredProductCell_View)
                
                if String(describing: ((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "video1"))!) == ""{
                    
                    cell.playImage_ImageView.isHidden = true
                    
                }else{
                    
                    cell.playImage_ImageView.isHidden = false
                    
                }
                
                cell.productTitle_label.text = (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!)
                
                if ((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary) != nil{
                    
                    cell.productPrice_label.text = String(describing : (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "Productprice") as? NSDictionary)?.value(forKey: "price"))!) + ".00"
                    
                }
                
                if  String(describing:((((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0)as? NSDictionary)?.value(forKey: "image") )!) == "<null>" ||  ((((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0)as? NSDictionary)?.value(forKey: "image") ) is NSNull{

                    cell.image_imageView.image = #imageLiteral(resourceName: "placeholder")

                }else{

                    cell.image_imageView.setImageWith((NSURL(string : productImage_url + ((((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0)as? NSDictionary)?.value(forKey: "image") as? String )!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))

                //    print(((NSURL(string : productImage_url + (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSDictionary)?.value(forKey: "image") as? String )!) as URL?)!))

                }
                
                
                
                return cell
                
            }else if collectionView == search_CollectionView{
             
                let cell = search_CollectionView.dequeueReusableCell(withReuseIdentifier: "searchResult_Identifier", for: indexPath) as! AIPLHomeCollectionViewCell
                
                cell.fullView_View.layer.masksToBounds = true
                
                cell.fullView_View.layer.cornerRadius = 8
                
                cell.fullView_View.layer.borderColor = UIColor.lightGray.cgColor
                
                cell.fullView_View.shadow(Outlet: cell.fullView_View)
                
                if String(describing: ((self.searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "video1"))!) == ""{
                    
                    cell.searchPlayImage_ImageView.isHidden = true
                    
                }else{
                    
                    cell.searchPlayImage_ImageView.isHidden = false
                    
                }
                
                cell.productTitle_label.text = ((searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!
                
                cell.productPrice_label.text = "Rs. " + String(describing: (((searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "allcategorywiseProductPricing") as? NSDictionary)?.value(forKey: "price"))! ) + ".00"
                
                //image
                if ((searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                    
                    cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                    
                }else{
                    
                    cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + ((((searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images")as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    
                }
                
                return cell
                
                
            }else{
                
                let cell = bestSellingProducts_CollectionView.dequeueReusableCell(withReuseIdentifier: "bestSellingProducts_Identifier", for: indexPath) as! BestSellingProductsCollectionViewCell
                
                cell.cart_imageView.image = cell.cart_imageView.image!.withRenderingMode(.alwaysTemplate)
                
                cell.cart_imageView.tintColor = UIColor.lightGray
                
                cell.addToCart_button.tag = indexPath.row
                
                cell.addToCart_button.border(Outlet: cell.addToCart_button)
              
                cell.bestSellingProductCell_View.layer.masksToBounds = true
                
                cell.bestSellingProductCell_View.layer.cornerRadius = 8
                
                cell.bestSellingProductCell_View.shadow(Outlet: cell.bestSellingProductCell_View)
                
                if String(describing: ((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "video1"))!) == ""{
                    
                    cell.playImage_ImageView.isHidden = true
                    
                }else{
                    
                    cell.playImage_ImageView.isHidden = false
                    
                }
                
                cell.addToCart_button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
                
                if ((bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey:  "HomeParticularCartProductDetails")) is NSNull{
                    
                    cell.addToCart_button.setTitle("Add to cart", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor.white
                    
                    cell.addToCart_button.setTitleColor(UIColor.darkGray, for: .normal)
                    
                    cell.cart_imageView.image = #imageLiteral(resourceName: "cartw")
                    
                    cell.cart_imageView.image = cell.cart_imageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cart_imageView.tintColor = UIColor.darkGray
                    
                }else{
                    
                    cell.addToCart_button.setTitle("Added", for: .normal)
                    
                    cell.addToCart_button.backgroundColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0)
                    
                    cell.addToCart_button.setTitleColor(UIColor.white, for: .normal)
                    
                    cell.cart_imageView.image = #imageLiteral(resourceName: "redtick")
                    
                    cell.cart_imageView.image = cell.cart_imageView.image!.withRenderingMode(.alwaysTemplate)
                    
                    cell.cart_imageView.tintColor = UIColor.white
                    
                    
                }
                
                cell.productTitle_label.text = ((bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String)!
                
                cell.productPrice_label.text = "Rs." + String(describing : (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductDetails") as? NSDictionary)?.value(forKey: "price"))!) + ".00"
                
                //String(describing : (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "ProductDetails") as? NSDictionary)?.value(forKey: "price") as? Int)!)
                
                if  String(describing:((((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") )!) == "<null>" ||  ((((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") ) is NSNull{

                    cell.image_imageView.image = #imageLiteral(resourceName: "placeholder")

                }else{

                    cell.image_imageView.setImageWith((NSURL(string : productImage_url + ((((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String )!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))

                    //print(((NSURL(string : productImage_url + (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "All_images") as? NSDictionary)?.value(forKey: "image") as? String )!) as URL?)!))

                }
                
                return cell
                
            }
        
    }
    
    @objc func addToCartAction(sender:UIButton){
        
        if UserDefaults.standard.bool(forKey: "Login_Status"){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.bestSellingProductData.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }else{
            
            alertWithHandler(message: "Please login to add product to cart", block: {
                
                self.tabBarController?.selectedIndex = 4
                
            })
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == topCategory_CollectionView {
            
            if indexPath.row == 0{
                
                
            }else{
                
                singleton.sharedInstance.sub_category = ((self.categoryArr.object(at: indexPath.row - 1 )as? NSDictionary)?.value(forKey: "sub_category")as? NSArray)!
                
                print(singleton.sharedInstance.sub_category)
                
            }
        
            if self.totalTopCategories == 5{
                
                switch(indexPath.row){
                    
                case 0 : if UserDefaults.standard.bool(forKey: "Login_Status"){
                    
                    let vc = storyboard?.instantiateViewController(withIdentifier: "OffersViewController") as! OffersViewController
                    
                    vc.categoryArr = self.categoryArr
                    
                    navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    
                    alert(message: "Login first to see offer products")
                    
                    }
                    
                case 1 : let vc = storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
                
                vc.id = ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                vc.subCategoryId =  ((((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                vc.category = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                singleton.sharedInstance.categoryHeading = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                navigationController?.pushViewController(vc, animated: true)
                    
                case 2 : let vc = storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
                
                vc.category = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                singleton.sharedInstance.categoryHeading = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                vc.id = ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                vc.subCategoryId =  ((((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                navigationController?.pushViewController(vc, animated: true)
                    
                case 3 : let vc = storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
                
                vc.category = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                singleton.sharedInstance.categoryHeading = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                vc.subCategoryId =  ((((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                vc.id = ((categoryArr.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                navigationController?.pushViewController(vc, animated: true)
                    
                case 4 : self.tabBarController?.selectedIndex = 1 //let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
                    //
                    //            self.navigationController?.pushViewController(vc, animated: true)
                    
                default: break
                    
                }
                
            }else{
                
                if indexPath.row == 0{
                    
                    if UserDefaults.standard.bool(forKey: "Login_Status"){
                    
                    let vc = storyboard?.instantiateViewController(withIdentifier: "OffersViewController") as! OffersViewController
                    
                    vc.categoryArr = self.categoryArr
                    
                    navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    
                    self.alert(message: "Login first to see offer products")
                   
                    }
               
                }else{
                    
                    let vc = storyboard?.instantiateViewController(withIdentifier: "HardwareProductsViewController") as! HardwareProductsViewController
               
                    vc.id = ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                    vc.subCategoryId =  ((((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "sub_category") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "id") as? Int)!
                
                    vc.category = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                    singleton.sharedInstance.categoryHeading = String(describing: ((categoryArr.object(at: indexPath.row - 1) as? NSDictionary)?.value(forKey: "name"))!)
                
                    navigationController?.pushViewController(vc, animated: true)
                 
                }
            }
            
        }else if collectionView ==  featuredProducts_CollectionView{
            
            switch(indexPath.row){
                
            case 0 : let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
                
            case 1 : let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
                
            case 2 : let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
                
            case 3 : let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.featuredProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
                
            default: break
                
            }
            
        }else if collectionView ==  bestSellingProducts_CollectionView{
            
            switch(indexPath.row){
                
            case 0 : let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
                
            case 1 : let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
                
            case 2 : let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
                
            case 3 : let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.bestSellingProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            self.navigationController?.pushViewController(vc, animated: true)
                
            default: break
                
            }
            
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
            
            vc.productId = (((self.searchDataArray.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int)!)
            
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
    }
    
    //MARK: table delegate datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return 3
        return recentProductData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = recentlyViewed_TableView.dequeueReusableCell(withIdentifier: "recentlyViewed_Identifier") as! RecentlyViewedTableViewCell
        
        if ((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails")) is NSNull{
            
            
        }else{
        
        //fetch name
        
        
        if ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "name"))) != nil{
            
            cell.productTitle_label.text = ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "name") as? String)!)
        }
        //price old
        if ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price")) != nil{

            cell.oldPrice_label.text = "Rs. " + String(describing: (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"

        }
        
        //price new
        if ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price")) != nil{
            
            
            if ( ((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") ) is NSNull{
                
                
      //price old
                if ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price")) != nil{
                    
                    cell.oldPrice_label.text = "Rs. " + String(describing: (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price"))!) ) + ".00"
                    
                    cell.cutView_View.isHidden = true
                    
                    cell.offerPrice_label.isHidden = true
                    
                    cell.newPrice_label.isHidden = true
                }

                
            }else{
                
                if (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") as? NSDictionary)?.value(forKey: "recentProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") )  is NSNull{
                    
                    
                }else{
                    
                    cell.cutView_View.isHidden = false
                    
                    cell.offerPrice_label.isHidden = false
                    
                    cell.newPrice_label.isHidden = false
                    
                    if ((((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") as? NSDictionary)?.value(forKey: "recentProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type") as? Int)!) == 1 {
                        
                        //multiply
                        
                        let price = Float(((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price") as? Int)!) - Float( Float((((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") as? NSDictionary)?.value(forKey: "recentProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!) * Float(((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price") as? Int)!) / 100 )
                        
                        let float_price = Float(price)
                        
                        print(float_price)
                        
                        cell.newPrice_label.text = "Rs. " + String(describing: price) + "0"
                        
                    }else if ((((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") as? NSDictionary)?.value(forKey: "recentProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_type")as? Int)!) == 2{
                        
                        let price = (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "RecentProductPrice") as? NSDictionary)?.value(forKey: "price") as? Int)!) - (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "recentProductoffer") as? NSDictionary)?.value(forKey: "recentProductdiscountamount") as? NSDictionary)?.value(forKey: "discount_price") as? Int)!
                        
                        cell.newPrice_label.text = "Rs. " + String(describing: price)
                        
                    }else{
                        
                        cell.newPrice_label.text = "Rs.  "
                        
                    }
                    
                }
                
            }
            
        }
      
            //image
            if (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") ) is NSNull {
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith(NSURL(string: productImage_url + (((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        
        vc.productId = ((((self.recentProductData.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "RecentProductDetails") as? NSDictionary)?.value(forKey: "id") as? Int)!)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //MARK: Carousel delegates datasource
    
    func numberOfItems(in carousel: iCarousel) -> Int {
       
        if carousel == carousel_View{
        
            return productOfferData.count
            
        }else{
            
            return comboProductData.count
            
        }
        
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        if carousel == carousel_View{
        
            self.carousel_View.backgroundColor = UIColor.clear
        
            specialDiscountView = Bundle.main.loadNibNamed("SpecialDiscountView", owner: self ,options: nil)?.first as? SpecialDiscountView
            
            specialDiscountView?.frame = CGRect(x:carousel_View.frame.minX , y: carousel_View.frame.minY, width: carousel_View.frame.width - 70, height: carousel_View.frame.height - 45)
            
            specialDiscountView?.carouselFrontView_View.layer.masksToBounds = false
            
            specialDiscountView?.carouselFrontView_View.carouselShadow(Outlet: (specialDiscountView?.carouselFrontView_View)!)
            
            specialDiscountView?.carouselFrontView_View.layer.cornerRadius = 10
            
            specialDiscountView?.carouselCornerRadiusView_View.layer.cornerRadius = 10
            
            specialDiscountView?.carouselCornerRadiusView_View.layer.masksToBounds = true
            
            specialDiscountView?.offerViewAll_button.layer.masksToBounds = true
            
            specialDiscountView?.offerViewAll_button.layer.cornerRadius = specialDiscountView.offerViewAll_button.frame.height/2


            if (self.productOfferData.object(at: index) as? NSDictionary) is NSNull{
        
            
            }else{
            
                specialDiscountView?.offerCategory_label.text = (((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "name") as? String)!)
        
            }
        
            if (((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  ((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "image") is NSNull) {
            
                specialDiscountView?.offerProductImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
        
            }else{
            
                specialDiscountView?.carouselImageView_View.layer.cornerRadius =  40
                
                specialDiscountView?.carouselImageView_View.layer.masksToBounds = true
                
                specialDiscountView?.carouselImageView_View.layer.borderColor = UIColor.lightGray.cgColor
                
                specialDiscountView?.carouselImageView_View.layer.borderWidth = 2
                
                specialDiscountView?.carouselImageView_View.shadow(Outlet: (specialDiscountView?.carouselImageView_View)!)
                
                specialDiscountView?.offerProductImage_ImageView.setImageWith((NSURL(string : categoryImage_url + ((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
                specialDiscountView?.carouselImageView_View.layer.masksToBounds = true
         
            }
        
            if index == carousel.currentItemIndex{
            
                specialDiscountView?.frame = CGRect(x:carousel_View.frame.minX , y: carousel_View.frame.minY, width: carousel_View.frame.width - 70, height: carousel_View.frame.height - 20 )
       
            }
        
            return specialDiscountView!
        
            
        }else{
            
            self.carousel_View.backgroundColor = UIColor.clear
            
            comboView = Bundle.main.loadNibNamed("ComboView", owner: self, options: nil)?.first as! ComboView//Bundle.main.loadNibNamed("ComboView", owner: self ,options: nil)?.first as? ComboView
            
            comboView?.frame = CGRect(x:comboCarouselView.frame.minX , y: comboCarouselView.frame.minY, width: comboCarouselView.frame.width - 70, height: comboCarouselView.frame.height - 45)
            
            comboView?.carouselFullView_View.layer.masksToBounds = false
            
            comboView?.carouselFullView_View.layer.cornerRadius = 10
            
            comboView?.carouselCornerRadiusView_View.layer.cornerRadius = 10
            
            comboView?.carouselCornerRadiusView_View.layer.masksToBounds = true
            
            
            if (self.comboProductData.object(at: index)) is NSNull{
               
                
                
            }else{
                
                comboView?.couponCode_label.text = "Coupon Code : " +  String(describing:(((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "code"))!))

                comboView?.offerTill_label.text = "Offer Till : " +  String(describing:(((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "expiry_date"))!))

                comboView?.offer_label.text = "Offer Name : " +  String(describing:(((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "name"))!))


                if (((((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homespecialofferimage") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")as? String)!) == "<null>" ||  (((((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homespecialofferimage") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")) is NSNull) {

                    comboView?.comboImage_ImageView.image = #imageLiteral(resourceName: "placeholder")

                }else{

                    comboView?.comboImage_ImageView.setImageWith((NSURL(string : comboImage_url + ((((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homespecialofferimage") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))

                    //  ComboView?.carouselImageView_View.layer.masksToBounds = true

                }
        
            }
            
            if index == carousel.currentItemIndex{
                
                comboView?.frame = CGRect(x:comboCarouselView.frame.minX , y: comboCarouselView.frame.minY, width: comboCarouselView.frame.width - 70, height: comboCarouselView.frame.height - 20 )
            
            }
            
            return comboView!
       
        }
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if carousel == carousel_View{
        
            switch option {
        
            case .spacing:
                
                return 1.03
        
            default:
            
                return value
        
            }
        }else{
           
            switch option {
                
            case .spacing:
                
                return 1.03
                
            default:
                
                return value
                
            }

        }
        
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        if carousel == carousel_View{
        
            selectedIndex = carousel.currentItemIndex
        
            carousel_View.reloadData()
       
        }else{
            
            selectedIndex = carousel.currentItemIndex
            
            comboCarouselView.reloadData()
            
        }
        
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
        if carousel == carousel_View{
        
            let vc = storyboard?.instantiateViewController(withIdentifier: "OffersSecondPageViewController") as! OffersSecondPageViewController
       
            if (self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "id") as? Int != nil{
          
                vc.id = (self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "id") as! Int
            
                vc.parentVC = "AIPLHomeViewController"
        
            }
        
            if  ((((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "homerangeproduct") as? NSDictionary)?.value(forKey: "homeProductoffer") as? NSDictionary)?.value(forKey: "homeProductoffer") as? NSDictionary)?.value(forKey: "offer_type") as? String != nil{
           
                vc.offerType = ((((self.productOfferData.object(at: index) as? NSDictionary)?.value(forKey: "homerangeproduct") as? NSDictionary)?.value(forKey: "homeProductoffer") as? NSDictionary)?.value(forKey: "homeProductoffer") as? NSDictionary)?.value(forKey: "offer_type") as! String
        
            }
        
            self.navigationController?.pushViewController(vc, animated: false)
    
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ComboOfferViewController") as! ComboOfferViewController
            
            if ((comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homespecialofferimage")) is NSNull{
                
                
            }else{
                
                vc.imageArray = ((comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homespecialofferimage") as? NSArray)!
            
            }
           
            
            vc.offerName = String(describing: ((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "name"))!)
            
//            vc.offerDescription = (((comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "homecombooffer") as? NSDictionary)?.value(forKey: "description") as? String)!
            
            vc.offerDescription = ((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "description") as? String)!
            
            vc.comboId = String(describing: ((self.comboProductData.object(at: index) as? NSDictionary)?.value(forKey: "id"))!)
            
            self.navigationController?.pushViewController(vc, animated: true)
               
        }
    
    }
    
    //MARK: Connection
    
    func connection(){
        
        var parameters : [NSString: NSObject] = [:]
        
        
        if UserDefaults.standard.value(forKey: "LoginData") as? Data != nil {
            
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int != nil{
                
                parameters = ["user_id": String(describing: (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id")!) as NSObject  , "customer_type" : String(describing: (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "user_type")!) as NSObject]
                
            }
            
        }else{
            
            parameters = ["user_id": "" as NSObject]
            
        }
        
        // email_TextField.text! as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("Home_services", method_type: .post, params: parameters as [NSString : NSObject]){ (receivedData) in
            
            print("DAAATTAA")
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    self.featuredProductData = receivedData.value(forKey: "featuredProduct") as! NSArray
                    
                    self.bestSellingProductData = receivedData.value(forKey: "SellingProduct") as! NSArray
                    
                    self.productOfferData = receivedData.value(forKey: "categoryname") as! NSArray
                    
                    self.recentProductData = receivedData.value(forKey: "RecentlyViewed") as! NSArray
                    
                    self.comboProductData = receivedData.value(forKey: "combooffer") as! NSArray
                    
                    //collectionView
                    
                    if self.featuredProductData.count == 0{
                        
                        
                    }else{
                        
                        print(self.featuredProductData)
                        
                        self.featuredProducts_CollectionView.delegate = self
                        
                        self.featuredProducts_CollectionView.dataSource = self
                        
                        self.featuredProducts_CollectionView.reloadData()
                        
                    }
                    
                    if self.bestSellingProductData.count == 0{
                        
                        
                    }else{
                        
                        self.bestSellingProducts_CollectionView.delegate = self
                        
                        self.bestSellingProducts_CollectionView.dataSource = self
                        
                        self.bestSellingProducts_CollectionView.reloadData()
                        
                    }
                    
                    //carousel
                    
                    if self.productOfferData.count == 0{
                        
                        self.carousel_View.isHidden = true
                        
                        self.carousel_height.constant = 0
                        
                        self.carousel_View.reloadData()
                        
                        
                    }else{
                        
                        self.carousel_View.isHidden = false
                        
                        self.carousel_height.constant = 180
                        
                        self.carousel_View.dataSource = self
                        
                        self.carousel_View.delegate = self
                        
                        self.carousel_View.reloadData()
                        
                        if #available(iOS 10.0, *) {
                            
                            _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
                                
                                self.carousel_View.reloadData()
                                
                            })
                            
                        } else {
                            
                            
                        }
                    }
                    
                    //Carousel Combo
                    
                    if self.comboProductData.count == 0{
                        
                        self.comboOffer_label.isHidden = true
                        
                        self.comboOfferLabel_height.constant = 0
                        
                        self.comboHeadingView_height.constant = 0
                        
                        self.comboCarouselView.isHidden = true
                        
                        self.comboCarousel_height.constant = 0
                        
                        self.comboCarouselView.reloadData()
                        
                        
                    }else{
                        
                        self.comboOffer_label.isHidden = false
                        
                        self.comboOfferLabel_height.constant = 30
                        
                        self.comboHeadingView_height.constant = 40
                        
                        self.comboCarouselView.isHidden = false
                        
                        self.comboCarousel_height.constant = 180
                        
                        self.comboCarouselView.dataSource = self
                        
                        self.comboCarouselView.delegate = self
                        
                        self.comboCarouselView.reloadData()
                        
//                        if #available(iOS 10.0, *) {
//
//                            _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
//
//                                self.comboCarouselView.reloadData()
//
//                            })
//
//                        } else {
//
//
//                        }
                        
                    }
                    
                    //tableview
                    if self.recentProductData.count == 0 {
                        
                        self.recentlyViewed_NSConstraint.constant = 0
                        
                        self.recentlyViewedTable_NSConstraint.constant = 0
                        
                        self.recentlyViewed_TableView.isHidden = true
                        
                        self.recentlyViewed_View.isHidden = true
                        
                    }else{
                        
                        self.recentlyViewed_NSConstraint.constant = 40
                        
                        self.recentlyViewedTable_NSConstraint.constant = CGFloat(108 * self.recentProductData.count)
                        
                        self.recentlyViewed_View.isHidden = false
                        
                        self.recentlyViewed_TableView.isHidden = false
                        
                        self.recentlyViewed_TableView.delegate = self
                        
                        self.recentlyViewed_TableView.dataSource = self
                        
                        self.recentlyViewed_TableView.reloadData()
                    }
                    
                    
                    
                }else{
                    
                    //    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else{
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: connectionForCategory
    
    func connectionForCategory(){
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithStringGetType(getUrlString: "category"){
            
            (receivedData) in
            
            Indicator.shared.hideProgressView()
            
                print(receivedData)
            
            
            if self.conn.responseCode == 1{
                
                if ((receivedData.value(forKey: "response") as? Bool) == true){
                    
                    self.categoryArr  =  receivedData.value(forKey: "data") as! NSArray
                    
                    singleton.sharedInstance.categoryArr = receivedData.value(forKey: "data") as! NSArray
                    
                    self.topCategory_CollectionView.delegate = self
                    
                    self.topCategory_CollectionView.dataSource = self
                    
                }else{
                    
                  //  self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
            }else{
                
              //  self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: connection For Search
    
    func connectionForSearch() {
        
        searchDataArray.removeAllObjects()
        
        searchDataArray = []
        
        productData = []
        
        subCategoryData = []
        
        categoryData = []
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["search_name": search_SearchBar.text! as NSObject]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("searchProducts", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    if (receivedData.value(forKey: "searchproduct") is NSNull) || (receivedData.value(forKey: "searchproduct")as? NSDictionary)!.count == 0{
                        
                        
                    }else{
                        
                        if ((receivedData.value(forKey: "searchproduct") as? NSDictionary)?.value(forKey: "rows")) is NSNull{
                            
                            
                        }else{
                            
                            self.productData = ((receivedData.value(forKey: "searchproduct") as? NSDictionary)?.value(forKey: "rows") as? NSArray)!
                            
                        }
                        
                    }
 ///////////////////
                    if (receivedData.value(forKey: "searchcategory") is NSNull) || (receivedData.value(forKey: "searchcategory")as? NSDictionary)!.count == 0 {
                        
                        
                    }else{
                        
                        if ((receivedData.value(forKey: "searchcategory") as? NSDictionary)?.value(forKey: "rows")) is NSNull{
                            
                            
                        }else{
                            
                            self.categoryData = ((receivedData.value(forKey: "searchcategory") as? NSDictionary)?.value(forKey: "rows") as? NSArray)!
                            
                        }
                        
                    }
  /////////////////////
                    if (receivedData.value(forKey: "searchsubCategory") is NSNull)||(receivedData.value(forKey: "searchsubCategory")as? NSDictionary)!.count == 0 {
                        
                        
                    }else{
                        
                        if ((receivedData.value(forKey: "searchsubCategory") as? NSDictionary)?.value(forKey: "rows")) is NSNull{
                            
                            
                        }else{
                            
                            self.subCategoryData = ((receivedData.value(forKey: "searchsubCategory") as? NSDictionary)?.value(forKey: "rows") as? NSArray)!
                            
                        }
                        
                    }
                    
                    self.searchDataArray.removeAllObjects()
                    
                    for i in 0..<self.productData.count{
                        
                        self.searchDataArray.add(self.productData[i])
                        
                    }
                    for i in 0..<self.categoryData.count{
                        
                        self.searchDataArray.add(self.categoryData[i])
                        
                    }
                    for i in 0..<self.subCategoryData.count{
                        
                        self.searchDataArray.add(self.subCategoryData[i])
                        
                    }
                    
                    
                    if self.searchDataArray.count == 0{
                        
                        self.search_CollectionView.isHidden = false
                        
                        self.search_CollectionView.delegate = self
                        
                        self.search_CollectionView.dataSource = self
                        
                        self.search_CollectionView.reloadData()
                        
                    }else{
                        
                        self.search_CollectionView.isHidden = false
                     
                        self.search_CollectionView.delegate = self
                        
                        self.search_CollectionView.dataSource = self
                        
                        self.search_CollectionView.reloadData()
                        
                    }
                    
                    
                    
                }else{
                    
                    
                    
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
    
    
    //MARK: Actions
    
    @IBAction func featuredProducts_Button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeaturedProductDetailViewController") as! FeaturedProductDetailViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bestSellingProducts_Button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BestSellingProductDetailViewController") as! BestSellingProductDetailViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func recentlyViewedProducts_Button(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecentlyViewedViewController") as! RecentlyViewedViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK: CountCartProduct service
    
    func countCartProduct(){
        
        searchDataArray.removeAllObjects()
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("count_cart_product", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    singleton.sharedInstance.cartCount = receivedData.value(forKey: "count") as! Int
                    
                    self.setNavBar()
                    
                }else{
                    
                    //
                    
                }
                
                
            }else {
                
              //  self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    func countCartProduct_sample(){
        
        searchDataArray.removeAllObjects()
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("count_cart_product_Sample", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if receivedData.value(forKey: "response") as! Bool == true{
                    
                    singleton.sharedInstance.cartCount = receivedData.value(forKey: "count") as! Int
                    
                    self.setNavBar()
                    
                }else{
                    
                    //
                    
                }
                
                
            }else {
                
                //  self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
}


extension UIView {
    
    func shadow(Outlet : UIView) {
        
        Outlet.layer.masksToBounds = false
        
        Outlet.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        Outlet.layer.shadowRadius = 3
        
        Outlet.layer.shadowOpacity = 0.5
        
        Outlet.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func border(Outlet : UIView) {
        
        Outlet.layer.masksToBounds = true
        
        Outlet.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor
        
        Outlet.layer.borderWidth = 1
        
        Outlet.layer.cornerRadius = Outlet.frame.height/2
        
    }
    
    func cardView(cornerRadius: CGFloat = 1, shadowOffsetWidth: Int = 0, shadowOffsetHeight: Int = 1,shadowOpacity:Float = 0.5){
        
        
        //  let cornerRadius: CGFloat = 1
        
        //        let shadowOffsetWidth: Int = 0
        //        let shadowOffsetHeight: Int = 3
        let shadowColor: UIColor? = UIColor.black
        
        // let shadowOpacity: Float = 0.8
        
        self.layer.cornerRadius = cornerRadius
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1);
        
        self.layer.shadowOpacity = 0.5
        
        self.layer.shadowPath = shadowPath.cgPath
        
    }
    
    func carouselShadow(Outlet : UIView) {
        
        Outlet.layer.masksToBounds = false
        
        Outlet.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        Outlet.layer.shadowRadius = 5
        
        Outlet.layer.shadowOpacity = 0.8
        
        Outlet.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    
    
}

