//
//  RemarkVC.swift
//  AIPL ABRO
//
//  Created by CST on 15/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class RemarkVC: UIViewController {
    
    //MARK:- Variable
    //MARK:-
    
    lazy var mainView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    lazy var transView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
        
    }()
    
    lazy var headerLbl = UILabel()
    lazy var txtView_Remark = UITextView()
    lazy var btn_Submit = UIButton()
    let obj = CommonClass.sharedInstance
    var nav = UINavigationController()
    var remarkType = String()
    var delegate : RemarkVCDelegate?
    
    //MARK:- LifeCycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(btnClick(sender:)))
        transView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        configureUIElements()
    }
    
    
    //MARK:- Configure UIElements
    //MARK:-
    
    private func configureUIElements(){
        
        view.backgroundColor = .clear
        self.navigationController?.isNavigationBarHidden = true
        
        view.addSubview(transView)
        view.addSubview(mainView)
        
        transView.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        mainView.popup(inView:view,width:view.frame.width - 40,height:200)
        
        mainView.layer.cornerRadius = 8
        
        mainView.addSubview(headerLbl)
        mainView.addSubview(txtView_Remark)
        mainView.addSubview(btn_Submit)
        headerLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([headerLbl.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30),
                                     headerLbl.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)])
        
        txtView_Remark.withoutBottomAnchor(top: headerLbl.bottomAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15, height: 100)
        
        btn_Submit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_Submit.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
                                     btn_Submit.topAnchor.constraint(equalTo: txtView_Remark.bottomAnchor, constant: 15),
                                     btn_Submit.widthAnchor.constraint(equalToConstant: view.frame.width - 180),
                                     btn_Submit.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     btn_Submit.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -25)])
        
        setDataOnScreen()
    }
    
    //MARK:- Custom Method To SetDataOnScreen
    private func setDataOnScreen(){
        
        setFontandColor(lbl: headerLbl, color: .black, font: obj.MediumFont, size: obj.semiBoldfontSize, text: self.remarkType == "" ? "Remarks" : self.remarkType)
        txtView_Remark.text = obj.createString(Str: "Enter your remark...")
        txtView_Remark.textColor = obj.commonAppTextLightColor
        txtView_Remark.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        txtView_Remark.layer.cornerRadius = 8
        txtView_Remark.borderColor = obj.commonAppTextLightColor
        txtView_Remark.borderWidth = 0.5
        setDataOnButton(btn: btn_Submit, text: "Submit", font: obj.MediumFont, size: obj.semiBoldfontSize, color: obj.commonAppRedColor)
        btn_Submit.tag = 1
        btn_Submit.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
    }
    
    //MARK:- Custom Method To Set Font and Color
    
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat,text:String){
        
        lbl.text = obj.createString(Str: text)
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    func setDataOnButton(btn:UIButton,text:String,font:String,size:CGFloat,color:UIColor){
        
        btn.backgroundColor = color
        btn.setTitle(obj.createString(Str: text), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: font, size: size)
        btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
    }
    
    //MARK:- Tap_Button_Action
    //MARK:-
    
    @objc func btnClick(sender:AnyObject){
        
        if sender.tag == 1 {
           
            if remarkType != "" {
                
                self.dismiss(animated: false) {
                    
                    self.delegate?.remark(endDay: self.txtView_Remark.text)
                    
                }
                
            }else{
                
                self.dismiss(animated: false) {
                    
                    let vc = StartYourDayVC()
                    vc.remark = self.txtView_Remark.text
                    self.nav.pushViewController(vc, animated: false)
                    
                }
                
            }
            
            
        }
        else{
            
            self.dismiss(animated: false, completion: nil)
            
        }
         
    }
}

//MARK:- 
