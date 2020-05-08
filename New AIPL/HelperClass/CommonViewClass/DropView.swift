//
//  DropView.swift
//  AIPL
//
//  Created by apple on 07/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import iOSDropDown
class DropView: UIView {

    let MainView : UIView = {
        
        let view = UIView()
        
        return view
    }()

    let dropTxtFld : DropDown = {
        
        let txtFld = DropDown()
        txtFld.arrowColor = .clear
        txtFld.selectedRowColor = CommonClass.sharedInstance.commonAppRedColor
        return txtFld
    }()
    
    let DropBtn : UIButton = {
        
        let btnDrop = UIButton()
        btnDrop.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btnDrop.contentHorizontalAlignment = .right
        return btnDrop
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }

    
       private func commonInit() {
         
        MainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        MainView.backgroundColor = .white
        MainView.layer.cornerRadius = CGFloat(CommonClass.sharedInstance.commonHeight)/2
        addSubview(MainView)
           
           MainView.addSubview(dropTxtFld)
           dropTxtFld.translatesAutoresizingMaskIntoConstraints = false
           dropTxtFld.scrollAnchor(top: MainView.topAnchor, left: MainView.leftAnchor, bottom: MainView.bottomAnchor, right: MainView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
           dropTxtFld.backgroundColor = .clear
           MainView.addSubview(DropBtn)
           DropBtn.scrollAnchor(top: MainView.topAnchor, left: MainView.leftAnchor, bottom: MainView.bottomAnchor, right: MainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
         
       }
    
}
