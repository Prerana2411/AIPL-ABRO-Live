//
//  MonthlyTargetReportVC.swift
//  AIPL ABRO
//
//  Created by CST on 28/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class MonthlyTargetReportVC: UIViewController {

    //MARK:-
    
    let navView : UIView = {
        
        let view = UIView()
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        return view
    }()
    
    let leftBtn :UIButton = {
        
        let btn = UIButton()
        btn.tag = 1
        btn.setImage(UIImage(named: "back1"), for: .normal)
        btn.contentMode = .center
       //btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
        
    }()
    
    let titleHeader:UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    lazy var MonthView = UIView()
    lazy var txt_Month = UITextField()
    lazy var btn_Month = UIButton()
    
    lazy var YearView = UIView()
    lazy var txt_Year = UITextField()
    lazy var btn_Year = UIButton()
    
    lazy var btn_Show = UIButton()
    
    lazy var stack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    
    lazy var CustomerView = UIView()
    lazy var txt_Customer = UITextField()
    lazy var btn_Customer = UIButton()
    
    lazy var CityView = UIView()
    lazy var txt_City = UITextField()
    lazy var btn_City = UIButton()
    
    lazy var StateView = UIView()
    lazy var txt_State = UITextField()
    lazy var btn_State = UIButton()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
