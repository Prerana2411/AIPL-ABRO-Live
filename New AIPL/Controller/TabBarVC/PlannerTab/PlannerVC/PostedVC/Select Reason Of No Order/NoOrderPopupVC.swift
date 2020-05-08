//
//  NoOrderPopupVC.swift
//  AIPL ABRO
//
//  Created by CST on 06/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class NoOrderPopupVC: UIViewController {

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
    
   lazy var VStack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    lazy var btnStockAvailable = UIButton()
    lazy var btnStockNotAvailable = UIButton()
    lazy var btnHighPrice = UIButton()
    lazy var btnQualityIssue = UIButton()
    lazy var btnOthers = UIButton()
    lazy var btnSubmit = UIButton()
    var flag = Bool()
    var nav = UINavigationController()
    var delegate : NoOrderPopupVCDelegate?
    var OrderNotRec_Reason = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setStringOnUIElements()
        
        //Add Tap Gesture
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        
        self.transView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        headerLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([headerLbl.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30),
                                     headerLbl.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15)])
        mainView.addSubview(VStack)
        
        VStack.withoutBottomAnchorHeightGreater(top: headerLbl.bottomAnchor, left: headerLbl.leftAnchor, right: mainView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingRight: 15, height: 200)
        
        VStack.addArrangedSubview(btnStockAvailable)
        VStack.addArrangedSubview(btnStockNotAvailable)
        VStack.addArrangedSubview(btnHighPrice)
        VStack.addArrangedSubview(btnQualityIssue)
        VStack.addArrangedSubview(btnOthers)
        
        mainView.addSubview(btnSubmit)
        
        btnSubmit.withoutBottomAnchor(top: VStack.bottomAnchor, left: VStack.leftAnchor, right: VStack.rightAnchor, paddingTop: 15, paddingLeft: 50, paddingRight: 50, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        btnSubmit.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive = true
        
    }

    internal func setStringOnUIElements(){
        
        headerLbl.setFontAndColor(lbl: headerLbl, text: CommonClass.sharedInstance.createString(Str: "Select the Reason of No Orders:"), textColor: .black, font: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        commonBtnFunc(btn: btnStockAvailable, text: "   Stock Available at Retailer", tag: 1)
        commonBtnFunc(btn: btnStockNotAvailable, text: "   Stock Not Available at Our End", tag: 2)
        commonBtnFunc(btn: btnHighPrice, text: "   High Price", tag: 3)
        commonBtnFunc(btn: btnQualityIssue, text: "   Quality Issue", tag: 4)
        commonBtnFunc(btn: btnOthers, text: "   Others", tag: 5)
         btnSubmit.setDataOnButton(btn: btnSubmit, text: "Submit", font: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize, textcolor: .white, image: UIImage(), backGroundColor: CommonClass.sharedInstance.commonAppRedColor, aliment: .center)
         btnSubmit.layer.cornerRadius = CGFloat(CommonClass.sharedInstance.commonHeight)/2
        
        btnSubmit.tag = 6
        btnSubmit.addTarget(self, action:#selector(btnClick(sender:)), for: .touchUpInside)
    }
    
    func commonBtnFunc(btn:UIButton,text:String,tag:Int){
        
        btn.setDataOnButton(btn: btn, text: text, font: CommonClass.sharedInstance.RegularFont, size: CommonClass.sharedInstance.regularfontSize, textcolor: CommonClass.sharedInstance.commonAppTextDrakColor, image: #imageLiteral(resourceName: "uncheck_radio"), backGroundColor: .clear, aliment: .left)
       
        btn.tag = tag
        btn.addTarget(self, action:#selector(btnClick(sender:)), for: .touchUpInside)
    }
    
    // MARK:- Tap Gesture Action
    //MARK:-
    
    @objc func tapGestureAction(){
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            flag = false
            
           // self.OrderNotRec_Reason = sender.titleLabel!.text!
            self.OrderNotRec_Reason = "1"
            commonBtnSelectMethod(btn1: sender, btn2: btnStockNotAvailable, btn3: btnHighPrice, btn4: btnQualityIssue, btn5: btnOthers)
            
        }else if sender.tag == 2{
            flag = false
           // self.OrderNotRec_Reason = sender.titleLabel!.text!
            
            self.OrderNotRec_Reason = "2"
            
            commonBtnSelectMethod(btn1: sender, btn2: btnStockAvailable, btn3: btnHighPrice, btn4: btnQualityIssue, btn5: btnOthers)
        }else if sender.tag == 3{
            flag = true
            self.OrderNotRec_Reason = "3"
            commonBtnSelectMethod(btn1: sender, btn2: btnStockAvailable, btn3: btnStockNotAvailable, btn4: btnQualityIssue, btn5: btnOthers)
        }else if sender.tag == 4{
            flag = true
            self.OrderNotRec_Reason = "4"
            commonBtnSelectMethod(btn1: sender, btn2: btnStockAvailable, btn3: btnHighPrice, btn4: btnStockNotAvailable, btn5: btnOthers)
        }else if sender.tag == 5{
            flag = false
            self.OrderNotRec_Reason = "5"
            commonBtnSelectMethod(btn1: sender, btn2: btnStockAvailable, btn3: btnHighPrice, btn4: btnStockNotAvailable, btn5: btnQualityIssue)
        }else if sender.tag == 6{
            
            if flag == true{
                
                weak var pvc = self.presentingViewController
                self.dismiss(animated: false, completion:{
                    
                    let vc = RemarkVC()
                    vc.modalPresentationStyle = .overFullScreen
                    vc.nav = self.nav
                    vc.remarkType = "Remarks:"
                    vc.delegate = self
                    pvc?.present(vc, animated: true, completion: nil)
                    
                })
                
            }else{
                
                self.dismiss(animated: false) {
                    
                    self.delegate?.value(OrderNotRec_Reason: self.OrderNotRec_Reason.trim(), OrderNotRec_Remarks: "")
                    
                }
                
            }
            
        }
        
    }
    
    func commonBtnSelectMethod(btn1:UIButton,btn2:UIButton,btn3:UIButton,btn4:UIButton,btn5:UIButton){
        
        btn1.setImage(#imageLiteral(resourceName: "checked_radio"), for: .normal)
        btn2.setImage(#imageLiteral(resourceName: "uncheck_radio"), for: .normal)
        btn3.setImage(#imageLiteral(resourceName: "uncheck_radio"), for: .normal)
        btn4.setImage(#imageLiteral(resourceName: "uncheck_radio"), for: .normal)
        btn5.setImage(#imageLiteral(resourceName: "uncheck_radio"), for: .normal)
        
    }
}

extension NoOrderPopupVC:RemarkVCDelegate{
    
    func remark(endDay remarks: String) {
        
        self.delegate?.value(OrderNotRec_Reason: self.OrderNotRec_Reason.trim(), OrderNotRec_Remarks: remarks)
        
    }
     
}
