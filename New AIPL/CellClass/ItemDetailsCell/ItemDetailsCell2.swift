//
//  ItemDetailsCell2.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class ItemDetailsCell2: UITableViewCell {

    //MARK:- Variable
    
    lazy var mainView = UIView()
    lazy var lblNonMoving = UILabel()
    lazy var lblAmount = UILabel()
    lazy var btnTotal = UIButton()
    
    lazy var viewBottom1 = UIView()
    lazy var viewBottom2 = UIView()
    lazy var viewBottom3 = UIView()
    
    lazy var stack1 : UIStackView = {
           
           let stack = UIStackView()
           stack.axis = .horizontal
        stack.spacing = 0.5
           stack.distribution = .fillEqually
           stack.alignment = .fill
           return stack
           
    }()
    let obj = CommonClass.sharedInstance
    //MARK:- Life Cycle
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
        contentView.backgroundColor = obj.commonAppLightblueColor
        addSubview(mainView)
        setConstriant()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
          
    //MARK:- Configure Cell component
    //MARK:-
    
    internal func setConstriant(){
      
        mainView.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 55).isActive = true
        
        mainView.addSubview(lblNonMoving)
        lblNonMoving.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lblNonMoving.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
                                     lblNonMoving.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
                                     lblNonMoving.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
                                     lblNonMoving.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)])
        mainView.addSubview(stack1)
        stack1.scrollAnchor(top: mainView.topAnchor, left: lblNonMoving.rightAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        stack1.addArrangedSubview(lblAmount)
        stack1.addArrangedSubview(btnTotal)
        commonConstraint(item: lblNonMoving, bottomView: viewBottom1, width: 0.97, left: 0)
        commonConstraint(item: lblAmount, bottomView: viewBottom2, width: 0.8, left: 15)
        commonConstraint(item: btnTotal, bottomView: viewBottom3, width: 0.8, left: 15)
        
    }
    
    func commonConstraint(item:UIView,bottomView:UIView,width:CGFloat,left:CGFloat){
        
        mainView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bottomView.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: 0),
                                     bottomView.leftAnchor.constraint(equalTo: item.leftAnchor, constant: left),
                                     bottomView.heightAnchor.constraint(equalToConstant: 1),
                                     bottomView.rightAnchor.constraint(equalTo: item.rightAnchor, constant: -15)])
      
        
        
    }
    
    func setColorOnBottomView(color1:UIColor,color2:UIColor){
        
        viewBottom1.backgroundColor = color1
        viewBottom2.backgroundColor = color2
        viewBottom3.backgroundColor = color2
        
        
     }
    
    func setColorOnCellView(color1:UIColor,color2:UIColor){
        
        lblNonMoving.backgroundColor = color1
        lblAmount.backgroundColor = color2
        btnTotal.backgroundColor = color2
        
        
    }
}
