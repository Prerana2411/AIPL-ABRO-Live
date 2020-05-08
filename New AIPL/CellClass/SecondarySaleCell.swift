//
//  SecondarySaleCell.swift
//  AIPL ABRO
//
//  Created by CST on 17/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown

class SecondarySaleCell: UITableViewCell {

    
    //MARK:- Varibale
    //MARK:-
    
    lazy var mainView = UIView()
    lazy var lbl_Date = UILabel()
    lazy var lbl_RetailerName = UILabel()
    lazy var lbl_ItemCategory = UILabel()
    lazy var lbl_Item = UILabel()
    lazy var lbl_Status = UILabel()
    lazy var lbl_Value = UITextField()
    lazy var btn_Save = UIButton()
    lazy var btn_Status = UIButton()
   
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    lazy var view3 = UIView()
    lazy var view4 = UIView()
    lazy var view5 = UIView()
    lazy var view6 = UIView()
    lazy var view7 = UIView()
    lazy var view8 = UIView()
    lazy var view9 = UIView()
    lazy var view10 = UIView()
    lazy var view11 = UIView()
    let obj = CommonClass.sharedInstance
    let dropDown = DropDown()
    var delegate : NewRetailerVCDelegate?
    var delegate1 : ValueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           selectionStyle = .none
            contentView.backgroundColor = .white
           addSubview(mainView)
           setConstriant()
       }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Configure Cell component
    //MARK:-
    
    func setConstriant(){
        
        mainView.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mainView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mainView.backgroundColor = CommonClass.sharedInstance.commonAppLightblueColor
        
        commonConstraint(view: mainView, item: lbl_Date, left: mainView.leftAnchor, width: 0.1)
        commonConstraint(view: mainView, item: lbl_RetailerName, left: lbl_Date.rightAnchor, width: 0.25)
        commonConstraint(view: mainView, item: lbl_ItemCategory, left: lbl_RetailerName.rightAnchor, width: 0.2)
        commonConstraint(view: mainView, item: lbl_Item, left: lbl_ItemCategory.rightAnchor, width: 0.2)
        commonConstraint(view: mainView, item: lbl_Status, left: lbl_Item.rightAnchor, width: 0.15)
        commonConstraint(view: mainView, item: lbl_Value, left: lbl_Status.rightAnchor, width: 0.1)
      
        boderConstraint(view: mainView, item: lbl_Date, view1: view1, view2: UIView())
        boderConstraint(view: mainView, item: lbl_RetailerName, view1: view2, view2: view3)
        boderConstraint(view: mainView, item: lbl_ItemCategory, view1: view4, view2: view5)
        boderConstraint(view: mainView, item: lbl_Status, view1: view6, view2: view7)
        boderConstraint(view: mainView, item: lbl_Value, view1: view8, view2: view9)
        boderConstraint(view: mainView, item: lbl_Item, view1: view10, view2: view11)
        
        
        mainView.addSubview(btn_Status)
        
        btn_Status.scrollAnchor(top: lbl_Status.topAnchor, left: lbl_Status.leftAnchor, bottom: lbl_Status.bottomAnchor, right: lbl_Status.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        btn_Status.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btn_Status.contentHorizontalAlignment = .right
        btn_Status.addTarget(self, action: #selector(self.getOrderStatus), for: .touchUpInside)
        lbl_Status.textAlignment = .left
        lbl_RetailerName.backgroundColor = .white
        lbl_ItemCategory.backgroundColor = .white
        lbl_Status.backgroundColor = .white
        lbl_Value.backgroundColor = .white
        lbl_Value.textAlignment = .center
        lbl_Value.textColor = obj.commonAppTextDrakColor
        lbl_Value.isUserInteractionEnabled = false
        lbl_Value.delegate = self
    }
    
    func commonConstraint(view:UIView,item:UIView,left:NSLayoutXAxisAnchor,width:CGFloat) {
        
        view.addSubview(item)
        
        item.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([item.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                     item.leftAnchor.constraint(equalTo: left, constant: 0),
                                     item.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width),
                                     item.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)])
        
        
        
    }
    
    func boderConstraint(view:UIView,item:UIView,view1:UIView,view2:UIView)  {
        
        view.addSubview(view1)
               view1.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([view1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                                            view1.centerXAnchor.constraint(equalTo: item.centerXAnchor, constant: 0),
                                            view1.widthAnchor.constraint(equalTo: item.widthAnchor, multiplier: 0.7),
                                            view1.heightAnchor.constraint(equalToConstant: 1)])
       view.addSubview(view2)
               view2.translatesAutoresizingMaskIntoConstraints = false
                       NSLayoutConstraint.activate([view2.leftAnchor.constraint(equalTo: item.leftAnchor, constant: 0),
                                                    view2.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                                    view2.heightAnchor.constraint(equalTo: item.heightAnchor, multiplier: 1),
                                                    view2.widthAnchor.constraint(equalToConstant: 1)])
        
       view2.backgroundColor = obj.commonAppLightblueColor
    }
    
    func setColorOnBottomView(color1:UIColor,color2:UIColor){

       view1.backgroundColor = color1
       view2.backgroundColor = color2
       view8.backgroundColor = color2
       view4.backgroundColor = color2
       view10.backgroundColor = color2
       view6.backgroundColor = color2

    }
    
    //MARK:- DropDown DataSource
    //MARK:-
    func dropDownDataSource(dataSource:[String],txtFld:UILabel,anchorView:UIView){
        
        
        DispatchQueue.main.async {
            
            if dataSource.count > 0 {
                
                if self.dropDown.dataSource.count > 0 {
                    
                    self.dropDown.dataSource.removeAll()
                }
                
                self.dropDownDelegate(textField: txtFld,view:anchorView, dropDown: self.dropDown)
                self.dropDown.dataSource = dataSource
                self.dropDown.show()
                
            }
        }
        
    }
    
    func dropDownDelegate(textField:UILabel,view:UIView,dropDown:DropDown)  {
      
           dropDown.anchorView = view
           dropDown.animationEntranceOptions = .allowAnimatedContent
           dropDown.backgroundColor = obj.commonAppRedColor
           dropDown.textColor = UIColor.white
           dropDown.textFont = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize) ?? UIFont()
           dropDown.selectionAction = { [weak self] (index: Int, item: String) in
               
               textField.text = item
               //self?.text = index
            
            item == "Yes" ? (self?.lbl_Value.isUserInteractionEnabled = true) : (self?.lbl_Value.isUserInteractionEnabled = false)
            
            self?.delegate?.index(index: (self?.btn_Status.tag)!, text: item)
           }
           
       }
    
    @objc func getOrderStatus(){
        
        dropDownDataSource(dataSource: ["Yes","No"], txtFld: lbl_Status, anchorView: lbl_Status)
    }
}

extension SecondarySaleCell:UITextFieldDelegate{
    
        func textFieldDidEndEditing(_ textField: UITextField) {
           
            print(textField.text!)
            self.delegate1?.getValue(text: textField.text!, index: self.lbl_Value.tag)
           
       }
}
