//
//  Non-MovingCell.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class Non_MovingCell: UITableViewCell {

    
    //MARK:- Variables
    //MARK:-
    
    lazy var stack1 : UIStackView = {
                 
                 let stack = UIStackView()
                 stack.axis = .horizontal
                 stack.spacing = 0
                 stack.distribution = .fillEqually
                 stack.alignment = .fill
                 return stack
                 
    }()
    lazy var stack2 : UIStackView = {
                    
                    let stack = UIStackView()
                    stack.axis = .horizontal
                    stack.spacing = 1
                    stack.distribution = .fillEqually
                    stack.alignment = .fill
                    return stack
                    
    }()
    lazy var mainView = UIView()
    lazy var lbl_NameHeader = UILabel()
    lazy var lbl_Name = UILabel()
    lazy var lbl_AddressHeader = UILabel()
    lazy var lbl_Address = UILabel()
    lazy var lbl_ContackNumHeader = UILabel()
    lazy var lbl_ContackNum = UILabel()
    lazy var lbl_AmountHeader = UILabel()
    lazy var lbl_Amount = UILabel()
    lazy var lbl_LastInvoiceDateHeader = UILabel()
    lazy var lbl_LastInvoiceDate = UILabel()
    
    lazy var viewForAddress = UIView()
    lazy var viewForContactNum = UIView()
    
    lazy var btnForAddress = UIButton()
    lazy var btnForContactNum = UIButton()
    let obj = CommonClass.sharedInstance
    //MARK:- LifeCycle
    //MARK:-
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
        mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 110).isActive = true
        mainView.backgroundColor = CommonClass.sharedInstance.commonAppLightblueColor
        
        mainView.addSubview(stack1)
        mainView.addSubview(stack2)
        stack1.withoutBottomAnchorHeightGreater(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 60)
        stack2.scrollAnchor(top: stack1.bottomAnchor, left: stack1.leftAnchor, bottom: mainView.bottomAnchor, right: stack1.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        stack2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stack1.addArrangedSubview(lbl_NameHeader)
        stack1.addArrangedSubview(lbl_AddressHeader)
        stack1.addArrangedSubview(lbl_ContackNumHeader)
        stack1.addArrangedSubview(lbl_AmountHeader)
        stack1.addArrangedSubview(lbl_LastInvoiceDateHeader)
        
        commonContraint(view: viewForAddress, item: lbl_Address)
        commonContraint(view: viewForAddress, item: btnForAddress)
        commonContraint(view: viewForContactNum, item: lbl_ContackNum)
        commonContraint(view: viewForContactNum, item: btnForContactNum)
        
        btnForAddress.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btnForContactNum.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        
        btnForAddress.contentHorizontalAlignment = .right
        btnForContactNum.contentHorizontalAlignment = .right
        
        stack2.addArrangedSubview(lbl_Name)
        stack2.addArrangedSubview(viewForAddress)
        stack2.addArrangedSubview(viewForContactNum)
        stack2.addArrangedSubview(lbl_Amount)
        stack2.addArrangedSubview(lbl_LastInvoiceDate)
        
        lblFontColor(lbl: lbl_NameHeader, text: "Name", backColor: .clear, textAlignment: .center)
        lblFontColor(lbl: lbl_AddressHeader, text: "Addres", backColor: .clear, textAlignment: .center)
        lblFontColor(lbl: lbl_ContackNumHeader, text: "Contact No.", backColor: .clear, textAlignment: .center)
        lblFontColor(lbl: lbl_AmountHeader, text: "Amount", backColor: .clear, textAlignment: .center)
        lblFontColor(lbl: lbl_LastInvoiceDateHeader, text: "Last Invoive Date", backColor: .clear, textAlignment: .center)
        
        
        lblFontColor(lbl: lbl_Name, text: "Prince", backColor: .white, textAlignment: .center)
        lblFontColor(lbl: lbl_Address, text: "Beat", backColor: .white, textAlignment: .left)
        lblFontColor(lbl: lbl_ContackNum, text: "Beat", backColor: .white, textAlignment: .left)
        lblFontColor(lbl: lbl_Amount, text: "Remark", backColor: .white, textAlignment: .center)
        lblFontColor(lbl: lbl_LastInvoiceDate, text: "2/24/19", backColor: .white, textAlignment: .center)
        
    }
    
    func commonContraint(view:UIView,item:UIView){
        
        view.addSubview(item)
        view.backgroundColor = .white
        item.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
    }
    
    func lblFontColor(lbl:UILabel,text:String,backColor:UIColor,textAlignment:NSTextAlignment){
        
        lbl.text = obj.createString(Str: text)
        lbl.font = UIFont(name: obj.RegularFont, size: 14)
        lbl.textColor = obj.commonAppTextDrakColor
        lbl.numberOfLines = 0
        lbl.backgroundColor = backColor
        lbl.textAlignment = textAlignment
    }
    
}
