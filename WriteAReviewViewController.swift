//
//  WriteAReviewViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 24/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

import HCSStarRatingView

class WriteAReviewViewController: UIViewController,UITextViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var productImage_ImageView: UIImageView!
    
    @IBOutlet weak var productTitle_label: UILabel!
    
    @IBOutlet weak var packSize_label: UILabel!
    
    @IBOutlet weak var quantity_label: UILabel!
    
    @IBOutlet weak var price_label: UILabel!
    
    @IBOutlet weak var statusDetail_label: UILabel!
    
    @IBOutlet var starRating_view: HCSStarRatingView!
    
    @IBOutlet weak var reviewTitle_label: SkyFloatingLabelTextField!
    
    @IBOutlet weak var feedback_TextView: UITextView!
    
    @IBOutlet weak var submitReview_button: UIButton!
    
    
    
    //MARK:Variable
    
    var productId = "4"
    
    var validation = Validation()
    
    var conn = webservices()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        feedback_TextView.delegate = self
        
        submitReview_button.layer.masksToBounds = true
        
        submitReview_button.layer.cornerRadius = submitReview_button.frame.height/2
        
        self.starRating_view.addTarget(self, action: #selector(didchange), for:.valueChanged )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Write a Review"
        
        self.setNavBar()
        
        self.productTitle_label.text = singleton.sharedInstance.reviewProductTitle
        
        self.packSize_label.text = singleton.sharedInstance.reviewPackSize
        
        self.price_label.text = singleton.sharedInstance.reviewPriceDetail
        
        self.quantity_label.text = singleton.sharedInstance.reviewQuantityDetail
        
        self.statusDetail_label.text = singleton.sharedInstance.deliveryStatus
        
        self.productImage_ImageView.setImageWith((NSURL(string : productImage_url + singleton.sharedInstance.reviewImage) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
    }
    //MARK: Textview delegate
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        
        if feedback_TextView.text == "Write Feedback/Message"{
            
            feedback_TextView.text = ""
            
            feedback_TextView.textColor = UIColor.black
            
            return true
            
        }else{
            
             feedback_TextView.textColor = UIColor.black
            
            return true
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if feedback_TextView.text.isEmpty{
            
            feedback_TextView.text = "Write Feedback/Message"
            
            feedback_TextView.textColor = UIColor.lightGray
        }
        
    }
    //MARK:rating func
    
    @objc func didchange(){
        
        print(self.starRating_view.value)
        
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
        
        
    }
    
    @objc func btn2Action(){
        
        self.tabBarController?.selectedIndex = 2
        
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
    
    
    @IBAction func submitReview_Button(_ sender: UIButton) {
        
        //Name
        if reviewTitle_label.text!.isEmpty{
            
            self.alertWithHandler(message: "Name cannot be empty"){
                
                self.reviewTitle_label.becomeFirstResponder()
                
            }
            
        }else
            
            if reviewTitle_label.text!.replacingOccurrences(of: " ", with: "") == "" {
                
                self.alertWithHandler(message: "Invalid Name"){
                    
                    self.reviewTitle_label.becomeFirstResponder()
                    
                }
                
            }else
                
                if self.validation.isValidCharacters(reviewTitle_label.text!) == false{
                    
                    self.alertWithHandler(message: "Invalid Name"){
                        
                        self.reviewTitle_label.becomeFirstResponder()
                        
                    }
                    
                }else if feedback_TextView.text! == "Write Feedback/Message"{
                    
                    self.alertWithHandler(message: "Please write something"){
                        
                        self.feedback_TextView.becomeFirstResponder()
                        
                    }
                    
                }else if feedback_TextView.text!.replacingOccurrences(of: " ", with: "") == "" {
                    
                    self.alertWithHandler(message: "Only space not allowed"){
                        
                        self.feedback_TextView.text = ""
                        
                        self.feedback_TextView.becomeFirstResponder()
                   
                    }
                    
                }else{
                    
                    self.connection()
        
        }
        
    }
    
    
    //MARK: Connection Review
    
    func connection() {
        
        var parameters : [NSString: NSObject] = [:]
        
        parameters = ["product_id": productId as NSObject ,
                      "message" : feedback_TextView.text! as NSObject ,
                      "rating": self.starRating_view.value as NSObject ,
                      "title" : reviewTitle_label.text! as NSObject,
                      "user_id": ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int)! as NSObject ]
        
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
        
        self.conn.startConnectionWithSting("insert_into_order_review", method_type: .post, params: parameters as [NSString : NSObject]) {
            
            (receivedData) in
            
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1 {
                
                if  receivedData.value(forKey: "response") as! Bool {
                    
                    self.alert(message: "Review Added successfully")
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                }
                
                
            }else {
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    
    
}

