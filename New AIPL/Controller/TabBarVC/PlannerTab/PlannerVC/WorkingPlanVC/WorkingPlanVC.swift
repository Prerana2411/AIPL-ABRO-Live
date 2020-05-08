//
//  WorkingPlanVC.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class WorkingPlanVC: UIViewController {

    //MARK:- Variable
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
           btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
           
       }()
       
       let titleHeader:UILabel = {
           
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        return lbl
       }()
    
     lazy var view2 = UIView()
     lazy var HQView = UIView()
     lazy var lbl_HQ = UITextField()
     lazy var HQ_lbl_header = UILabel()
     lazy var HQ_btn  = UIButton()
    
     lazy var view3 = UIView()
     lazy var SegmentView = UIView()
     lazy var lbl_Segment_header = UILabel()
     lazy var Segment_btn  = UIButton()
     lazy var lbl_Segment = UITextField()
     
     lazy var view4 = UIView()
     lazy var CityView = UIView()
     lazy var lbl_City = UITextField()
     lazy var lbl_City_header = UILabel()
     lazy var City_btn  = UIButton()
     
     lazy var view5 = UIView()
     lazy var BeatView = UIView()
     lazy var lbl_Beat_header = UILabel()
     lazy var Beat_btn  = UIButton()
     lazy var lbl_Beat = UITextField()
    
    lazy var Go_btn  = UIButton()
    
    lazy var stack1 : UIStackView = {
              
              let stack = UIStackView()
              stack.axis = .horizontal
              stack.spacing = 15
              stack.distribution = .fillEqually
              stack.alignment = .fill
              return stack
              
          }()
       
       lazy var stack2 : UIStackView = {
           
           let stack = UIStackView()
           stack.axis = .horizontal
           stack.spacing = 15
           stack.distribution = .fillEqually
           stack.alignment = .fill
           return stack
           
       }()
    var contentViewSize = CGSize()
    // ScrollView
    lazy var scrollView:UIScrollView = {
        
        let sv = UIScrollView(frame: .zero)
        sv.bounces = false
        sv.backgroundColor = .clear
        sv.alwaysBounceHorizontal = true
        return sv
        
    }()
    
    lazy var insideView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    lazy var tableView = UITableView()
    
    let sectionHeaderArr = ["Non-Moving Customers:","Overdue Customers:","Regular Customers:","Discontinued Customers:","Pending C-Form Customers:","Retailer's List:"]
    
    let retailerListArr = ["Retailers Name","HQ","State","City","Beat","Cust Type","Address","Email","Mobile","Contact Person","Segment","Sales Person","Tagged Customer","Classification","Potential","GST Number","Competitor Brand","Amount"]
    
    let obj = CommonClass.sharedInstance
    
    //MARK:- Life Cycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setUpNavi()
    }
    //MARK:- Method to set Navi On Screen
    //MARK:-
       internal func setUpNavi(){
             
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
    
        
        addStack(stack: stack1, stackTop: navView.bottomAnchor, stackLeft: view.leftAnchor, stackRight: view.rightAnchor, view2: view2, view3: view3, lblHeader: HQ_lbl_header, txt: lbl_HQ, btn: HQ_btn, viewdrop: HQView, lblHeader1: lbl_City_header, txt1: lbl_City, btn1: City_btn, viewdrop1: CityView)
        addStack(stack: stack2, stackTop: stack1.bottomAnchor, stackLeft: view.leftAnchor, stackRight: view.rightAnchor, view2: view4, view3: view5, lblHeader: lbl_Beat_header, txt: lbl_Beat, btn: Beat_btn, viewdrop: BeatView, lblHeader1: lbl_Segment_header, txt1: lbl_Segment, btn1: Segment_btn, viewdrop1: SegmentView)
        
        
        view.addSubview(Go_btn)
        Go_btn.withoutBottomAnchor(top: stack2.bottomAnchor, left: stack2.leftAnchor, right: stack2.rightAnchor, paddingTop: 20, paddingLeft: 60, paddingRight: 60, height: CGFloat(obj.commonHeight))
        Go_btn.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        view.addSubview(scrollView)
         scrollView.scrollAnchor(top: Go_btn.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        lblFontColor(lbl: HQ_lbl_header, text: "HQ:", textSize: 15)
        lblFontColor(lbl: lbl_Segment_header, text: "Segment:", textSize: 15)
        lblFontColor(lbl: lbl_City_header, text: "Travel City:", textSize: 15)
        lblFontColor(lbl: lbl_Beat_header, text: "Beats:", textSize: 15)
        
        setFontColor(txt: lbl_HQ, btn: HQ_btn, text: "Select", view: HQView)
        setFontColor(txt: lbl_Segment, btn: Segment_btn, text: "Select", view: SegmentView)
        setFontColor(txt: lbl_City, btn: City_btn, text: "Select", view: CityView)
        setFontColor(txt: lbl_Beat, btn: Beat_btn, text: "Select", view: BeatView)
        
         titleHeader.text = obj.createString(Str: "Work Plan")
        titleHeader.font = UIFont(name: obj.BoldFont, size: obj.BoldfontSize)
         titleHeader.textColor = .white
        
        Go_btn.backgroundColor = obj.commonAppRedColor
        Go_btn.setTitle(obj.createString(Str: "Go"), for: .normal)
        Go_btn.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        
        configTable()
        
    }
    
    
    func addStack(stack:UIStackView,stackTop:NSLayoutYAxisAnchor,stackLeft:NSLayoutXAxisAnchor,stackRight:NSLayoutXAxisAnchor,view2:UIView,view3:UIView,lblHeader:UILabel,txt:UITextField,btn:UIButton,viewdrop:UIView,lblHeader1:UILabel,txt1:UITextField,btn1:UIButton,viewdrop1:UIView){
           
           view.addSubview(stack)
           stack.withoutBottomAnchor(top: stackTop, left: stackLeft, right: stackRight, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: CGFloat(obj.commonHeight + 5 + 15))
           
           stack.addArrangedSubview(view2)
           stack.addArrangedSubview(view3)
           
           commonStackView(mainView: view2, lbl_header: lblHeader, view: viewdrop, txt: txt, btn: btn, isbuttonHidden: false)
           commonStackView(mainView: view3, lbl_header: lblHeader1, view: viewdrop1, txt: txt1, btn: btn1, isbuttonHidden: false)
           
       }
    
    func commonStackView(mainView:UIView,lbl_header:UILabel,view:UIView,txt:UITextField,btn:UIButton,isbuttonHidden:Bool){
           
           mainView.addSubview(lbl_header)
                  mainView.addSubview(view)
                 
                  lbl_header.lbl_Constraint(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, isRight: false, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
                  view.withoutBottomAnchor(top: lbl_header.bottomAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight))
                  view.addSubview(txt)
                  txt.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
                 
                  txt.isUserInteractionEnabled = true
                  view.backgroundColor = .white
                 
                  
                  if isbuttonHidden == false{
                      view.addSubview(btn)
                             btn.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
                      
                  }
                  view.layer.cornerRadius = CGFloat(obj.commonHeight)/2
       }
    
    //MARK:- Set Font and Color
    
    func setFontColor(txt:UITextField,btn:UIButton,text:String,view:UIView){
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 0.5
        view.layer.masksToBounds = false
        
       
        txt.text = obj.createString(Str: text)
        txt.textColor = obj.commonAppTextDrakColor
        txt.font = UIFont(name: obj.RegularFont, size: 16)
        
        btn.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        btn.contentHorizontalAlignment = .right
        
    }
    
    func lblFontColor(lbl:UILabel,text:String,textSize:CGFloat){
        
        lbl.text = obj.createString(Str: text)
        lbl.font = UIFont(name: obj.RegularFont, size: textSize)
        lbl.textColor = obj.commonAppTextDrakColor
        
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
        }
        
    }
}

//MARK:- Configure tableView
//MARK:-

extension WorkingPlanVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
     
      
     
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceHorizontal = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = .clear
        self.tableView.bounces = false
        self.tableView.isScrollEnabled = false
        print(tableView.contentSize.height)
        self.tableView.backgroundColor = .clear
        contentViewSize = CGSize(width: navView.frame.width, height: tableView.contentSize.height + 10)
        scrollView.addSubview(insideView)
        scrollView.contentSize = contentViewSize
        insideView.frame.size = contentViewSize
        tableView.removeFromSuperview()
        insideView.addSubview(tableView)
       
        tableView.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: insideView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         let vw = UIView()
         vw.backgroundColor = .clear
         vw.heightAnchor.constraint(equalToConstant: 50).isActive = true
         let lbl_Section_Header = UILabel()
         lblFontColor(lbl: lbl_Section_Header, text: sectionHeaderArr[section], textSize: 15)
         vw.addSubview(lbl_Section_Header)
         lbl_Section_Header.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([lbl_Section_Header.leftAnchor.constraint(equalTo: vw.leftAnchor, constant: 0),
                                     lbl_Section_Header.centerYAnchor.constraint(equalTo: vw.centerYAnchor, constant: 0)])
         return vw
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionHeaderArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section <= 4{
           
           self.tableView.register(Non_MovingCell.self, forCellReuseIdentifier: "\(Non_MovingCell.self)")
            
           return 1
            
        }else if section == 5{
            
            self.tableView.register(RetailerListCell.self, forCellReuseIdentifier: "\(RetailerListCell.self)")
            
            return retailerListArr.count
        }
       
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section <= 4 {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(Non_MovingCell.self)", for: indexPath) as! Non_MovingCell
                   
            return cell
            
        }else if indexPath.section == 5{
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(RetailerListCell.self)", for: indexPath) as! RetailerListCell
            
            lblFontColor(lbl: cell.lbl_RetailerName, text: retailerListArr[indexPath.row], textSize: 13)
            
            return cell
        }
        
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section <= 4{
            
           return 110
        }else if indexPath.section == 5 {
            
           return 55
        }
        
        return 0.0
    }
}
