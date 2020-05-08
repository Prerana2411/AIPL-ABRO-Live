//
//  LateDayStartVC.swift
//  AIPL
//
//  Created by apple on 07/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LateDayStartVC: UIViewController {

    //MARK:- Variable
    //MARK:-
    var bookingData = [String:Any]()
    
    let mainView:UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
        
    }()
    
    let transView:UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
        
    }()
    
    let lbl_Header : UILabel = {
        
        let lbl = UILabel()
        return lbl
        
    }()
    let lbl_Message : UILabel = {
        
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
        
    }()
    let btn_No : UIButton = {
           
           let btn = UIButton()
         //  btn.titleLabel?.font = UIFont.appCustomFont(fontName: "SourceSansPro-Semibold", size: 14)
        btn.setTitle(CommonClass.sharedInstance.createString(Str: "No"), for: .normal)
           btn.setTitleColor(CommonClass.sharedInstance.commonAppRedColor, for: .normal)
           btn.contentHorizontalAlignment = .center
           btn.tag = 2
          // btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
       }()
       let btn_Yes : UIButton = {
           
           let btn = UIButton()
         //  btn.titleLabel?.font = UIFont.appCustomFont(fontName: "SourceSansPro-Semibold", size: 14)
           btn.setTitle(CommonClass.sharedInstance.createString(Str: "Yes"), for: .normal)
           btn.setTitleColor(CommonClass.sharedInstance.commonAppblueColor, for: .normal)
           btn.contentHorizontalAlignment = .right
           btn.tag = 1
          // btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.configureComponent()
    }
    
    //MARK:- Configure UIComponent
    //MARK:-
    
    func configureComponent(){
        
        view.backgroundColor = .clear
        
        view.addSubview(transView)
        view.addSubview(mainView)
        
        self.transView.scrollAnchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        self.mainView.center(inView: self.view)
        NSLayoutConstraint.activate([self.mainView.widthAnchor.constraint(equalToConstant: (self.view.bounds.width - 30)),
                                     self.mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 165)])
        
        self.mainView.addSubview(lbl_Header)
        self.mainView.addSubview(lbl_Message)
        self.mainView.addSubview(btn_No)
        self.mainView.addSubview(btn_Yes)
        
        lbl_Header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_Header.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
                                     lbl_Header.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15)])
        lbl_Message.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_Message.topAnchor.constraint(equalTo: lbl_Header.bottomAnchor, constant: 20),
                                     lbl_Message.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15),
                                     lbl_Message.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40)])
       
        
        
        btn_No.translatesAutoresizingMaskIntoConstraints = false
        btn_No.anchor(top: lbl_Message.bottomAnchor, left: btn_Yes.rightAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 25, paddingLeft: 8, paddingBottom: 15, paddingRight: 15, width: 80, height: 40)
        btn_Yes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_Yes.centerYAnchor.constraint(equalTo: btn_No.centerYAnchor),
                                     btn_Yes.widthAnchor.constraint(equalToConstant: 80),
                                     btn_Yes.heightAnchor.constraint(equalToConstant: 40)])
        setString()
        
    }
    
    //Custom Method to Set Title on UIElements
    //MARK:-
    func setString(){
        
        let obj = CommonClass.sharedInstance
        setFontandColor(lbl: lbl_Header, color: UIColor.black, text: "You are not started your day on time")
        setFontandColor(lbl: lbl_Message, color: obj.commonAppTextDrakColor, text: "Are you on leave today?")
    }
    
   //MARK:- Custom Method To Set Font and Color
   
    func setFontandColor(lbl:UILabel,color:UIColor,text:String){
       
       lbl.textColor = color
       lbl.text = text
     //  lbl.font = UIFont.appCustomFont(fontName: <#T##String#>, size: <#T##CGFloat#>)
       
   }
    

}
