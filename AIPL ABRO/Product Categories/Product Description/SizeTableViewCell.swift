//
//  SizeTableViewCell.swift
//  AIPL ABRO
//
//  Created by promatics on 2/24/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

protocol TotalPrice {
    
    func get_total_price(totalPrice:NSMutableArray,pack_id:Int,Qty:NSMutableArray)
}

class SizeTableViewCell: UITableViewCell, UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Outlets
    
    @IBOutlet weak var sizeChild_TableView: UITableView!
    
    @IBOutlet weak var childTable_height: NSLayoutConstraint!
    
    
    @IBOutlet weak var blueTick_ImageView: UIImageView!
    
    @IBOutlet weak var minus_ImageView: UIImageView!
    
    @IBOutlet weak var plus_ImageView: UIImageView!
    
    @IBOutlet weak var Quantity_TextField: UITextField!
    
    @IBOutlet weak var quantity_Button: UIButton!
    
    
    @IBOutlet weak var price_Label: UILabel!
    
    @IBOutlet weak var minus_btn: UIButton!
    
    @IBOutlet weak var plus_btn: UIButton!
    //
    var data : NSArray = []
    
    var keys : NSArray = []
    
    var key = NSMutableArray()
    
    var id = Int()
    
    var i : Int = 0
    
    var delegate : TotalPrice?
    
    var pack_id : Int =  0
    
    var price = ""
    
    var discountDetails : NSDictionary = [:]
    
    var description_price = ""
    
    var oldPricee = NSMutableArray()
    
    var newPricee = NSMutableArray()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //  self.Quantity_TextField.text = "0"
        
        //  self.price_Label.text = ""
        
        //    self.price_Label.isHidden = true
        
        
        //
        //        for i in 0..<self.keys.count{
        //
        //            if String(describing: keys.object(at: i))  == "id"{
        //
        //
        //            }else{
        //
        //                key.add(String(describing: keys.object(at: i)))
        //
        //            }
        //
        //            // key.add(keys.object(at : i) as
        //
        //        }
        
        if singleton.sharedInstance.addToCart == false{
            
            self.price_Label.isHidden = true
            
            
        }else{
            
            self.price_Label.isHidden = false
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func minus_btn(_ sender: UIButton) {
        
        i =  Int(Quantity_TextField.text!)!
        
        if i > 0{
            
            
            
            i = i - 1
            
            singleton.sharedInstance.quantitydetail = String(describing: i)
            
            Quantity_TextField.text = String(describing : i)
            
            // let product :Int = (((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: "price")as? Int)! * i)
            
            let product :Int = (Int(self.description_price)! * i)
            
            self.price_Label.text = String(describing:(product))
            
            singleton.sharedInstance.quantity.replaceObject(at: self.sizeChild_TableView.tag, with: i)
            
            singleton.sharedInstance.addToCart = true
            
            if singleton.sharedInstance.addToCart == false{
                
                self.price_Label.isHidden = true
                
                
            }else{
                
                self.price_Label.isHidden = false
                
            }
            
            singleton.sharedInstance.total_price.replaceObject(at: self.sizeChild_TableView.tag, with: product)
            
            delegate?.get_total_price(totalPrice: singleton.sharedInstance.total_price,pack_id: self.pack_id,Qty: singleton.sharedInstance.quantity)
            
            self.blueTick_ImageView.isHidden = false
            
            self.sizeChild_TableView.reloadData()
            
            
        }else if i == 0{
            
            
            singleton.sharedInstance.quantity.replaceObject(at: self.sizeChild_TableView.tag, with: 0)
            
            singleton.sharedInstance.addToCart = false
            
            if singleton.sharedInstance.addToCart == false{
                
                self.price_Label.isHidden = true
                
                
            }else{
                
                self.price_Label.isHidden = false
                
            }
            
            singleton.sharedInstance.total_price.replaceObject(at: self.sizeChild_TableView.tag, with: 0)
            
            delegate?.get_total_price(totalPrice: singleton.sharedInstance.total_price,pack_id: self.pack_id,Qty: singleton.sharedInstance.quantity)
            
            self.Quantity_TextField.text = String(describing:(i))
            
            self.blueTick_ImageView.isHidden = true
            
        }else{
            
            
        }
        
    }
    
    @IBAction func plus_btn(_ sender: UIButton) {
        
        i =  Int(Quantity_TextField.text!)!
        
        i = i+1
        
        singleton.sharedInstance.quantitydetail = String(describing:i)
        
        self.Quantity_TextField.text = String(describing:(i))
        
        let product :Int = (Int(self.description_price)! * i)
        
        self.price_Label.text = String(describing:(product)) + ".00"
        
        singleton.sharedInstance.quantity.replaceObject(at: self.sizeChild_TableView.tag, with: i)
        
        singleton.sharedInstance.total_price.replaceObject(at: self.sizeChild_TableView.tag, with: product)
        
        singleton.sharedInstance.addToCart = true
        
        if singleton.sharedInstance.addToCart == false{
            
            self.price_Label.isHidden = true
            
            
        }else{
            
            self.price_Label.isHidden = false
            
        }
        
        delegate?.get_total_price(totalPrice: singleton.sharedInstance.total_price,pack_id: self.pack_id,Qty: singleton.sharedInstance.quantity)
        
        self.sizeChild_TableView.reloadData()
        
        self.blueTick_ImageView.isHidden = false
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //  keys = (data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).allKeys as NSArray
        
        //  return keys.count
        
        return key.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sizeChild_TableView.dequeueReusableCell(withIdentifier: "childTable_Identifier") as! SizeChildTableViewCell
        
        cell.oldPrice_label.isHidden = true
        
        cell.oldPriceCut_View.isHidden = true
        
        cell.read_button.isHidden = true
        
        cell.cutView_View.isHidden = true
        
        self.minus_btn.tag = indexPath.row
        
        self.plus_btn.tag = indexPath.row
        
        cell.read_button.tag = indexPath.row
        
        if indexPath.row == (key.count - 1){
            
            cell.read_button.isHidden = false
            
            cell.cutView_View.isHidden = false
            
        }
        
        cell.read_button.tag = self.sizeChild_TableView.tag
        
        cell.read_button.addTarget(self, action: #selector(tapReadMore_btn(sender:)), for: .touchUpInside)
        
        self.pack_id = ((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey:"id") as? Int)!
        
        
        cell.description_label.text = String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!)
        
        // self.description_price = cell.description_label.text!
        
        if key.object(at: indexPath.row) as? String == "product_code"{
            
            cell.heading_label.text = "Product Code"
            
        }else  if key.object(at: indexPath.row) as? String == "product_name"{
            
            cell.heading_label.text = "Product Name"
            
        }else  if key.object(at: indexPath.row) as? String == "price"{
            
            if self.discountDetails == [:]{
                
                cell.oldPriceCut_View.isHidden = true
                
                cell.oldPrice_label.isHidden = true
                
                self.description_price  = String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!)
                
                self.oldPricee.add(String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!))
                
                self.newPricee.add("")
                
            }else{
                
                
                
                if self.discountDetails.value(forKey: "discount_type") as! Int == 1{
                    
                    
                    cell.oldPriceCut_View.isHidden = true
                    
                    cell.oldPrice_label.isHidden = false
                    
                    
                    cell.oldPrice_label.text = String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!) + ".00"
                    
                    self.oldPricee.add(String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!))
                    
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.oldPrice_label.text!)
                    
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
                    
                    cell.oldPrice_label.attributedText = attributeString
                    
                    cell.description_label.text = String(describing:((Float(((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!) - (Float(((self.discountDetails.value(forKey: "discount_price")as! Int) * ((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!)/100))))) + "0"
                    
                    self.description_price = String(describing:((Int(((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!) - (Int(((self.discountDetails.value(forKey: "discount_price")as! Int) * ((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!)/100)))))
                    
                    self.newPricee.add(self.description_price)
                }
                
                if self.discountDetails.value(forKey: "discount_type") as! Int == 2{
                    
                    cell.oldPriceCut_View.isHidden = false
                    
                    cell.oldPrice_label.isHidden = false
                    
                    cell.description_label.text = String(describing:(Float(((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!) -  Float((self.discountDetails.value(forKey: "discount_price")as! Int)))) + "0"
                    
                    cell.oldPrice_label.text = String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!) + ".00"
                    
                    self.oldPricee.add(String(describing:((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)))!))
                    
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.oldPrice_label.text!)
                    
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
                    
                    cell.oldPrice_label.attributedText = attributeString
                    
                    self.description_price = String(describing:(Int(((data.object(at: self.sizeChild_TableView.tag) as! NSDictionary).value(forKey: (key.object(at: indexPath.row) as! String)) as? Int)!) -  Int((self.discountDetails.value(forKey: "discount_price")as! Int))))
                    
                    self.newPricee.add(self.description_price)
                    
                }
                
                
            }
            
            
            cell.heading_label.text = "Price"
            
        }else  if key.object(at: indexPath.row) as? String == "unit_pack"{
            
            cell.heading_label.text = "Unit/Pack"
            
        }else  if key.object(at: indexPath.row) as? String == "qty_size"{
            
            cell.heading_label.text = "Qty/Size"
            
        }else  if key.object(at: indexPath.row) as? String == "size_dia_thk_box"{
            
            cell.heading_label.text = "Size(Dia*Thk*Box)"
            
        }else  if key.object(at: indexPath.row) as? String == "kg"{
            
            cell.heading_label.text = "Kg"
            
        }else  if key.object(at: indexPath.row) as? String == "litre"{
            
            cell.heading_label.text = "Litre"
            
        }else  if key.object(at: indexPath.row) as? String == "piece"{
            
            cell.heading_label.text = "Piece"
            
        }else  if key.object(at: indexPath.row) as? String == "case"{
            
            cell.heading_label.text = "Case"
            
        }else  if key.object(at: indexPath.row) as? String == "mos_rpm"{
            
            cell.heading_label.text = "Mos Rpm"
            
        }else  if key.object(at: indexPath.row) as? String == "packaging"{
            
            cell.heading_label.text = "Packaging"
            
        }else  if key.object(at: indexPath.row) as? String == "size"{
            
            cell.heading_label.text = "Size"
            
        }else  if key.object(at: indexPath.row) as? String == "standard_packing"{
            
            cell.heading_label.text = "Standard Packing"
            
        }else  if key.object(at: indexPath.row) as? String == "mos"{
            
            cell.heading_label.text = "Mos"
            
        }else  if key.object(at: indexPath.row) as? String == "grits"{
            
            cell.heading_label.text = "Grits"
            
        }else  if key.object(at: indexPath.row) as? String == "colors"{
            
            cell.heading_label.text = "Colors"
            
        }else  if key.object(at: indexPath.row) as? String == "size"{
            
            cell.heading_label.text = "Size"
            
        }else  if key.object(at: indexPath.row) as? String == "adhesive"{
            
            cell.heading_label.text = "Adhesive"
            
        }else  if key.object(at: indexPath.row) as? String == "adhesive_carrier"{
            
            cell.heading_label.text = "Adhesive Carrier"
            
        }else  if key.object(at: indexPath.row) as? String == "thickness"{
            
            cell.heading_label.text = "Thickness"
            
        }else  if key.object(at: indexPath.row) as? String == "tape_color"{
            
            cell.heading_label.text = "Tape Color"
            
        }else  if key.object(at: indexPath.row) as? String == "size_of_roll"{
            
            cell.heading_label.text = "Size Of Roll"
            
        }else  if key.object(at: indexPath.row) as? String == "rolls_ctn"{
            
            cell.heading_label.text = "Rolls Ctn"
            
        }else  if key.object(at: indexPath.row) as? String == "size_mm_mtr"{
            
            cell.heading_label.text = "Size(MM/Mtr)"
            
        }else  if key.object(at: indexPath.row) as? String == "packing_inner_box"{
            
            cell.heading_label.text = "Packing Inner Box"
            
        }else if key.object(at: indexPath.row) as? String == "paking_carton" {
            
            cell.heading_label.text = "Packing Carton"
            
        }else if key.object(at: indexPath.row) as? String == "id" {
            
            cell.heading_label.text = "Product Id"
            
        }else{
            
            cell.heading_label.text = "N/A"
        }
        
        
        
        // (data.object(at: indexPath.row) as? NSDictionary).
        
        //childTable_height.constant = CGFloat(44 * ((data.object(at: 0) as! NSDictionary).count - 1 ) ) + 50
        
        // self.childTable_height.constant = CGFloat(Int(key.count * 44))
        
        self.childTable_height.constant = CGFloat(30*key.count) + 40
        
        return cell
        
    }
    
    @objc func tapReadMore_btn(sender:UIButton){
        
        //  let id = keys.object(at: sender.tag) as! String
        
        //  price = String(describing:((data.object(at: sender.tag) as! NSDictionary).value(forKey: (keys.object(at: sender.tag) as! String)))!)
        
        if self.Quantity_TextField.text == "0"{
            
            singleton.sharedInstance.addToCart = true
            
        }else{
            
            singleton.sharedInstance.addToCart = false
            
        }
        
        let indexx = sender.tag
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readMore"), object: nil, userInfo: [ "id" : pack_id  , "oldPrice" : oldPricee , "newPrice" : newPricee , "index" : indexx ])
        
        
    }
    
}
