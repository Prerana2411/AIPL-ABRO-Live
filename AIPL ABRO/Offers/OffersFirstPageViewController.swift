//
//  OffersFirstPageViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/26/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OffersFirstPageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Outlets
    
    @IBOutlet weak var subCategory_TableView: UITableView!
    
    @IBOutlet weak var subCategoryTable_Height: NSLayoutConstraint!
    
    var subCategory : NSArray = []
    
    var cat_id = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(subCategory)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Offers Sub Category"
        
        subCategory_TableView.delegate = self
        
        subCategory_TableView.dataSource = self
        
        subCategoryTable_Height.constant = 110 * CGFloat(self.subCategory.count)
        
        self.setNavBar()
    }
    
    //Functions
    
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
    
    @objc func btn2Action(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AIPLHomeViewController") as! AIPLHomeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btn3Action(){
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    //MARK: Connection
    
    
    
    //MARK: Alert Functions
    
    func alert(message : String) {
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
    
    
    //MARK:table datasource and delegates
    
    //MARK: tabkleView Delegate datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  subCategory.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //    let vc = storyboard?.instantiateViewController(withIdentifier: "OffersSecondPageViewController") as! OffersSecondPageViewController
        
        // if (self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as? Int != nil{
        
        //     vc.id = (self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as! Int
        
        //    vc.parentVC = "OfferViewController"
        
        //  }
        
        //   self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //SpecialSubCategory_TableView
        
        if indexPath.row % 2 == 0{
            
            let cell = subCategory_TableView.dequeueReusableCell(withIdentifier: "SubCategory_Identifier") as! OfferSubCategoryTableViewCell
            
            cell.rightSideImageView_View.isHidden = false
            
            cell.leftSideImageView_View.isHidden = true
            
            cell.rightCornerRadiusView_View.layer.masksToBounds = true
            
            cell.rightCornerRadiusView_View.layer.cornerRadius = 45
            
            //CELL SHADOW
            
            cell.rightSideImageView_View.layer.masksToBounds = false
            
            cell.rightSideImageView_View.layer.shadowColor = UIColor.lightGray.cgColor
            
            cell.rightSideImageView_View.layer.shadowOpacity = 1.0
            
            cell.rightSideImageView_View.layer.shadowOffset = CGSize(width: 1,height:1)
            
            cell.rightSideImageView_View.layer.shadowRadius = 2
            
            cell.rightProductViewAll_button.layer.cornerRadius = cell.rightProductViewAll_button.frame.height/2
            
            cell.rightProductImage_ImageView.layer.masksToBounds = true
            
            cell.rightProductImage_ImageView.layer.cornerRadius = cell.rightProductImage_ImageView.frame.height/2
            
            cell.rightProductImage_ImageView.layer.borderWidth = 2
            
            cell.rightProductImage_ImageView.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor
            
            //fetch
            // disc. type 1
            cell.rightProductDescription_label.text = (self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String
            
            cell.rightProductDiscount_label.text = ""
            
            //            if (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_type") as! Int) == 1{
            //
            //                cell.rightProductDiscount_label.text = "Offers - " + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + "%  Off"
            //
            //            }else if (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_type") as! Int) == 2{
            //
            //                cell.rightProductDiscount_label.text = "Offers - Rs." + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + " Off"
            //
            //            }else{
            //
            //                cell.rightProductDiscount_label.text = ""
            //
            //            }
            
            //            cell.rightProductDiscount_label.text = "Offers - Rs." + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + "  Off"
            
            // image
            if ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                
                cell.rightProductImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.rightProductImage_ImageView.setImageWith(NSURL(string: categoryImage_url + ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            cell.rightProductViewAll_button.tag = indexPath.row
            
            cell.rightProductViewAll_button.addTarget(self, action: #selector(self.viewDetail), for: .touchUpInside)
            
            return cell
            
        }else{
            
            let cell = self.subCategory_TableView.dequeueReusableCell(withIdentifier: "SubCategory_Identifier") as! OfferSubCategoryTableViewCell
            
            cell.rightSideImageView_View.isHidden = true
            
            cell.leftSideImageView_View.isHidden = false
            
            cell.leftProductViewAll_button.tag = indexPath.row
            
            cell.leftProductViewAll_button.addTarget(self, action: #selector(self.viewDetail), for: .touchUpInside)
            
            //CELL SHADOW
            
            cell.leftCornerRadiusView_View.layer.masksToBounds = true
            
            cell.leftCornerRadiusView_View.layer.cornerRadius = 45
            
            cell.leftSideImageView_View.layer.masksToBounds = false
            
            cell.leftSideImageView_View.layer.shadowColor = UIColor.lightGray.cgColor
            
            cell.leftSideImageView_View.layer.shadowOpacity = 1.0
            
            cell.leftSideImageView_View.layer.shadowOffset = CGSize(width: 1,height:1)
            
            cell.leftSideImageView_View.layer.shadowRadius = 2
            
            
            cell.leftProductViewAll_button.layer.cornerRadius = cell.leftProductViewAll_button.frame.height/2
            
            cell.leftProductImage_ImageView.layer.masksToBounds = true
            
            cell.leftProductImage_ImageView.layer.cornerRadius = cell.leftProductImage_ImageView.frame.height/2
            
            cell.leftProductImage_ImageView.layer.borderWidth = 2
            
            cell.leftProductImage_ImageView.layer.borderColor = UIColor(red: 233/255, green:  26/255, blue:  0/255, alpha: 1.0).cgColor
            // fetch
            
            cell.leftProductDescription_label.text = (self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "name") as? String
            
            cell.leftProductDiscount_label.text = ""//"Offers -  Rs." + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + " Off"
            
            //            if (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_type") as! Int) == 1{
            //
            //                cell.leftProductDiscount_label.text = "Offers - " + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + "%  Off"
            //
            //            }else if (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_type") as! Int) == 2{
            //
            //                cell.leftProductDiscount_label.text = "Offers - Rs." + String(describing: (((((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "categorynamerangeproduct")as? NSDictionary)?.value(forKey: "categoryrangeProductoffer")as? NSDictionary)?.value(forKey: "categoryrangerangevoucher")as? NSDictionary)?.value(forKey: "discount_price"))!) + " Off"
            //
            //            }else{
            //
            //                cell.leftProductDiscount_label.text = ""
            //
            //            }
            
            //  image
            if ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String) == "<null>" || ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image")) is NSNull {
                
                cell.rightProductImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                cell.rightProductImage_ImageView.setImageWith(NSURL(string: categoryImage_url + ((self.subCategory.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            return cell
        }
    }
    
    @objc  func viewDetail(sender:UIButton){
        
        print(self.cat_id)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OffersSecondPageViewController") as! OffersSecondPageViewController
        
        vc.cat_id = self.cat_id
        
        vc.parentVC = "OfferViewController"
        
        vc.sub_cat = String(describing:(((self.subCategory.object(at: sender.tag) as? NSDictionary)?.value(forKey: "id"))!))
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

