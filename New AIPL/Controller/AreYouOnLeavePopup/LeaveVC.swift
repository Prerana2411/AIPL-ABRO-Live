//
//  LeaveVC.swift
//  AIPL ABRO
//
//  Created by CST on 15/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class LeaveVC: UIViewController {

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
    lazy var messageLbl = UILabel()
    lazy var btn_Yes = UIButton()
    lazy var btn_No = UIButton()
    let obj = CommonClass.sharedInstance
    var nav = UINavigationController()
    var delegate : RemarkVCDelegate?
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    //MARK:- LifeCycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        mainView.popup(inView:view,width:view.frame.width - 40,height:150)
        
        mainView.layer.cornerRadius = 8
        
        mainView.addSubview(headerLbl)
        mainView.addSubview(messageLbl)
        mainView.addSubview(btn_Yes)
        mainView.addSubview(btn_No)
        
        headerLbl.lbl_Constraint(top: mainView.topAnchor, left: mainView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 20, paddingLeft: 15, paddingRight: 0)
        messageLbl.lbl_Constraint(top: headerLbl.bottomAnchor, left: mainView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 12, paddingLeft: 15, paddingRight: 0)
        
        btn_No.translatesAutoresizingMaskIntoConstraints = false
        btn_Yes.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([btn_No.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15),
                                     btn_No.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15),
                                     btn_No.widthAnchor.constraint(equalToConstant: 70),
                                     btn_No.heightAnchor.constraint(equalToConstant: 35)
        ])
        NSLayoutConstraint.activate([btn_Yes.rightAnchor.constraint(equalTo: btn_No.leftAnchor, constant: -15),
                                     btn_Yes.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15),
                                     btn_Yes.widthAnchor.constraint(equalToConstant: 70),
                                     btn_Yes.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        setDataOnScreen()
    }
    
    //MARK:- Custom Method To SetDataOnScreen
    private func setDataOnScreen(){
        
        setFontandColor(lbl: headerLbl, color: .black, font: obj.MediumFont, size: obj.semiBoldfontSize, text: "You are not started your day on time")
        setFontandColor(lbl: messageLbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Are you on leave today?")
        setDataOnButton(btn: btn_No, text: "No", font: obj.MediumFont, size: obj.semiBoldfontSize, color: obj.commonAppRedColor)
        setDataOnButton(btn: btn_Yes, text: "Yes", font: obj.MediumFont, size: obj.semiBoldfontSize, color: obj.commonAppblueColor)
        btn_Yes.contentHorizontalAlignment = .right
        
        btn_Yes.tag = 1
        btn_No.tag = 2
        btn_Yes.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        btn_No.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
    }
    
    //MARK:- Custom Method To Set Font and Color
       
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat,text:String){
        
           lbl.text = obj.createString(Str: text)
           lbl.textColor = color
           lbl.font = UIFont.appCustomFont(fontName: font, size: size)
           
    }
    
    func setDataOnButton(btn:UIButton,text:String,font:String,size:CGFloat,color:UIColor){
        
        btn.backgroundColor = .clear
        btn.setTitle(obj.createString(Str: text), for: .normal)
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = UIFont(name: font, size: size)
    }
    
    //MARK:- Tap_Button_Action
    //MARK:-
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
          apiaddDayStart( apiType:"addDayStart")
            
        }else if sender.tag == 2{
            
            weak var pvc = self.presentingViewController
            self.dismiss(animated: false, completion:{
                
                let vc = RemarkVC()
                vc.modalPresentationStyle = .overFullScreen
                vc.nav = self.nav
                pvc?.present(vc, animated: true, completion: nil)
                
            })
            
        }
    }
    
    //MARK:- Api addDayStart Call
     
     func apiaddDayStart(apiType strUrl:String){
         
         if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? "",
                            "salesPersonName":userData.value(forKey: "Name") ?? "",
                            "dayDate":formatter.string(from: date),
                            "leaveStatus":"yes"
                ] as [String:Any]
            
             print(passData)
            
             Indicator.shared.showProgressView(self.view)
            
            StartDayViewModel().getDataFromApiHandlerClassForStartDay(url: strUrl, passDict: passData, imageData: NSData()) { (responseMessage) in
                
                self.alertWithHandler(message: responseMessage) {
                    
                    self.dismiss(animated: false) {
                        
                        self.delegate?.callCheckDayStartApi?()
                    }
                }
                
            }
//            
//             StartDayViewModel().getDataFromApiHandlerClassForStartDay(url: strUrl, passDict: passData, imageData: NSData(), complitionBlock: { (_) in
//             
//                  self.dismiss(animated: false, completion:{
//                      UserDefaults.standard.set(true, forKey: "isDayStarted")
//                    })
//                 
//             }) { (message) in
//                 
//                 self.alert(message: self.obj.createString(Str: message))
//                 
//             }

         }else{
              self.alert(message: obj.createString(Str: "Please check your internet connection"))
         }
         
     }
    
    func alert(message : String)
       {
           let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
           
       }
       
       func alertWithHandler(message : String , block:  @escaping ()->Void ){
           
           let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: {(action : UIAlertAction) in
               
               block()
               
           }))
           
           self.present(alert, animated: true, completion: nil)
           
       }
}
