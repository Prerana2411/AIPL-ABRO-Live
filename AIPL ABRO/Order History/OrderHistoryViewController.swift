//
//  OrderHistoryViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class OrderHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: Outlets
    
    @IBOutlet weak var orderHistory_TableView: UITableView!
    
    var data : NSArray = []
    
    var order_id = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(data)
        
        orderHistory_TableView.delegate = self
        
        orderHistory_TableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.backItem?.title = ""
        
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Order Detail"
        
//        self.navigationController?.navigationBar.backItem?.title = ""
//
//       self.navigationController?.navigationBar.topItem?.title = ""
        
       // self.title = "Order History"
        
        self.setNavBar()
    }
    
    //MARK: Functions
    
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
        
        //////
        
        let btn3 = UIButton(type: .custom)
        
        btn3.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        btn3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        btn3.tag = 0
        
        btn3.addTarget(self, action: #selector(self.btn3Action), for: .touchUpInside)
        
        let item3 = UIBarButtonItem(customView: btn3)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item3
       
    }
    
    @objc func btn2Action(){
        
        self.tabBarController?.selectedIndex = 2
        
    }
    
    @objc func btn3Action(){
        
        self.navigationController?.popViewController(animated: true)
    
    }
    
    //MARK: table delegates datasource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = orderHistory_TableView.dequeueReusableCell(withIdentifier: "orderHistory_Identifier") as! OrderHistoryTableViewCell
        
        cell.reviewAdded_view.isHidden = true
        
        if ((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as? NSDictionary) != nil {
            
            if (((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as? NSDictionary) != nil {
                
                cell.orderTitle_label.text = ((((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as! NSDictionary).value(forKey: "name") as! String)
                
                singleton.sharedInstance.reviewProductTitle = cell.orderTitle_label.text!
                
                cell.orderQuantity_label.text = String(describing:((self.data.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "quantity"))!)
                
                singleton.sharedInstance.reviewQuantityDetail = cell.orderQuantity_label.text!
                
                cell.orderDescription_label.text = "N/A"
                
                singleton.sharedInstance.reviewPackSize = "N/A"
                
                cell.orderPrice_label.text = "Rs " + String(describing:((self.data.object(at: indexPath.row)as? NSDictionary)?.value(forKey: "total"))!)
                
                singleton.sharedInstance.reviewPriceDetail = cell.orderPrice_label.text!
                //
                cell.orderPlaceDate_label.text = singleton.sharedInstance.bookDate
                
                cell.orderDeliveryDate_label.text = singleton.sharedInstance.deliveryDate
                
                cell.deliveryStatus_label.text = singleton.sharedInstance.deliveryStatus
                
                
                cell.image_imageView.setImageWith((NSURL(string : productImage_url + ((((((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as! NSDictionary).value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
                singleton.sharedInstance.reviewImage = ((((((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as! NSDictionary).value(forKey: "All_images") as? NSArray)?.object(at: 0) as? NSDictionary)?.value(forKey: "image")as? String)!
                
                cell.orderPlaceID_label.text = self.order_id
                
                if  ((((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as! NSDictionary).value(forKey: "OrderProductReveiwstatus")is NSNull) {
                    
                    cell.write_button.isHidden = false
                    
                    cell.reviewAdded_view.isHidden = true
                    
                }else{
                    
                    cell.write_button.isHidden = true
                    
                    cell.reviewAdded_view.isHidden = false
                    
                    cell.rating_view.value = CGFloat((((((self.data.object(at: indexPath.row) as! NSDictionary).value(forKey: "productPacksDetails") as! NSDictionary).value(forKey: "productDetail") as! NSDictionary).value(forKey: "OrderProductReveiwstatus")as? NSDictionary)?.value(forKey: "rating")as? Int)!)
                }
                
                cell.write_button.addTarget(self, action: #selector(writeReview), for: .touchUpInside)
                
                cell.containerView_View.shadow(Outlet: cell.containerView_View)
                
            }
            
        }
        
        return cell
    }
    
    @objc func writeReview(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "WriteAReviewViewController") as! WriteAReviewViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }

}
