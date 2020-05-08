//
//  PlannerView.swift
//  AIPL
//
//  Created by apple on 08/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class PlannerView: UIView {

     let MainView : UIView = {
           
           let view = UIView()
           
           return view
       }()

       let dropTxtFld : UILabel = {
           
           let lbl = UILabel()
           lbl.numberOfLines = 0
           lbl.textAlignment = .center
           return lbl
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
            
              MainView.frame = CGRect(x: 0, y: 0, width: 70, height: CGFloat(CommonClass.sharedInstance.commonHeight))
              MainView.backgroundColor = .white
              addSubview(MainView)
              
              MainView.addSubview(dropTxtFld)
              dropTxtFld.translatesAutoresizingMaskIntoConstraints = false
              dropTxtFld.scrollAnchor(top: MainView.topAnchor, left: MainView.leftAnchor, bottom: MainView.bottomAnchor, right: MainView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 20)
              dropTxtFld.backgroundColor = .clear
              MainView.addSubview(DropBtn)
              DropBtn.scrollAnchor(top: MainView.topAnchor, left: MainView.leftAnchor, bottom: MainView.bottomAnchor, right: MainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10)
            
          }

}
