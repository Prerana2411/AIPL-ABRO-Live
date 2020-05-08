//
//  DistributedCell.swift
//  AIPL ABRO
//
//  Created by CST on 17/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown

class DistributedCell: UITableViewCell {

    //MARK:- Varibale
    //MARK:-
       
    lazy var mainView = UIView()
    lazy var lbl_Date = UILabel()
    lazy var lbl_RetailerName = UITextField()
    lazy var txt_Value = UITextField()
    lazy var btn_RetailerName = UIButton()
    let obj = CommonClass.sharedInstance
    var getRetailerViewModel = RetailerViewModel()
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    lazy var view3 = UIView()
    lazy var view4 = UIView()
    let dropDown = DropDown()
    var getSecDistViewModel = SecondaryDistributorViewModel()
    var delegate : retailerNameTypeDelegate?
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
        commonConstraint(view: mainView, item: lbl_RetailerName, left: lbl_Date.rightAnchor, width: 0.7)
        commonConstraint(view: mainView, item: txt_Value, left: lbl_RetailerName.rightAnchor, width: 0.2)
        txt_Value.textAlignment = .center
        boderConstraint(view: mainView, item: lbl_Date, view1: view1, view2: UIView())
        boderConstraint(view: mainView, item: lbl_RetailerName, view1: view2, view2: view3)
        boderConstraint(view: mainView, item: txt_Value, view1: view4, view2: UIView())
        view2.widthAnchor.constraint(equalTo: lbl_RetailerName.widthAnchor, multiplier: 0.85).isActive = true
        mainView.addSubview(btn_RetailerName)
        btn_RetailerName.scrollAnchor(top: mainView.topAnchor, left: lbl_RetailerName.leftAnchor, bottom: lbl_RetailerName.bottomAnchor, right: lbl_RetailerName.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
        btn_RetailerName.contentHorizontalAlignment = .right
        btn_RetailerName.addTarget(self, action: #selector(RetailerName), for: .touchUpInside)
        self.txt_Value.delegate = self
        
        self.lbl_RetailerName.placeholder = "Retailer Name"
        self.txt_Value.placeholder = "Quantity"
        
    }
    
    
    @objc func RetailerName(){

        dropDownDataSource(dataSource: self.getSecDistViewModel.getRetailerArr, txtFld: lbl_RetailerName, anchorView: lbl_RetailerName)

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
        
        view1.backgroundColor = obj.tableDarkGray
        view2.backgroundColor = obj.commonAppLightblueColor
    }
    
    //MARK:- DropDown DataSource
    //MARK:-
    func dropDownDataSource(dataSource:[String],txtFld:UITextField,anchorView:UIView){
        
        
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
    
    func dropDownDelegate(textField:UITextField,view:UIView,dropDown:DropDown)  {
    
         dropDown.anchorView = view
         dropDown.animationEntranceOptions = .allowAnimatedContent
         dropDown.backgroundColor = obj.commonAppRedColor
         dropDown.textColor = UIColor.white
         dropDown.textFont = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize) ?? UIFont()
         dropDown.selectionAction = { [weak self] (index: Int, item: String) in
             
             textField.text = item
//             self?.text = index
            self?.delegate?.retailerName(index: self?.btn_RetailerName.tag ?? 0, type: "RetailerName", text: item, indexPath: index)
         }
         
     }
    
    func apidistributerRetailer(taggedCustomerCode:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["taggedCustomerCode":taggedCustomerCode] as [String:Any]
            
            self.getSecDistViewModel.getRetailerListDataFormApiHandler(strUrl: "distributerRetailer", passDict: passDict) { (responseMessage) in
                
                if responseMessage == "Data found"{
                    
                    self.dropDownDataSource(dataSource: self.getSecDistViewModel.getRetailerArr, txtFld: self.lbl_RetailerName, anchorView: self.lbl_RetailerName)
                    
                }
                
            }
            
        }
    }
}

//MARK:- UITextFieldDelegate
//MARK:-
extension DistributedCell:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(textField.text!)
        self.delegate?.retailerName(index: self.btn_RetailerName.tag, type: "Value", text: textField.text!,indexPath: 0)
        
    }
    
}
