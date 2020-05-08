//
//  MeetingVC.swift
//  AIPL ABRO
//
//  Created by call soft on 24/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class MeetingVC: UIViewController {
    
    @IBOutlet weak var vw_meeting: UIView!
    @IBOutlet weak var btn_meeting: UIButton!
    @IBOutlet weak var tblView_meet: UITableView!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var btnSchedule: UIButton!
    
    //MARK:- Variable
    let navView : UIView = {
        
        let view = UIView()
        view.backgroundColor = CommonClass.sharedInstance.commonAppRedColor
        return view
    }()
    
    let leftBtn :UIButton = {
        
        let btn = UIButton()
        btn.tag = 1
        btn.setImage(#imageLiteral(resourceName: "back1"), for: .normal)
        btn.contentMode = .center
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
        
    }()
    
    let titleHeader:UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: CommonClass.sharedInstance.BoldFont, size: CommonClass.sharedInstance.BoldfontSize)
        lbl.textColor = UIColor.white
        lbl.text = "Meeting List"
        return lbl
    }()
    
     let obj = CommonClass.sharedInstance
     var conn = WebService()
     var arrMeetList = [zoomMeetListModel]()
     let kSDKUserName = "Prerana"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView_meet.dataSource = self
        tblView_meet.delegate = self
        tblView_meet.register(UINib.init(nibName: "MeetingTblCell", bundle: nil), forCellReuseIdentifier:
            "MeetingTblCell")
        vw_meeting.backgroundColor = .white
        vw_meeting.layer.masksToBounds = true
        vw_meeting.layer.cornerRadius = vw_meeting.frame.size.height/2
        btn_meeting.backgroundColor = obj.commonAppRedColor
        self.setFontandColorforButton(btn: btn_meeting, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        
         apiRequestMeetList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setUpNavi()
        self.setFontandColorforButton(btn: btnRequest, color: UIColor.white, font: obj.MediumFont, size: obj.semiBoldfontSize)
        self.setFontandColorforButton(btn: btnSchedule, color: UIColor.darkGray, font: obj.MediumFont, size: obj.regularfontSize)
        btnRequest.backgroundColor = obj.commonAppRedColor
        btnSchedule.backgroundColor = obj.commonwhiteColor
        
    }
    
    internal func setUpNavi(){
        
        view.backgroundColor = obj.commonAppbackgroundColor
        tblView_meet.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
        
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1 {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func btn_meetTap(_ sender: UIButton) {
        
        let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let vc = stroryBoard.instantiateViewController(withIdentifier: "MeetingDetailVC") as! MeetingDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnRequsetTap(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btn_scheduleTap(_ sender: UIButton) {
        
        self.setFontandColorforButton(btn: btnSchedule, color: UIColor.white, font: obj.MediumFont, size: obj.regularfontSize)
        self.setFontandColorforButton(btn: btnRequest, color: obj.tableDarkGray, font: obj.MediumFont, size: obj.regularfontSize)
        btnSchedule.backgroundColor = obj.commonAppRedColor
        btnRequest.backgroundColor = obj.commonwhiteColor
        
        let stroryBoard = UIStoryboard.init(name: "Merchant", bundle: nil)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        let vc = stroryBoard.instantiateViewController(withIdentifier: "MeetingScheduleVC") as! MeetingScheduleVC
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
  
    //MARK:- Custom Method To Set Font and Color
    func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat){
        
        lbl.textColor = color
        lbl.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
    func setFontandColorforButton(btn:UIButton,color:UIColor,font:String,size:CGFloat){
        
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
}

//MARK:- Api Meeting list
extension MeetingVC{
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func apiRequestMeetList(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
            let passData = ["salesPersonCode":userData.value(forKey: "Code") ?? ""]
            print("Pass Date \(passData)")
            
            Indicator.shared.showProgressView(self.view)
            conn.startConnectionWithSting("zoom/meetingRequestList", method_type: .post, params: passData as! [NSString : NSObject]) { (responseJSON) in
                
                Indicator.shared.hideProgressView()
                print(responseJSON)
                
                let message = responseJSON.value(forKey: "message") as? String ?? ""
                
                if self.conn.responseCode == 1{
                    
                    if responseJSON.value(forKey: "response") as? Bool ?? false == true{
                        
                        if let dataArr = responseJSON.value(forKey: "dataArr") as? NSArray {
                            
                            let dataList = zoomMeetListModel(Description: String(), MeetingId: String(), MeetingPass: String(), scheduleBy: String(), MeetingTime: String(), MeetingDate: String(), MeetingCode: String())
                            
                            for index in 0..<dataArr.count{
                                let dataDict = dataArr.object(at: index) as? NSDictionary ?? [:]
                                
                                if let Description = dataDict.value(forKey: "Meeting Description") as? String{
                                    
                                    print(Description)
                                    dataList.Description = Description
                                    
                                }
                                if let MeetingId = dataDict.value(forKey: "Meeting Id") as? String{
                                    
                                    dataList.MeetingId = MeetingId
                                    
                                }
                                if let MeetingPass = dataDict.value(forKey: "Meeting Pass") as? String{
                                    
                                    dataList.MeetingPass = MeetingPass
                                    
                                }
                                if let scheduleBy = dataDict.value(forKey: "Meeting Request by Name") as? String{
                                    dataList.scheduleBy = scheduleBy
                                    
                                }
                                
                                if let meetCode = dataDict.value(forKey: "Meeting Request by Code") as? String{
                                    UserDefaults.standard.set(meetCode, forKey: "CODE")
                                    dataList.MeetingCode = meetCode
                                }
                                
                                if let MeetingTime = dataDict.value(forKey: "Meeting Time") as? String{
                                    
                                    dataList.MeetingTime = MeetingTime
                                    
                                }
                                if let MeetingDate = dataDict.value(forKey: "Meeting") as? String{
                                    dataList.MeetingDate = MeetingDate
                                    print(MeetingDate)
                                    
                                    
                                }
                                
                                self.arrMeetList.append(zoomMeetListModel(Description: dataList.Description, MeetingId: dataList.MeetingId, MeetingPass: dataList.MeetingPass, scheduleBy: dataList.scheduleBy, MeetingTime: dataList.MeetingTime, MeetingDate: dataList.MeetingDate, MeetingCode: dataList.MeetingCode))
                            }
                            
                            self.tblView_meet.reloadData()
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


//MARK: table delegates datasource
extension MeetingVC: UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return arrMeetList.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tblView_meet.dequeueReusableCell(withIdentifier: "MeetingTblCell") as! MeetingTblCell
    
    cell.contentView.backgroundColor = obj.commonAppbackgroundColor
    cell.vw_joinMeet.isHidden = true
    cell.btn_joinMeet.isHidden = true
    
    cell.lbl_meetDescr.text = obj.createString(Str: "Meeting Des:")
    cell.lbl_meetId.text = obj.createString(Str: "Meeting Id:")
    cell.lbl_meetPass.text = obj.createString(Str: "Meeting Pass:")
    cell.lbl_schedule.text = obj.createString(Str: "Scheduled By:")
    cell.lbl_meetTime.text = obj.createString(Str: "Meeting Time:")
    cell.lbl_meetDate.text = obj.createString(Str: "Meeting Date:")
    
    self.setFontandColor(lbl: cell.lbl_meetDescr, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_meetId, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_meetPass, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_schedule, color: UIColor.darkGray, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_meetTime, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_meetDate, color: UIColor.black, font: obj.RegularFont, size: obj.regularfontSize)
    self.setFontandColor(lbl: cell.lbl_scheduleBy, color: UIColor.darkGray, font: obj.RegularFont, size: obj.regularfontSize)
  
    cell.txt_descrp.text = arrMeetList[indexPath.row].Description
    cell.txt_meetDate.text = arrMeetList[indexPath.row].MeetingDate
    cell.txt_meetTime.text = arrMeetList[indexPath.row].MeetingTime
    cell.txt_meetId.text = "********"
    cell.txt_meetPass.text = "********"
    cell.lbl_scheduleBy.text = arrMeetList[indexPath.row].scheduleBy

    return cell
}

}

