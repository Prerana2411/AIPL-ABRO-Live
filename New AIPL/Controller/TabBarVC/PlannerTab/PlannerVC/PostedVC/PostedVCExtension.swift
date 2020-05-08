//
//  PostedVCExtension.swift
//  AIPL
//
//  Created by apple on 09/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit
extension PostedPlannerVC{
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
       internal func setUpNavi(){
             
           view.backgroundColor = obj.commonAppbackgroundColor
               view.addSubview(navView)
               navView.translatesAutoresizingMaskIntoConstraints = false
               navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
         _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
            
        
           view.addSubview(stackForDateMonthYear)
        
          
           stackForDateMonthYear.translatesAutoresizingMaskIntoConstraints = false
           stackForDateMonthYear.withoutBottomAnchor(top: navView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: CGFloat(obj.commonHeight))
           stackForDateMonthYear.addArrangedSubview(date_View)
           stackForDateMonthYear.addArrangedSubview(month_View)
           stackForDateMonthYear.addArrangedSubview(year_View)
          
           _ = date_View.CommonViewLableButton(view: date_View, btn: date_btn, lbl: date_lbl)
           _ = month_View.CommonViewLableButton(view: month_View, btn: month_btn, lbl: month_lbl)
           _ = year_View.CommonViewLableButton(view: year_View, btn: year_btn, lbl: year_lbl)
        
           view.addSubview(btn_Submit)
           
           btn_Submit.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([btn_Submit.topAnchor.constraint(equalTo: year_View.bottomAnchor, constant: 15),
                                        btn_Submit.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                        btn_Submit.widthAnchor.constraint(equalToConstant: 90),
                                        btn_Submit.rightAnchor.constraint(equalTo: year_View.rightAnchor)])
           
         
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.scrollAnchor(top: btn_Submit.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 5)
         self.view.bringSubviewToFront(baseview)
      
         }

    //MARK:- Button Action
    //MARK:-
    @objc func btnClick(sender:UIButton){
          
        if sender.tag == 1{
            isRetailerSelected = false
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 2{
            isRetailerSelected = false
            let item = DailyRegisterModel(itemCategory: String(), Item: String(), Quantity: String())
            
            self.itemArr.append(item)
            
        }else if sender.tag == 3 || sender.tag == 4 || sender.tag == 5{
            
            isRetailerSelected = false
             month_lbl.text = ""
             year_lbl.text = ""
             date_lbl.text = ""
             DatePicker(sender: sender, txtFld: date_lbl)
            
        }else if sender.tag == 6{
            isRetailerSelected = false
          validation()
            
        }else if sender.tag == 7{
            
            isRetailerSelected = false
            
            if self.getCityBeatFromViewModel.getCityDataArr.count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.Travel_lbl, anchorView: self.Travel_View)
                
            }else{
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
                    Indicator.shared.showProgressView(view)
                    getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                        
                        self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.Travel_lbl, anchorView: self.Travel_View)
                        
                    }
                    
                }
            }
            
        }else if sender.tag == 8{
            
            isRetailerSelected = false
            
            if self.getCityBeatFromViewModel.getCityDataArr.count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "beat") as? [String] ?? []), txtFld: self.Beat_lbl, anchorView: self.Beat_View)
                
            }else{
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
                    Indicator.shared.showProgressView(view)
                    getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                        
                        self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "beat") as? [String] ?? []), txtFld: self.Beat_lbl, anchorView: self.Beat_View)
                        
                    }
                    
                }
            }
            
        }else if sender.tag == 9{
            
            isRetailerSelected = true
            
            if self.getRetailerViewModel.retailerName.count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getRetailerViewModel.retailerName), txtFld: self.Retailer_lbl, anchorView: self.Retailer_View)
                
            }else{
                
             
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    let passDict = ["salesPersonHq":userData.value(forKey: "HQ") ?? "","salesPersonZone":userData.value(forKey: "Zone") ?? ""] as [String:Any]
                    
                    Indicator.shared.showProgressView(view)
                    
                    getRetailerViewModel.getReatilerListDataFromApiHandler(url: "retailerListHQwise", passDict: passDict, success: { (_, message) in
                        
                        print(message)
                        
                        if message == "Data found"{
                            
                            self.dropDownDataSource(dataSource: (self.getRetailerViewModel.retailerName), txtFld: self.Retailer_lbl, anchorView: self.Retailer_View)
                            
                        }
                        
                    }) { (message) in
                        
                        self.alert(message: CommonClass.sharedInstance.createString(Str: message))
                    }
                    
                }else{
                    
                    alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
                }
                
            }
            
            
        }else if sender.tag == 10{
            isRetailerSelected = false
            self.dropDownDataSource(dataSource: ["Yes","No"], txtFld: self.Order_lbl, anchorView: self.Order_View)
            
        }else if sender.tag == 12{
            isRetailerSelected = false
            apiDailyRegister()
            
        }else if sender.tag == 13{
            
           isRetailerSelected = false
            if let baseViewTag = self.view.viewWithTag(668)
            {
                if let datePicker = self.view.viewWithTag(5454) as? UIDatePicker
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let date = dateFormatter.string(from: datePicker.date)
                    
                    self.Date = date
                    self.date_lbl.text = String(date.suffix(2))
                    self.year_lbl.text = String(date.prefix(4))
                    let start = String.Index(utf16Offset: 5, in: date)
                    let end = String.Index(utf16Offset: 6, in: date)
                    let substring = String(date[start...end])
                    self.month_lbl.text = substring
                    baseViewTag.removeFromSuperview()
                    datePicker.removeFromSuperview()
                }
            }
        }else if sender.tag == 14{
            isRetailerSelected = false
            if let baseViewTag = self.view.viewWithTag(668)
            {
                baseViewTag.removeFromSuperview()
            }
            
        }else if sender.tag == 16{
            
            if Retailer_lbl.text!.isEmpty{
                
                alert(message: obj.createString(Str: "Please Select Retailer Type First!!"))
                
            }else{
                
                
                isRetailerSelected = false
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    self.taggedCustomerCode = getRetailerViewModel.taggedCustomerCodeArr[self.index]
                    
                    let passDict = ["tadedCustomerCode":self.taggedCustomerCode] as [String:Any]
                    print(passDict)
                    Indicator.shared.showProgressView(view)
                    
                    getRetailerViewModel.getTaggedCustDataFromApiHandler(url: "tagedCustomer", passDict: passDict) { (responseMessage) in
                        
                        if responseMessage == "Data found"{
                            
                            self.dropDownDataSource(dataSource: (self.getRetailerViewModel.tagCusName), txtFld: self.Tagged_lbl, anchorView: self.Tagged_View)
                            
                        }else{
                            
                            self.alert(message: CommonClass.sharedInstance.createString(Str: responseMessage))
                            
                        }
                        
                    }
                    
                    
                }else{
                    
                    alert(message: CommonClass.sharedInstance.createString(Str: "Please check your internet connection"))
                }
                
            }
            
        }
          
    }
    
     
    //MARK:- Set String On UIElements
    //MARK:-
    
    func setString(){
        
       
        titleHeader.setFontAndColor(lbl: titleHeader, text: "Daily Sales Register", textColor: .white, font: obj.BoldFont, size: obj.BoldfontSize)
        date_lbl.setFontandColor(txtFld: date_lbl, color: .black, font: obj.MediumFont, size: obj.semiBoldfontSize, text: "Date")
        date_lbl.setFontandColor(txtFld: month_lbl, color: .black, font: obj.MediumFont, size: obj.semiBoldfontSize, text: "Year")
        date_lbl.setFontandColor(txtFld: year_lbl, color: .black, font: obj.MediumFont, size: obj.semiBoldfontSize, text: "Date")
        Travel_lbl.setFontandColor(txtFld: Travel_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        Beat_lbl.setFontandColor(txtFld: Beat_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        Retailer_lbl.setFontandColor(txtFld: Retailer_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        Tagged_lbl.setFontandColor(txtFld: Tagged_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        Order_lbl.setFontandColor(txtFld: Order_lbl, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Select")
        
        setTextToLable(lbl: Travel_lbl_header, text: "Travel :", isSmall: true)
        setTextToLable(lbl: Beat_lbl_header, text: "Beat :", isSmall: true)
        setTextToLable(lbl: Retailer_lbl_header, text: "Retailer :", isSmall: true)
        setTextToLable(lbl: Tagged_lbl_header, text: "Tagged Customer :", isSmall: true)
        setTextToLable(lbl: Order_lbl_header, text: "Order :", isSmall: true)
        setTextToLable(lbl: lbl_Remark, text: "Remarks", isSmall: true)
       
        setTextToBtn(btn: date_btn, text: "", image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: month_btn, text: "", image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: year_btn, text: "", image: #imageLiteral(resourceName: "calendar"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: btn_Submit, text: "Show", image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
        setTextToBtn(btn: Travel_btn, text: "", image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: Beat_btn, text: "", image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: Retailer_btn, text: "", image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: Tagged_btn, text: "", image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: Order_btn, text: "", image: #imageLiteral(resourceName: "down"), backGroundColor: .clear, aliment: .right)
        setTextToBtn(btn: btn_AddCategory, text: "Add Item", image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
        setTextToBtn(btn: btn_SubmitReport, text: "Submit Report", image: UIImage(), backGroundColor: obj.commonAppRedColor, aliment: .center)
        btn_save.setDataOnButton(btn: btn_save, text: "Save", font: obj.MediumFont, size: 12, textcolor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), image: UIImage(), backGroundColor: .clear, aliment: .center)
        
        self.tableView.isHidden = true
        self.btn_AddCategory.isHidden = true
    }
    
    func setTextToLable(lbl:UILabel,text:String,isSmall:Bool){
        
        isSmall == true ? (lbl.setFontAndColor(lbl: lbl, text: text, textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize)):(lbl.setFontAndColor(lbl: lbl, text: text, textColor: .black, font: obj.MediumFont, size: obj.semiBoldfontSize))
         
    }
    
    func setTextToBtn(btn:UIButton,text:String,image:UIImage,backGroundColor:UIColor,aliment:UIControl.ContentHorizontalAlignment){
        
        btn.setDataOnButton(btn: btn, text: text, font: obj.MediumFont, size: obj.semiBoldfontSize, textcolor: .white, image: image, backGroundColor: backGroundColor, aliment: aliment)
    }
}

//MARK:- Configure tableView
//MARK:-

extension PostedPlannerVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func configTable(){
           
           self.tableView.register(PostedPlannerCell.self, forCellReuseIdentifier: "\(PostedPlannerCell.self)")
           self.tableView.delegate = self
           self.tableView.dataSource = self
           self.tableView.backgroundColor = .clear
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(PostedPlannerCell.self)", for: indexPath) as! PostedPlannerCell
        setTextToLable(lbl: cell.Item_lbl_header, text: "Item", isSmall: true)
        setTextToLable(lbl: cell.ItemCategory_lbl_header, text: "Item Category", isSmall: true)
        cell.TextFld.setFontandColor(txtFld: cell.TextFld, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: obj.regularfontSize, text: "Enter")
        cell.delegate = self
        cell.TextFld.tag = indexPath.row
        cell.ItemCategory_btn.tag = indexPath.row
        cell.Select_btn.tag = indexPath.row
        cell.indicatorView = self.view
        cell.getRetailerViewModel = self.getRetailerViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(Travel_lbl_header)
        view.addSubview(Beat_lbl_header)
        Travel_lbl_header.lbl_Constraint(top: view.topAnchor, left: view.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        
        commonConstraintForTableHeader(view: view, stack: stack1, lblHeader: Travel_lbl_header)
        stack1.addArrangedSubview(Travel_View)
        stack1.addArrangedSubview(Beat_View)
        commonConstraint(insideView: (Travel_View), lblSelect: Travel_lbl, btnDrop: Travel_btn)
        commonConstraint(insideView: (Beat_View), lblSelect: Beat_lbl, btnDrop: Beat_btn)
        Beat_lbl_header.lbl_Constraint(top: view.topAnchor, left: Beat_View.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        
        view.addSubview(Retailer_lbl_header)
        view.addSubview(Tagged_lbl_header)
        Retailer_lbl_header.lbl_Constraint(top: stack1.bottomAnchor, left: view.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        
        commonConstraintForTableHeader(view: view, stack: stack2, lblHeader: Retailer_lbl_header)
        stack2.addArrangedSubview(Retailer_View)
        stack2.addArrangedSubview(Tagged_View)
        commonConstraint(insideView: (Retailer_View), lblSelect: Retailer_lbl, btnDrop: Retailer_btn)
        commonConstraint(insideView: (Tagged_View), lblSelect: Tagged_lbl, btnDrop: Tagged_btn)
        Tagged_lbl_header.lbl_Constraint(top: stack1.bottomAnchor, left: Tagged_View.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        view.addSubview(Order_lbl_header)
        Order_lbl_header.lbl_Constraint(top: stack2.bottomAnchor, left: view.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        view.addSubview(Order_View)
        Order_View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([Order_View.topAnchor.constraint(equalTo: Order_lbl_header.bottomAnchor, constant: 6),
                                     Order_View.heightAnchor.constraint(equalTo: Retailer_View.heightAnchor, multiplier: 1),
                                     Order_View.widthAnchor.constraint(equalTo: Retailer_View.widthAnchor, multiplier: 1),
                                     Order_View.leftAnchor.constraint(equalTo: Retailer_View.leftAnchor, constant: 0)])
        commonConstraint(insideView: Order_View, lblSelect: Order_lbl, btnDrop: Order_btn)
        Order_View.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        footerView.backgroundColor = .clear
        footerView.addSubview(btn_AddCategory)
        footerView.addSubview(lbl_Remark)
        footerView.addSubview(View_Remark)
        footerView.addSubview(btn_save)
        footerView.addSubview(btn_SubmitReport)
        
        btn_AddCategory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_AddCategory.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
                                     btn_AddCategory.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -10),
                                     btn_AddCategory.heightAnchor.constraint(equalToConstant: CGFloat(obj.commonHeight)),
                                     btn_AddCategory.widthAnchor.constraint(equalToConstant: 200)])
        
        btn_AddCategory.tag = 2
        btn_AddCategory.addTarget(self, action:#selector(btnClick(sender:)), for: .touchUpInside)  
        
        lbl_Remark.lbl_Constraint(top: btn_AddCategory.bottomAnchor, left: footerView.leftAnchor, right: NSLayoutXAxisAnchor(), isRight: false, paddingTop: 10, paddingLeft: 10, paddingRight: 0)
        View_Remark.withoutBottomAnchor(top: lbl_Remark.bottomAnchor, left: lbl_Remark.leftAnchor, right: btn_AddCategory.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, height: 90)
        View_Remark.addSubview(txtView_Remark)
        txtView_Remark.scrollAnchor(top: View_Remark.topAnchor, left: View_Remark.leftAnchor, bottom: View_Remark.bottomAnchor, right: View_Remark.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        btn_save.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btn_save.topAnchor.constraint(equalTo: View_Remark.bottomAnchor, constant: 10),
                                     btn_save.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -10),
                                     btn_save.heightAnchor.constraint(equalToConstant: 30)])
        btn_SubmitReport.withoutBottomAnchor(top: btn_save.bottomAnchor, left: View_Remark.leftAnchor, right: View_Remark.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight))
        btn_SubmitReport.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10).isActive = true
        return footerView
         
    }
    
    
    func commonConstraint(insideView:UIView,lblSelect:UIView,btnDrop:UIButton){
        
        insideView.layer.borderWidth = 1.0
        insideView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        insideView.addSubview(lblSelect)
        insideView.addSubview(btnDrop)
        insideView.backgroundColor = .white
        insideView.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        lblSelect.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: insideView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        btnDrop.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: insideView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 12)
        
    }
    
    func commonConstraintForTableHeader(view:UIView,stack:UIView,lblHeader:UIView){
        
        view.addSubview(stack)
        
        stack.withoutBottomAnchor(top: lblHeader.bottomAnchor, left: lblHeader.leftAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingRight: 10, height: CGFloat(obj.commonHeight))
        
        
    }
    
   
}

//MARK:- PostedPlannerCellDelegate Call
//MARK:-

extension PostedPlannerVC:PostedPlannerCellDelegate{
    
    func itemCategory(text: String, index: Int,btnTag:Int) {
        
        self.itemArr[btnTag].itemCategory = text
        self.itemCodeIndex = index
        
    }
    
    func item(text: String, index: Int) {
        
       self.itemArr[index].Item = text
        
    }
    
    func quantity(text: String, index: Int) {
        
       self.itemArr[index].Quantity = text
        
    }
    
}

//MARK:- Api Daily Register caLL
//MARK:-
extension PostedPlannerVC:NoOrderPopupVCDelegate{
    
    
    func apiDailyRegister(){
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let encoder = JSONEncoder()
            
            do {
                
                if !self.OrderNotRec_Reason.isEmpty{
                    
                    self.itemArr.append(DailyRegisterModel(itemCategory: String(), Item: String(), Quantity: "0"))
                }
                
                let jsonData = try encoder.encode(self.itemArr)
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                let passDict = ["Planner No":getDailyRegisterSalesViewModel.plannerArr[0],"Actual Travel City":Travel_lbl.text!,"Beat":Beat_lbl.text!,"Retailer Name":Retailer_lbl.text!,"Tagged Customer":self.taggedCustomerCode,"Order Status":Order_lbl.text == "Yes" ? "1" : "0","Items":jsonString!,"Order Not Rec_Remarks":self.OrderNotRec_Remarks,"Business Entity":getRetailerViewModel.businessEntityArr[0],"Zone":userData.value(forKey: "Zone") as? String ?? "","Retailer Code":self.retailerCode,"Create Date":self.Date,"Order Not Rec_ Reason":self.OrderNotRec_Reason,"Planner Date":self.Date,"Planner City":getDailyRegisterSalesViewModel.cityArr[0],"Planner Line No":getDailyRegisterSalesViewModel.lineNoArr[0],"Remark":self.txtView_Remark.text!,"Month":self.month_lbl.text!,"Year":self.year_lbl.text!] as [String:Any]
                print(passDict)
                
                Indicator.shared.showProgressView(view)
                
                getDailyRegisterSalesViewModel.getDataFromApiHandlerForsecondrySalesCreate(strUrl: "secondrySalesCreateIos ", passDict: passDict) { (responseMsg) in
                    
                    if responseMsg == "Data created"{
                        
                        self.navigationController?.popViewController(animated: false)
                        
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: responseMsg))
                    }
                    
                }
                
                
            } catch  {
                
            }
              
        }else{
            
           self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
    
    
    func value(OrderNotRec_Reason: String, OrderNotRec_Remarks: String) {
        
        print(OrderNotRec_Reason,OrderNotRec_Remarks)
        
        self.OrderNotRec_Reason = OrderNotRec_Reason
        self.OrderNotRec_Remarks = OrderNotRec_Remarks
    }
    
    //MARK:- Api itemCategory
    //MARK:-
    
    func apiitemCategoryList(){
        
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            Indicator.shared.showProgressView(view)
            getRetailerViewModel.apiitemList(urlStr: "itemCategoryList", passDict: ["" : ""]) { (responseMessage) in
                
                if responseMessage == "Data found"{
                     
                }else{
                    
                    self.alert(message: self.obj.createString(Str: responseMessage))
                }
                
            }
            
        }else{
            
           self.alert(message: obj.createString(Str: "Please check your internet connection"))
        }
        
    }
       
  
}
