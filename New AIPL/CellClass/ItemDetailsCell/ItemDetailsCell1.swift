//
//  ItemDetailsCell1.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class ItemDetailsCell1: UITableViewCell {

    //MARK:- Variables
    //MARK:-
          
    lazy var stack1 : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0.5
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    lazy var viewItem = UIView()
    lazy var viewCATTGT = UIView()
    lazy var viewCurrentFinancial = UIView()
    lazy var viewTotal = UIView()
    lazy var viewCurrentMonthValue = UIView()
    lazy var viewTotal1 = UIView()
    
    lazy var viewBottom1 = UIView()
    lazy var viewBottom2 = UIView()
    lazy var viewBottom3 = UIView()
    lazy var viewBottom4 = UIView()
    lazy var viewBottom5 = UIView()
    lazy var viewBottom6 = UIView()
    
    lazy var lbl_Item = UILabel()
    lazy var lbl_CATTGT = UILabel()
    lazy var lbl_CurrentFinancial = UILabel()
    lazy var lbl_Total = UILabel()
    lazy var lbl_CurrentMonthValue = UILabel()
    lazy var lbl_Total1 = UILabel()
    
    let obj = CommonClass.sharedInstance
    
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
                        addSubview(stack1)
                        setConstriant()
                    }
      required init?(coder aDecoder: NSCoder) {
                     fatalError("init(coder:) has not been implemented")
              }
        
        //MARK:- Configure Cell component
        //MARK:-
           
        func setConstriant(){
               
            stack1.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
            stack1.heightAnchor.constraint(greaterThanOrEqualToConstant: 55).isActive = true
            
            stack1.addArrangedSubview(viewItem)
            stack1.addArrangedSubview(viewCATTGT)
            stack1.addArrangedSubview(viewCurrentFinancial)
            stack1.addArrangedSubview(viewTotal)
            stack1.addArrangedSubview(viewCurrentMonthValue)
            stack1.addArrangedSubview(viewTotal1)
            
            commonConstraint(mainView: viewItem, bottomView: viewBottom1, lbl: lbl_Item, backColor: obj.commonAppLightblueColor)
            commonConstraint(mainView: viewCATTGT, bottomView: viewBottom2, lbl: lbl_CATTGT, backColor: obj.commonAppLightblueColor)
            commonConstraint(mainView: viewCurrentFinancial, bottomView: viewBottom3, lbl: lbl_CurrentFinancial, backColor: obj.commonAppLightblueColor)
            commonConstraint(mainView: viewTotal, bottomView: viewBottom4, lbl: lbl_Total, backColor: obj.commonAppLightblueColor)
            commonConstraint(mainView: viewCurrentMonthValue, bottomView: viewBottom5, lbl: lbl_CurrentMonthValue, backColor: obj.commonAppLightblueColor)
            commonConstraint(mainView: viewTotal1, bottomView: viewBottom6, lbl: lbl_Total1, backColor: obj.commonAppLightblueColor)
            
        }
        
        func commonConstraint(mainView:UIView,bottomView:UIView,lbl:UILabel,backColor:UIColor){
            
            mainView.backgroundColor = backColor
            mainView.addSubview(lbl)
            mainView.addSubview(bottomView)
            lbl.numberOfLines = 0
            lbl.textAlignment = .center
            lbl.scrollAnchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
            bottomView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
                                         bottomView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
                                         bottomView.heightAnchor.constraint(equalToConstant: 1),
                                         bottomView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.7)])
            
        }
    
    func setColorOnBottomView(color1:UIColor,color2:UIColor){
        
        viewBottom1.backgroundColor = color1
        viewBottom2.backgroundColor = color2
        viewBottom3.backgroundColor = color2
        viewBottom4.backgroundColor = color2
        viewBottom5.backgroundColor = color2
        viewBottom6.backgroundColor = color2
        
     }
    
    func setColorOnCellView(color1:UIColor,color2:UIColor){
        
        viewItem.backgroundColor = color1
        viewTotal.backgroundColor = color2
        viewCATTGT.backgroundColor = color2
        viewTotal1.backgroundColor = color2
        viewCurrentFinancial.backgroundColor = color2
        viewCurrentMonthValue.backgroundColor = color2
        
    }
}

