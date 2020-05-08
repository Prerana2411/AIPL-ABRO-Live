//
//  ItemDetailsVC.swift
//  AIPL ABRO
//
//  Created by CST on 20/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {
    
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
        btn.contentMode = .scaleAspectFill
         btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
        
    }()
    
    let titleHeader:UIImageView = {
        
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "header_logo")
        img.contentMode = .scaleAspectFit
        return img
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
    let obj = CommonClass.sharedInstance
    let getItemDetailsViewModel = ItemDetailsViewModel()
    //MARK:- LifeCycle
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpNavi()
    }
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
        
        view.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: titleHeader, title: UILabel(), isLogoHidden: false)
        view.addSubview(scrollView)
        scrollView.scrollAnchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 15, paddingRight: 0)
        
        configTable()
        //  setString()
    }
     
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
}

//MARK:- Configure tableView
//MARK:-

extension ItemDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    
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
         vw.heightAnchor.constraint(equalToConstant: 15).isActive = true
         return vw
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
           
           self.tableView.register(ItemDetailsCell1.self, forCellReuseIdentifier: "\(ItemDetailsCell1.self)")
            
            return getItemDetailsViewModel.noOfRowInSection(arr: getItemDetailsViewModel.tableArr1 as NSArray)
            
        }else {
            
            self.tableView.register(ItemDetailsCell2.self, forCellReuseIdentifier: "\(ItemDetailsCell2.self)")
            
            return getItemDetailsViewModel.noOfRowInSection(arr: getItemDetailsViewModel.tableArr2 as NSArray)
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(ItemDetailsCell1.self)", for: indexPath) as! ItemDetailsCell1
        
            getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Item, text: getItemDetailsViewModel.tableArr1[indexPath.row], textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11 )
            
            if indexPath.row == 0 || indexPath.row == getItemDetailsViewModel.tableArr1.count - 1 {
                
                cell.setColorOnCellView(color1: obj.commonAppLightblueColor, color2: obj.commonAppLightblueColor)
                
                if indexPath.row == 0{
                    
                    cell.setColorOnBottomView(color1: .lightGray, color2: .clear)
                
                    
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CATTGT, text: "CAT TGT%", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentFinancial, text: "Current Financial value", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total, text: "Tatal%", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentMonthValue, text: "Current Month value", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total1, text: "Total%", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 11)
                 
                    
                }else{
                    
                     cell.setColorOnBottomView(color1: .clear, color2: .clear)
 
                    
                    getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CATTGT, text: "Total", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13)
                    getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentFinancial, text: "0", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13)
                    getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total, text: "", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13)
                    getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentMonthValue, text: "25000", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13)
                    getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total1, text: "", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13)
                    
                }
                
            }else{
                
                if indexPath.row == getItemDetailsViewModel.tableArr1.count - 2{
                    
                     cell.setColorOnBottomView(color1: .lightGray, color2: .clear)
                    
                }else{
                
                     cell.setColorOnBottomView(color1: .lightGray, color2: obj.lightGray)
                   
                }
                
                cell.setColorOnCellView(color1: obj.commonAppLightblueColor, color2: .white)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CATTGT, text: "12%", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentFinancial, text: "\(indexPath.row)", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total, text: "NAN", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_CurrentMonthValue, text: "8", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
                getItemDetailsViewModel.lblFontColor(lbl: cell.lbl_Total1, text: "26.8", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)
                
            }
            
            return cell
            
        }else {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(ItemDetailsCell2.self)", for: indexPath) as! ItemDetailsCell2
           
             getItemDetailsViewModel.lblFontColor(lbl: cell.lblNonMoving, text: getItemDetailsViewModel.tableArr2[indexPath.row], textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 13 )
            
            if indexPath.row == 0 {
                
                cell.setColorOnBottomView(color1: .lightGray, color2: .clear)
                cell.setColorOnCellView(color1: obj.commonAppLightblueColor, color2: obj.commonAppLightblueColor)
                
            }else{
                
                cell.setColorOnBottomView(color1: .lightGray, color2: obj.lightGray)
                cell.setColorOnCellView(color1: obj.commonAppLightblueColor, color2: .white)
                
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55.0
    }
    
    
}
