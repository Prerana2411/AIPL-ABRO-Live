//
//  PostedPlannerCell2.swift
//  AIPL ABRO
//
//  Created by CST on 13/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class PostedPlannerCell2: UITableViewCell {

    //MARK:-Variables
    //MARK:-
    
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    lazy var lbl = UILabel()
    lazy var txtFld = UITextField()
    
    lazy var HStack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    
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
        addSubview(HStack)
        
        txtFld.setFontandColor(txtFld: txtFld, color: CommonClass.sharedInstance.commonAppTextDrakColor, font: CommonClass.sharedInstance.RegularFont, size: CommonClass.sharedInstance.regularfontSize, text: "Enter")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Configure components
    //MARK:-
    
    func configureComponent(){
        
        HStack.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        HStack.addArrangedSubview(view1)
        HStack.addArrangedSubview(view2)
        
        commonConstraints(mainView: view1, item: lbl)
        commonConstraints(mainView: view2, item: txtFld)
        view2.layer.borderWidth = 1.0
        view2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view1.backgroundColor = .clear
        view2.backgroundColor = .white
        
        lbl.numberOfLines = 0
    }
    
    func commonConstraints(mainView:UIView,item:UIView){
        
        mainView.addSubview(item)
        mainView.layer.cornerRadius = 25
        item.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
    }
}
