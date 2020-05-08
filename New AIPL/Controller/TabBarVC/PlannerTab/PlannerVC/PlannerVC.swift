//
//  PlannerVC.swift
//  AIPL
//
//  Created by apple on 08/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class PlannerVC: UIViewController {

  
    //MARK:- Variable
      let navView : UIView = {
           
           let view = UIView()
           view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
           return view
       }()
      
       let rightBtn :UIButton = {
           
           let btn = UIButton()
           btn.tag = 1
           btn.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
           btn.contentMode = .scaleAspectFill
          // btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
           return btn
           
       }()
       
       let titleHeader:UIImageView = {
           
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "header_logo")
        img.contentMode = .scaleAspectFit
        return img
       }()
    
     lazy var tableView : UITableView = {
           
           let table = UITableView()
           table.separatorStyle = .none
           table.indicatorStyle = .white
           table.showsVerticalScrollIndicator = false
            return table
           
       }()
    
    let plannerListArr = ["New Planner","Edit Planner","Posted Planner/DSR","Retailers","Dealers","Secondary Sales Channing","Distributor Secondary Sales","Working Plan","DSR Report","Daily DSR Report","Monthly Target","Target Report","Attendance Report"]
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    let obj = CommonClass.sharedInstance
    //MARK:- LifeCycle Method
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //  self.setUpNavi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUpNavi()
    }
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
    internal func setUpNavi(){
          
        view.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
            view.addSubview(navView)
            navView.translatesAutoresizingMaskIntoConstraints = false
            navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
      _ = navView.naviView(navView: navView, rightBtn: rightBtn, leftBtn: UIButton(), logoImg: titleHeader, title: UILabel(), isLogoHidden: false)
    
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.scrollAnchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        self.configTable()
         // setString()
      }
    
    //MARK:- Btn Action
    //MARK:-
    
    @objc func BtnClick(sender:UIButton){
        
        if sender.tag == 0 {
            
            let vc = NewPlannerVC()
            vc.plannerType = "add planner"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if sender.tag == 1 {
            
            let vc = NewPlannerVC()
            vc.plannerType = "edit planner"
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 2 {
            
            if userData.value(forKey: "EmployeeLevel") as? Int ?? 0 == 12{
                
                let vc = PostedPlannerVC()
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else{

                let vc = PostedPlannerVC2()
                self.navigationController?.pushViewController(vc, animated: false)
                
            }
            
        }else if sender.tag == 3{
            
            let vc =  RetailerVC()
            vc.titleHeaderName = "Retailer"
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 4{
            
            let vc =  RetailerVC()
            vc.titleHeaderName = "Dealer"
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 5{
            
            let vc = SecondaryAndDistributedVC()
            vc.titleHeaderName = "Daily Sales Register"
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if sender.tag == 6{
            
            let vc = DistributedSecSalesVC()
            
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 7{
            
            let vc = WorkingPlanVC()
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 8{
            
            let vc = DSRReportVC()
            vc.titleheader = "DSR Report"
            vc.txt1 = "Month"
            vc.txt2 = "Year"
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if sender.tag == 9{
            
            let vc = DSRReportVC()
            vc.titleheader = "Daily DSR Report"
            vc.txt1 = "From"
            vc.txt2 = "To"
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if sender.tag == 10{
            
            
        }else if sender.tag == 12{
            
            let vc = DSRReportVC()
            vc.titleheader = "Attendance Report"
            vc.txt1 = "From"
            vc.txt2 = "To"
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }

}

//MARK:- Configure tableView
//MARK:-

extension PlannerVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
           
           self.tableView.register(PlannerCell.self, forCellReuseIdentifier: "\(PlannerCell.self)")
           self.tableView.delegate = self
           self.tableView.dataSource = self
           self.tableView.alwaysBounceHorizontal = false
           self.tableView.alwaysBounceVertical = false
           self.tableView.rowHeight = UITableView.automaticDimension
           self.tableView.bounces = false
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return plannerListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(PlannerCell.self)", for: indexPath) as! PlannerCell
       
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? obj.tableDarkGray : obj.tablelightGray
        cell.mainView.dropTxtFld.text = obj.createString(Str: plannerListArr[indexPath.row])
        cell.mainView.DropBtn.tag = indexPath.row
        cell.mainView.DropBtn.addTarget(self, action: #selector(self.BtnClick), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}
