//
//  PostedPlannerCell.swift
//  AIPL
//
//  Created by apple on 09/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import DropDown

class PostedPlannerCell: UITableViewCell {
    
    
    //MARK:- Variable
    //MARK:-
    
    lazy var mainView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
    }()
    
    lazy var ItemCategory_View = UIView()
    lazy var Select_ItemCategory = UITextField()
    lazy var ItemCategory_lbl_header = UILabel()
    lazy var ItemCategory_btn  : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var Select_View1 = UIView()
    lazy var Select_lbl = UITextField()
    lazy var Item_lbl_header = UILabel()
    lazy var Select_btn  : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var TextFld_View = UIView()
    lazy var TextFld = UITextField()
   
    lazy var HStack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    let obj = CommonClass.sharedInstance
    var dropDown = DropDown()
    var getRetailerViewModel = RetailerViewModel()
    var delegate:PostedPlannerCellDelegate?
    var type = String()
    var itemCategoryCode = String()
    var indicatorView = UIView()
    
    //MARK:- LifeCycle
    //MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
        addSubview(mainView)
        //configureComponent()
        
        ItemCategory_btn.addTarget(self, action: #selector(selectBtnAction), for: .touchUpInside)
        Select_btn.addTarget(self, action: #selector(itemSelectAction), for: .touchUpInside)
        Select_lbl.setFontandColor(txtFld: Select_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        Select_ItemCategory.setFontandColor(txtFld: Select_ItemCategory, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponent()
         TextFld.delegate = self
    }
    
    //MARK:- Configure UIComponent
    //MARK:-
    
    func configureComponent(){
        
        mainView.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mainView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        mainView.addSubview(ItemCategory_lbl_header)
        ItemCategory_lbl_header.lbl_Constraint(top: mainView.topAnchor, left: mainView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        mainView.addSubview(ItemCategory_View)
        ItemCategory_View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ItemCategory_View.topAnchor.constraint(equalTo: ItemCategory_lbl_header.bottomAnchor, constant: 10),
                                     ItemCategory_View.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10)])
        commonConstraint(insideView: ItemCategory_View, lblSelect: Select_ItemCategory, btnDrop: ItemCategory_btn, isButtonHidden: false)
        mainView.addSubview(Item_lbl_header)
        
        Item_lbl_header.lbl_Constraint(top: ItemCategory_View.bottomAnchor, left: mainView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        commonConstraintForStack(view: mainView, stack: HStack, lblHeader: Item_lbl_header)
        HStack.addArrangedSubview(Select_View1)
        HStack.addArrangedSubview(TextFld_View)
        commonConstraint(insideView: (Select_View1), lblSelect: Select_lbl, btnDrop: Select_btn, isButtonHidden: false)
        commonConstraint(insideView: (TextFld_View), lblSelect: TextFld, btnDrop: UIButton(), isButtonHidden: true)
        
        NSLayoutConstraint.activate([ItemCategory_View.widthAnchor.constraint(equalTo: Select_View1.widthAnchor, multiplier: 1),
                                     ItemCategory_View.heightAnchor.constraint(equalTo: Select_View1.heightAnchor, multiplier: 1)])
    }
    
    func commonConstraintForStack(view:UIView,stack:UIView,lblHeader:UIView){
        
        view.addSubview(stack)
        
        stack.withoutBottomAnchor(top: lblHeader.bottomAnchor, left: lblHeader.leftAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingRight: 10, height: CGFloat(obj.commonHeight))
        
        
    }
    func commonConstraint(insideView:UIView,lblSelect:UIView,btnDrop:UIButton,isButtonHidden:Bool){
           
           insideView.addSubview(lblSelect)
           insideView.addSubview(btnDrop)
           insideView.backgroundColor = .white
           insideView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
           insideView.layer.borderWidth = 1.0
           insideView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           lblSelect.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: insideView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
           
        if isButtonHidden == false{
            
           btnDrop.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: insideView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 12)
            
          }
           
       }
    
    //MARK:- Btn Action
    //MARK:-
    @objc func selectBtnAction(sender:UIButton){
         
        type = "itemCategory"
        
        if self.getRetailerViewModel.ItemCategorysArr.count > 0{
            
           self.dropDownDataSource(dataSource: self.getRetailerViewModel.ItemCategorysArr, txtFld:self.Select_ItemCategory , anchorView: self.ItemCategory_View)
        }
             
        
    }
    
    @objc func itemSelectAction(){
        
        type = "item"
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["itemCategory":itemCategoryCode] as [String:Any]
            Indicator.shared.showProgressView(indicatorView)
            getRetailerViewModel.apiitemList(urlStr: "itemList", passDict: passDict) { (responseMessage) in
                
                if responseMessage == "Data found"{
                    
                    self.dropDownDataSource(dataSource: self.getRetailerViewModel.itemDiscriptionArr, txtFld:self.Select_lbl , anchorView: self.Select_View1)
                    
                }
                
            }
            
        }
        
    }
    
    //MARK:- DropDown DataSource
    //MARK:-
    func dropDownDataSource(dataSource:[String],txtFld:UITextField,anchorView:UIView){
        
        
        DispatchQueue.main.async {
            
            if dataSource.count > 0 {
                
                if self.dropDown.dataSource.count > 0 {
                    
                    self.dropDown.dataSource.removeAll()
                }
                
                self.getRetailerViewModel.dropDownDelegate(textField: txtFld,view:anchorView, dropDown: self.dropDown)
                self.dropDown.dataSource = dataSource
                self.getRetailerViewModel.delegate = self
                self.dropDown.show()
                
            }
        }
        
    }
  }

//MARK:- NewRetailerVCDelegate and UITextFieldDelegate Call

extension PostedPlannerCell:NewRetailerVCDelegate,UITextFieldDelegate{
    
    func index(index: Int, text: String) {
        
        if self.type == "itemCategory"{
           
            print(self.ItemCategory_btn.tag)
            self.delegate?.itemCategory(text: text, index: index, btnTag: self.ItemCategory_btn.tag)
            
            self.itemCategoryCode = getRetailerViewModel.itemCodeArr[index]
            
        }else if self.type == "item"{
            
            self.delegate?.item(text: text, index: Select_btn.tag)
        }
        
    }
     
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(textField.text!)
        
        self.delegate?.quantity(text: textField.text!, index: TextFld.tag)
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        ((self.delegate?.quantity(text: textField.text!, index: TextFld.tag)) != nil)
        
        return true
    }
}
