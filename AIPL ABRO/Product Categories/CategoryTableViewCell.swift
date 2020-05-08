//
//  CategoryTableViewCell.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 22/02/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: oulets
    
    @IBOutlet weak var categoryView_View: UIView!
    
    @IBOutlet weak var categoryName_label: UILabel!
    
    @IBOutlet weak var plus_Imageview: UIImageView!
    
    @IBOutlet weak var subCategory_TableView: UITableView!
    
    @IBOutlet weak var subCategoryTable_height: NSLayoutConstraint!
    
    //MARK:variables
    
    var subCategoryArr : NSArray = []
    
        
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subCategoryArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = subCategory_TableView.dequeueReusableCell(withIdentifier: "subCategory_Identifier") as! SubCategoryTableViewCell
        
        cell.subCategoryName_label.text = (self.subCategoryArr.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
        
        //subCategoryTable_height.constant = CGFloat(69 * subCategoryArr.count)
        
       // subCategory_TableView.layer.masksToBounds = true
        
       // subCategory_TableView.layer.cornerRadius = 8
        
       // subCategory_TableView.giveShadowinnerview(Outlet: subCategory_TableView)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "call_controller"), object: nil, userInfo: [ "selectedIndex" : (indexPath.row) , "id" : (subCategoryArr.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "category_id") as! Int , "sub_id" : (subCategoryArr.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "id") as! Int])
        
          singleton.sharedInstance.sub_category = subCategoryArr
        
        print(subCategoryArr)
        
    }

}
