//
//  UserListPopupVC.swift//  AIPL ABRO
//
//  Created by call soft on 28/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class UserListPopupVC: UIViewController {
    
    @IBOutlet weak var vw_bg: UIView!
    @IBOutlet weak var user_tblView: UITableView!
    @IBOutlet weak var lbl_user: UILabel!
    @IBOutlet weak var btn_submit: UIButton!
    
    var conn = WebService()
    var arrUser = [UserListModel]()
    var nameArr = NSMutableArray()
    var codeArr = NSMutableArray()
    var empLevelArr = NSMutableArray()
    let obj = CommonClass.sharedInstance
    var newDict = [NSMutableDictionary]()
    var responseArr = NSArray()
    
    var updateCallBack : ((_ userArr:[NSMutableDictionary])->Void)?
    
    //        var callback: ((_ id: Int) -> Void)?
    //        callback?(example_id)
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        apiUserList()
        user_tblView.dataSource = self
        user_tblView.delegate = self
        user_tblView.allowsMultipleSelectionDuringEditing = true
        // user_tblView.setEditing(true, animated: false)
       
    }
    
    
    @IBAction func btn_submitTap(_ sender: UIButton) {
        
        self.dismiss(animated: false) {
            self.updateCallBack!(self.newDict)
        }
    }
    
    
    @IBAction func btn_cancelTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initialSetup() {
        
        vw_bg.backgroundColor = .white
        vw_bg.layer.masksToBounds = true
        vw_bg.layer.borderColor = UIColor.red.cgColor
        vw_bg.layer.cornerRadius = 8.0
        vw_bg.layer.borderWidth = 1.0
        lbl_user.text = "User List"
        btn_submit.backgroundColor = .red
        btn_submit.setTitleColor(.white, for: .normal)
        self.setFontandColor(lbl: lbl_user, color: UIColor.black, font: obj.RegularFont, size: obj.semiBoldfontSize)
        
    }
    
    //MARK:- Custom Method To Set Font and Color
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat){
        
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension UserListPopupVC{
    
    func apiUserList(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
            let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? ""]
            
            print("Pass Date \(passData)")
            
            Indicator.shared.showProgressView(self.view)
            conn.startConnectionWithSting("zoom/getTagEmployeeListForMeeting", method_type: .post, params: passData as! [NSString : NSObject]) { (responseJSON) in
                
                Indicator.shared.hideProgressView()
                print(responseJSON)
                
                let message = responseJSON.value(forKey: "message") as? String ?? ""
                
                if self.conn.responseCode == 1{
                    
                    if responseJSON.value(forKey: "response") as? Bool ?? false == true{
                        
                        if let dataArray = responseJSON.value(forKey: "dataArray") as? NSArray {
                            self.responseArr = dataArray
                            self.user_tblView.reloadData()
                            print(self.responseArr)
                            
                        }
                        
                    }else{
                        self.alert(message: message)
                    }
                    
                }else{
                    self.alert(message: "Something went wrong")
                }
            }
        }else{
            
            self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
}


extension UserListPopupVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = user_tblView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        
        let dataDict = responseArr.object(at: indexPath.row) as? NSDictionary ?? [:]
        let Name = dataDict.value(forKey: "Name") as? String ?? ""
        
        cell.lbl_name.text = Name
        self.setFontandColor(lbl: cell.lbl_name, color: UIColor.black, font: obj.RegularFont, size: obj.semiBoldfontSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        
        cell.accessoryType = .checkmark
        
        let dataDict = responseArr.object(at: indexPath.row) as? NSDictionary ?? [:]
        let Name = dataDict.value(forKey: "Name") as? String ?? ""
        let EmpCode = dataDict.value(forKey: "Emp Code") as? String ?? ""
        let EmployeeLevel = dataDict.value(forKey: "Employee Level") as? Int ?? 0
        
        print("selected \(Name) at index \(indexPath)")
        print("selected \(EmpCode) at index \(indexPath)")
        print("selected \(EmployeeLevel) at index \(indexPath)")
        
        let itemDict = NSMutableDictionary()
        itemDict.addEntries(from: ["code" : EmpCode])
        itemDict.addEntries(from: ["name" : Name])
        itemDict.addEntries(from: ["Employee_Level" : EmployeeLevel])
        
        self.newDict.append(itemDict)
        
        print(self.newDict)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        cell.accessoryType = .none
        
        
//        arrUser[indexPath.row].isSelected = !arrUser[indexPath.row].isSelected
//
//        var objectives = ""
//
//        for index in 0..<arrUser.count{
//            if index == indexPath.row{
//
//
//                if  arrUser[indexPath.row].isSelected{
//                    objectives = arrUser[indexPath.row].Name
//                  //  self.selectedOpertunies = indexPath.row
//                }else{
//                    objectives = String()
//                }
//
//            }else{
//                arrUser[index].isSelected = Bool()
//            }
//        }
//        user_tblView.reloadData()
//
      self.newDict.removeLast()
        
        print(self.newDict)
    }
    
}

