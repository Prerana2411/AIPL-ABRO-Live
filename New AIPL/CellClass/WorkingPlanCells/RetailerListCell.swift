//
//  RetailerListCell.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class RetailerListCell: UITableViewCell {

    //MARK:- Variables
    //MARK:-
       
       lazy var stack1 : UIStackView = {
                    
                    let stack = UIStackView()
                    stack.axis = .horizontal
                    stack.spacing = 1
                    stack.distribution = .fillEqually
                    stack.alignment = .fill
                    return stack
                    
       }()
    lazy var viewRetailerName = UIView()
    lazy var viewName1 = UIView()
    lazy var viewName2 = UIView()
    lazy var viewName3 = UIView()
    
    lazy var viewBottom1 = UIView()
    lazy var viewBottom2 = UIView()
    lazy var viewBottom3 = UIView()
    lazy var viewBottom4 = UIView()
    
    lazy var lbl_RetailerName = UILabel()
    lazy var lbl_RetailerName1 = UILabel()
    lazy var lbl_RetailerName2 = UILabel()
    lazy var lbl_RetailerName3 = UILabel()
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
        
        stack1.addArrangedSubview(viewRetailerName)
        stack1.addArrangedSubview(viewName1)
        stack1.addArrangedSubview(viewName2)
        stack1.addArrangedSubview(viewName3)
        
        commonConstraint(mainView: viewRetailerName, bottomView: viewBottom1, lbl: lbl_RetailerName, backColor: obj.commonAppLightblueColor)
        commonConstraint(mainView: viewName1, bottomView: viewBottom2, lbl: lbl_RetailerName1, backColor: .white)
        commonConstraint(mainView: viewName2, bottomView: viewBottom3, lbl: lbl_RetailerName2, backColor: .white)
        commonConstraint(mainView: viewName3, bottomView: viewBottom4, lbl: lbl_RetailerName3, backColor: .white)
        
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
                                     bottomView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.85)])
        bottomView.backgroundColor = obj.tableDarkGray
    }
}
