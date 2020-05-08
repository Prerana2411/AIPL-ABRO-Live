//
//  AdministatorVC.swift
//  AIPL ABRO
//
//  Created by CST on 14/02/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class AdministatorVC: UIViewController {

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
    
    let adminListArr = ["Change Password","Meeting","Redirect to User","Logout"]
    
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    let obj = CommonClass.sharedInstance
    
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    
    lazy var lbl_ChangePass = UILabel()
    
    lazy var btn_ChangePass = UIButton()
    lazy var btn_Logout = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
//        view.addSubview(view1)
//        view.addSubview(view2)
//
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.scrollAnchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        configTable()
        
      //  view1.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        
    }
    
    //MARK:- Btn Action
    
    @objc func BtnClick(sender:UIButton){
        
        if sender.tag == 0 {
           
        }
        else if sender.tag == 1 {
            
            let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
            self.tabBarController?.navigationController?.isNavigationBarHidden = true
            let vc = stroryBoard.instantiateViewController(withIdentifier: "MeetingVC") as! MeetingVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 2{
            
            UserDefaults.standard.set(false, forKey: "Login_Status")
            
            UserDefaults.standard.removeObject(forKey: "loginData")
            
            UserDefaults.standard.removeObject(forKey: "Login_Flow")
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            
            let stroryBoard = UIStoryboard.init(name: "Main", bundle: nil)
            self.tabBarController?.navigationController?.isNavigationBarHidden = true
            let vc = stroryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 3{
            
            UserDefaults.standard.set(false, forKey: "Login_Status")
            
            UserDefaults.standard.removeObject(forKey: "loginData")
            
             UserDefaults.standard.removeObject(forKey: "Login_Flow")
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            
            let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
            self.tabBarController?.navigationController?.isNavigationBarHidden = true
            let vc = stroryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

//MARK:- Configure tableView
//MARK:-

extension AdministatorVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
        
        self.tableView.register(AdminCell.self, forCellReuseIdentifier: "\(AdminCell.self)")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceHorizontal = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.bounces = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return adminListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(AdminCell.self)", for: indexPath) as! AdminCell
        
        cell.contentView.backgroundColor = CommonClass.sharedInstance.commonAppbackgroundColor
        cell.mainView.dropTxtFld.text = obj.createString(Str: adminListArr[indexPath.row])
        cell.mainView.DropBtn.tag = indexPath.row
        cell.mainView.DropBtn.addTarget(self, action: #selector(self.BtnClick), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
