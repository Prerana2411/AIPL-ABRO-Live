//
//  NewRetailerView.swift
//  AIPL ABRO
//
//  Created by CST on 16/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class NewRetailerView: UIView {

    //MARK:- Variable
    //MARK:-
    let lbl = UILabel()
    let dropView = DropView()
    
    let MainView = UIView()
    
   override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
       private func commonInit() {
         
        MainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 30, height: CGFloat(CommonClass.sharedInstance.commonHeight+15))
        MainView.backgroundColor = .white
        MainView.layer.cornerRadius = CGFloat(CommonClass.sharedInstance.commonHeight)/2
        addSubview(MainView)
        
        MainView.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lbl_Constraint(top: MainView.topAnchor, left: MainView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 0, paddingLeft: 5, paddingRight: 0)
        
        MainView.addSubview(dropView)
        
        dropView.MainView.frame = CGRect(x: MainView.bounds.origin.x + 5, y: lbl.frame.origin.y+15, width: MainView.bounds.width, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        
        
       }

}
