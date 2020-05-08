//
//  NewRetailerVC.swift
//  AIPL ABRO
//
//  Created by CST on 16/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import DropDown
import CoreLocation

class NewRetailerVC: UIViewController,CLLocationManagerDelegate {

    
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
    lazy var view1 = UIView()
    lazy var lbl_RetailerName = UILabel()
    lazy var retailer_NameView = UIView()
    lazy var textFld_RN = UITextField()
    
    
    lazy var view2 = UIView()
    lazy var HQView = UIView()
    lazy var lbl_HQ = UITextField()
    lazy var HQ_lbl_header = UILabel()
    
   
    lazy var view3 = UIView()
    lazy var StateView = UIView()
    lazy var lbl_State_header = UILabel()
    lazy var lbl_State = UITextField()
    lazy var State_btn  = UIButton()
    
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
    
    lazy var view6 = UIView()
    lazy var custView = UIView()
    lazy var lbl_Cust_header = UILabel()
    lazy var Cust_btn  = UIButton()
    lazy var lbl_Cust = UITextField()
    
    lazy var view7 = UIView()
    lazy var lbl_Address_Header = UILabel()
    lazy var Address_NameView = UIView()
    lazy var lbl_Address = UITextField()
    
    lazy var view8 = UIView()
    lazy var lbl_Email_Header = UILabel()
    lazy var Email_NameView = UIView()
    lazy var lbl_Email = UITextField()
    
    lazy var view9 = UIView()
    lazy var lbl_ContNum_Header = UILabel()
    lazy var ContNum_NameView = UIView()
    lazy var lbl_ContNum = UITextField()
    
    lazy var view10 = UIView()
    lazy var lbl_ContPerson_Header = UILabel()
    lazy var ContPerson_NameView = UIView()
    lazy var lbl_ContPerson = UITextField()
    
    
    lazy var view11 = UIView()
    lazy var TaggedView = UIView()
    lazy var lbl_Tagged_header = UILabel()
    lazy var Tagged_btn  = UIButton()
    lazy var lbl_Tagged = UITextField()
    
    lazy var view12 = UIView()
    lazy var ClassFicationView = UIView()
    lazy var lbl_ClassFication_header = UILabel()
    lazy var ClassFication_btn  = UIButton()
    lazy var lbl_ClassFication = UITextField()
    
    lazy var view13 = UIView()
    lazy var PotentialView = UIView()
    lazy var lbl_Potential_header = UILabel()
    lazy var Potential_btn  = UIButton()
    lazy var lbl_Potential = UITextField()
    
    lazy var view14 = UIView()
    lazy var GSTNumView = UIView()
    lazy var lbl_GSTNum_header = UILabel()
    lazy var lbl_GSTNum = UITextField()
    
    lazy var view15 = UIView()
    lazy var SegmentView = UIView()
    lazy var lbl_Segment_header = UILabel()
    lazy var Segment_btn  = UIButton()
    lazy var lbl_Segment = UITextField()
    
    lazy var view16 = UIView()
    lazy var ComBrandView = UIView()
    lazy var lbl_ComBrand_header = UILabel()
    lazy var ComBrand_btn  = UIButton()
    lazy var lbl_ComBrand = UITextField()
    
    lazy var comBrandPic_lbl = UILabel()
    
    lazy var imgView = UIImageView()
    lazy var btn_image = UIButton()
    
    lazy var btn_AddReatiler = UIButton()
    
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
    
    lazy var stack3 : UIStackView = {
           
           let stack = UIStackView()
           stack.axis = .horizontal
           stack.spacing = 15
           stack.distribution = .fillEqually
           stack.alignment = .fill
           return stack
           
       }()
    
    lazy var stack4 : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
        
    }()
    lazy var stack5 : UIStackView = {
           
           let stack = UIStackView()
           stack.axis = .horizontal
           stack.spacing = 15
           stack.distribution = .fillEqually
           stack.alignment = .fill
           return stack
           
       }()
    
    var retailerNumber = String()
    let obj = CommonClass.sharedInstance
    var titleHeaderName = String()
    var edit_Add_Type = String()
    var getRetailerViewModel = RetailerViewModel()
    var getCityBeatFromViewModel = StartDayViewModel()
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    var dropDown = DropDown()
    var imagePicker = UIImagePickerController()
    var imageData = NSData()
    var locationManager = CLLocationManager()
    var lat = String()
    var long = String()
    var isStateORCustomerType = String()
    var StateCode = String()
    var CustomerType = String()
    var tagCustomerCode = String()
    var createdDate = String()
    var NoSeries = String()
    var apiName = String()
    var TelexNo = String()
    var stateDiscription = String()
    
    //MARK:- LifeCycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Retailer Details Api Call
        setEmptyData()
        setUpNavi()
        imagePicker.allowsEditing = true
        // If its is coming from Editscreen then retailerNumber is not empty...
        if !retailerNumber.isEmpty{
            
           self.apiretailerDetails()
            self.apiName = "updatedRetailer"
            
        }else{
            
            self.apiName = "addRetailer"
        }
        
        
    }
    
    internal func setEmptyData(){
       
        getRetailerViewModel.setFontandColor(txtFld: textFld_RN, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Retailer Name")
        getRetailerViewModel.setFontandColor(txtFld: lbl_HQ, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        lbl_HQ.text = userData.value(forKey: "HQ") as? String ?? ""
        getRetailerViewModel.setFontandColor(txtFld: lbl_State, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_City, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Beat, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Cust, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Address, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Enter")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Email, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Enter")
        getRetailerViewModel.setFontandColor(txtFld: lbl_ContNum, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Enter")
        getRetailerViewModel.setFontandColor(txtFld: lbl_ContPerson, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Enter")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Tagged, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_ClassFication, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Segment, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_Potential, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_ComBrand, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Select")
        getRetailerViewModel.setFontandColor(txtFld: lbl_GSTNum, color: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15, text: "Enter")
        
        getRetailerViewModel.lblFontColor(lbl: lbl_RetailerName, text: "\(titleHeaderName) Name:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: HQ_lbl_header, text: "HQ", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_State_header, text: "State", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_City_header, text: "City", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_Beat_header, text: "Beat", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_Cust_header, text: "Cust Type:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_Address_Header, text: "Address:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_Email_Header, text: "Email:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_ContNum_Header, text: "Contact Number:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_ContPerson_Header, text: "Contact Person:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        
        getRetailerViewModel.lblFontColor(lbl: lbl_Tagged_header, text: "Tagged Customer:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_ClassFication_header, text: "Classfication:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        
        getRetailerViewModel.lblFontColor(lbl: lbl_Potential_header, text: "Potential:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_GSTNum_header, text: "GST Number:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_Segment_header, text: "Segment:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        getRetailerViewModel.lblFontColor(lbl: lbl_ComBrand_header, text: "Competitor Brand:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        
        getRetailerViewModel.lblFontColor(lbl: comBrandPic_lbl, text: "Shop board Picture:", textColor: obj.commonAppTextDrakColor, font: obj.RegularFont, size: 15)
        
        commonDataOnButton(btn: City_btn)
        commonDataOnButton(btn: Beat_btn)
        commonDataOnButton(btn: State_btn)
        commonDataOnButton(btn: Cust_btn)
        commonDataOnButton(btn: Tagged_btn)
        commonDataOnButton(btn: ClassFication_btn)
        commonDataOnButton(btn: Potential_btn)
        commonDataOnButton(btn: Segment_btn)
        commonDataOnButton(btn: ComBrand_btn)
        
        titleHeader.text = obj.createString(Str: "\(edit_Add_Type) \(titleHeaderName)")
        titleHeader.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        titleHeader.textColor = .white
        
        btn_AddReatiler.setTitle(obj.createString(Str: edit_Add_Type == "Edit" ? "Save" : "Add \(titleHeaderName)"), for: .normal)
        btn_AddReatiler.setTitleColor(.white, for: .normal)
        btn_AddReatiler.titleLabel?.font = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize)
        btn_AddReatiler.backgroundColor = obj.commonAppRedColor
        
        setBtnTag(btn: Tagged_btn, tag: 4)
        setBtnTag(btn: ClassFication_btn, tag: 5)
        setBtnTag(btn: Potential_btn, tag: 6)
        setBtnTag(btn: Segment_btn, tag: 7)
        setBtnTag(btn: ComBrand_btn, tag: 8)
        setBtnTag(btn: btn_image, tag: 9)
        setBtnTag(btn: City_btn, tag: 10)
        setBtnTag(btn: Beat_btn, tag: 11)
        setBtnTag(btn: btn_AddReatiler, tag: 12)
        setBtnTag(btn: State_btn, tag: 13)
        setBtnTag(btn: Cust_btn, tag: 14)
        
    }
    
    
    //MARK:- Method to set Navi On Screen
    //MARK:-
       internal func setUpNavi(){
             
        view.backgroundColor = obj.commonAppbackgroundColor
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.withoutBottomAnchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 84)
        _ = navView.naviView(navView: navView, rightBtn: UIButton(), leftBtn: leftBtn, logoImg: UIImageView(), title: titleHeader, isLogoHidden: true)
       
        view.addSubview(scrollView)
        
        scrollView.scrollAnchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        scrollView.addSubview(insideView)
        
        contentViewSize = CGSize(width: view.frame.width, height: 1200)

        scrollView.contentSize = contentViewSize
        insideView.frame.size = contentViewSize
        setCommonConstraint(mainView: view1, lbl_header: lbl_RetailerName, view: retailer_NameView, txt: textFld_RN, btn: UIButton(), mainviewtop: insideView.topAnchor, isbuttonHidden: true)
        
        addStack(stack: stack1, stackTop: view1.bottomAnchor, stackLeft: view1.leftAnchor, stackRight: view1.rightAnchor, view2: view2, view3: view3, lblHeader: HQ_lbl_header, txt: lbl_HQ, btn: UIButton(), viewdrop: HQView, lblHeader1: lbl_City_header, txt1: lbl_City, btn1: City_btn, viewdrop1: CityView, isButtonHidden1: true, isButtonHidden2: false)
        
        addStack(stack: stack2, stackTop: stack1.bottomAnchor, stackLeft: stack1.leftAnchor, stackRight: stack1.rightAnchor, view2: view4, view3: view5, lblHeader: lbl_State_header, txt: lbl_State, btn: State_btn, viewdrop: StateView, lblHeader1: lbl_Beat_header, txt1: lbl_Beat, btn1: Beat_btn, viewdrop1: BeatView, isButtonHidden1: false, isButtonHidden2: false)
        
        setCommonConstraint(mainView: view6, lbl_header: lbl_Cust_header, view: custView, txt: lbl_Cust, btn: Cust_btn, mainviewtop: stack2.bottomAnchor, isbuttonHidden: false)
        setCommonConstraint(mainView: view7, lbl_header: lbl_Address_Header, view: Address_NameView, txt: lbl_Address, btn: UIButton(), mainviewtop: view6.bottomAnchor, isbuttonHidden: true)
        setCommonConstraint(mainView: view8, lbl_header: lbl_Email_Header, view: Email_NameView, txt: lbl_Email, btn: UIButton(), mainviewtop: view7.bottomAnchor, isbuttonHidden: true)
        setCommonConstraint(mainView: view9, lbl_header: lbl_ContNum_Header, view: ContNum_NameView, txt: lbl_ContNum, btn: UIButton(), mainviewtop: view8.bottomAnchor, isbuttonHidden: true)
        setCommonConstraint(mainView: view10, lbl_header: lbl_ContPerson_Header, view: ContPerson_NameView, txt: lbl_ContPerson, btn: UIButton(), mainviewtop: view9.bottomAnchor, isbuttonHidden: true)
        
        addStack(stack: stack3, stackTop: view10.bottomAnchor, stackLeft: view10.leftAnchor, stackRight: view10.rightAnchor, view2: view11, view3: view12, lblHeader: lbl_Tagged_header, txt: lbl_Tagged, btn: Tagged_btn, viewdrop: TaggedView, lblHeader1: lbl_ClassFication_header, txt1: lbl_ClassFication, btn1: ClassFication_btn, viewdrop1: ClassFicationView, isButtonHidden1: false, isButtonHidden2: false)
        
        addStack(stack: stack4, stackTop: stack3.bottomAnchor, stackLeft: stack3.leftAnchor, stackRight: stack3.rightAnchor, view2: view13, view3: view14, lblHeader: lbl_Potential_header, txt: lbl_Potential, btn: UIButton(), viewdrop: PotentialView, lblHeader1: lbl_GSTNum_header, txt1: lbl_GSTNum, btn1: UIButton(), viewdrop1: GSTNumView, isButtonHidden1: true, isButtonHidden2: true)
        
        addStack(stack: stack5, stackTop: stack4.bottomAnchor, stackLeft: stack4.leftAnchor, stackRight: stack4.rightAnchor, view2: view15, view3: view16, lblHeader: lbl_Segment_header, txt: lbl_Segment, btn: Segment_btn, viewdrop: SegmentView, lblHeader1: lbl_ComBrand_header, txt1: lbl_ComBrand, btn1: UIButton(), viewdrop1: ComBrandView, isButtonHidden1: false, isButtonHidden2: true)
        
        insideView.addSubview(comBrandPic_lbl)
        comBrandPic_lbl.lbl_Constraint(top: stack5.bottomAnchor, left: stack5.leftAnchor, right: stack5.rightAnchor, isRight: false, paddingTop: 15, paddingLeft: 0, paddingRight: 0)
        
        insideView.addSubview(imgView)
        insideView.addSubview(btn_image)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        btn_image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imgView.topAnchor.constraint(equalTo: comBrandPic_lbl.bottomAnchor, constant: 15),
                                     imgView.leftAnchor.constraint(equalTo: comBrandPic_lbl.leftAnchor, constant: 0),
                                     imgView.widthAnchor.constraint(equalToConstant: 100),
                                     imgView.heightAnchor.constraint(equalToConstant: 100)])
        imgView.image = #imageLiteral(resourceName: "video")
        NSLayoutConstraint.activate([btn_image.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 0),
                                     btn_image.rightAnchor.constraint(equalTo: imgView.rightAnchor, constant: 0),
                                     btn_image.widthAnchor.constraint(equalToConstant: 30),
                                     btn_image.heightAnchor.constraint(equalToConstant: 30)])
        btn_image.setImage(#imageLiteral(resourceName: "s_cam"), for: .normal)
        insideView.addSubview(btn_AddReatiler)
        
        btn_AddReatiler.withoutBottomAnchor(top: imgView.bottomAnchor, left: insideView.leftAnchor, right: insideView.rightAnchor, paddingTop: 25, paddingLeft: 30, paddingRight: 30, height: CGFloat(obj.commonHeight))
        
        btn_AddReatiler.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        
        
        
    }
    
    func addStack(stack:UIStackView,stackTop:NSLayoutYAxisAnchor,stackLeft:NSLayoutXAxisAnchor,stackRight:NSLayoutXAxisAnchor,view2:UIView,view3:UIView,lblHeader:UILabel,txt:UITextField,btn:UIButton,viewdrop:UIView,lblHeader1:UILabel,txt1:UITextField,btn1:UIButton,viewdrop1:UIView,isButtonHidden1:Bool,isButtonHidden2:Bool){
        
        insideView.addSubview(stack)
        stack.withoutBottomAnchor(top: stackTop, left: stackLeft, right: stackRight, paddingTop: 15, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight + 5 + 15))
        
        stack.addArrangedSubview(view2)
        stack.addArrangedSubview(view3)
        
        txt.isEnabled = true
        txt1.isEnabled = true
        
        commonStackView(mainView: view2, lbl_header: lblHeader, view: viewdrop, txt: txt, btn: btn, isbuttonHidden: isButtonHidden1)
        commonStackView(mainView: view3, lbl_header: lblHeader1, view: viewdrop1, txt: txt1, btn: btn1, isbuttonHidden: isButtonHidden2)
        
    }
    
    func setCommonConstraint(mainView:UIView,lbl_header:UILabel,view:UIView,txt:UITextField,btn:UIButton,mainviewtop:NSLayoutYAxisAnchor,isbuttonHidden:Bool){
        
        insideView.addSubview(mainView)
        
        mainView.withoutBottomAnchor(top: mainviewtop, left: insideView.leftAnchor, right: insideView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: CGFloat(obj.commonHeight + 5 + 15))
        
        commonStackView(mainView: mainView, lbl_header: lbl_header, view: view, txt: txt, btn: btn, isbuttonHidden: isbuttonHidden)
        
    }
    
    func commonStackView(mainView:UIView,lbl_header:UILabel,view:UIView,txt:UITextField,btn:UIButton,isbuttonHidden:Bool){
        
        mainView.addSubview(lbl_header)
        mainView.addSubview(view)
        
        lbl_header.lbl_Constraint(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, isRight: false, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        view.withoutBottomAnchor(top: lbl_header.bottomAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, height: CGFloat(obj.commonHeight))
        view.addSubview(txt)
        txt.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 30)
        
        txt.isUserInteractionEnabled = true
        view.backgroundColor = .white
        
        
        if isbuttonHidden == false{
            view.addSubview(btn)
            btn.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
            
        }
        view.layer.cornerRadius = CGFloat(obj.commonHeight)/2
        view.layer.borderWidth = 1.0
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    //MARK:- Btn Action
    //MARK:-
    
    func setBtnTag(btn:UIButton,tag:Int){
        
        btn.tag = tag
        btn.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
    }
    
    @objc func btnClick(sender:UIButton){
        
        if sender.tag == 1{
            
            self.navigationController?.popViewController(animated: false)
        }else if sender.tag == 2 {
            
            let vc = SelectAddressVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            self.navigationController?.present(vc, animated: false, completion: nil)
            
        }else if sender.tag == 4{
            
             self.isStateORCustomerType = "tagCustomer"
            
            if (self.getRetailerViewModel.DictForDropDown.value(forKey: "taggedCustomerName") as? [String] ?? []).count > 0 {
             
                self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "taggedCustomerName") as? [String] ?? []), txtFld: self.lbl_Tagged, anchorView: self.TaggedView)
                
            }else{
                
                apicustomerBlocked()
                
            }
            
        }else if sender.tag == 5{
            
            self.isStateORCustomerType = ""
            
           if (getRetailerViewModel.DictForDropDown.value(forKey: "classification") as? [String] ?? []).count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "classification") as? [String] ?? []), txtFld: self.lbl_ClassFication, anchorView: self.ClassFicationView)
                
            }else{
                
                let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? ""] as [String:Any]
                getRetailerViewModel.getclassficationAndsegmentDataFromApiHandler(strUrl: "classification", passDict: passDict) { (message) in
                    
                    if message == "Data found"{
                        
                        self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "classification") as? [String] ?? []), txtFld: self.lbl_ClassFication, anchorView: self.ClassFicationView)
                        
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: message))
                    }
                    
                }
                
            }
            
        }else if sender.tag == 7{
            
            self.isStateORCustomerType = ""
            
            if (getRetailerViewModel.DictForDropDown.value(forKey: "segment") as? [String] ?? []).count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "segment") as? [String] ?? []), txtFld: self.lbl_Segment, anchorView: self.SegmentView)
                
            }else{
                
                let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? ""] as [String:Any]
                getRetailerViewModel.getclassficationAndsegmentDataFromApiHandler(strUrl: "classification", passDict: passDict) { (message) in
                    
                    if message == "Data found"{
                        
                        self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "segment") as? [String] ?? []), txtFld: self.lbl_Segment, anchorView: self.SegmentView)
                        
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: message))
                    }
                    
                }
                
            }
            
        }else if sender.tag == 9{
            
            self.openActionSheet()
            
        }else if sender.tag == 10 {
            
            self.isStateORCustomerType = "State"
            
            if self.getCityBeatFromViewModel.getCityDataArr.count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.lbl_City, anchorView: self.CityView)
                
            }else{
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
                    Indicator.shared.showProgressView(view)
                    getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                        
                        self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.lbl_City, anchorView: self.CityView)
                        
                    }
                    
                }
            }
        }else if sender.tag == 11{
            
             self.isStateORCustomerType = ""
            
            if self.getCityBeatFromViewModel.getBeatDataArr.count > 0 {
                
                self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "beat") as? [String] ?? []), txtFld: self.lbl_Beat, anchorView: self.BeatView)
                
            }else{
                
                if InternetConnection.internetshared.isConnectedToNetwork(){
                    
                    let passData = ["zone":userData.value(forKey: "Zone") ?? "","hq":userData.value(forKey: "HQ") ?? ""] as [String:Any]
                    Indicator.shared.showProgressView(view)
                    getCityBeatFromViewModel.getBeatDataFromApiHandlerClass(url: "getCityBeat", passDict: passData) { (_) in
                        
                         self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "beat") as? [String] ?? []), txtFld: self.lbl_Beat, anchorView: self.BeatView)
                        
                    }
                    
                }
            }
        }else if sender.tag == 12{
            
            self.validation()
            
        }else if sender.tag == 14{
            
            self.isStateORCustomerType = "CustType"
            
            if (getRetailerViewModel.DictForDropDown.value(forKey: "CustomerType") as? [String] ?? []).count > 0 {
                
                self.dropDownDataSource(dataSource: (getRetailerViewModel.DictForDropDown.value(forKey: "CustomerType") as? [String] ?? []), txtFld: self.lbl_Cust, anchorView: self.custView)
                
            }else{
                
                let passDict = ["salesPersonCode":userData.value(forKey: "Code") ?? ""] as [String:Any]
                getRetailerViewModel.getclassficationAndsegmentDataFromApiHandler(strUrl: "classification", passDict: passDict) { (message) in
                    
                    if message == "Data found"{
                        
                        self.dropDownDataSource(dataSource: (self.getRetailerViewModel.DictForDropDown.value(forKey: "CustomerType") as? [String] ?? []), txtFld: self.lbl_Cust, anchorView: self.custView)
                        
                    }else{
                        
                        self.alert(message: self.obj.createString(Str: message))
                    }
                    
                }
                
            }
        }
    }
    
    func commonDataOnButton(btn:UIButton){
        
        getRetailerViewModel.setDataOnButton(btn: btn, text: "", font: "", size: 15, textcolor: UIColor(), image: #imageLiteral(resourceName: "down"), backGroundColor: UIColor.clear, aliment: .right)
       
    }
}

//MARK:- SelectAddressVCDelegate Call
//MARK:-

extension NewRetailerVC:SelectAddressVCDelegate{
    
    
    func address(text: String, lat: String, long: String) {
        
        print(text,lat,long)
        
    }
     
}
//MARK:- Location Delegates

extension NewRetailerVC{
    
    func initializeTheLocationManager()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locationManager.location?.coordinate
        self.lat = location?.latitude.description ?? "0.0"
        self.long = location?.longitude.description ?? "0.0"
        
        
    }
    
    @available(iOS 10.0, *)
    func locationDenied(){
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                
                print("No access")
                
            case .authorizedAlways, .authorizedWhenInUse:
                
                print("Access")
                
            case .restricted:
                
                print("No access")
                
            case .denied:
                
                print("No access")
                
                let settingAlert = UIAlertController(title: obj.createString(Str: "AIPL-ABRO"), message: obj.createString(Str: "Turn on your Location from the settings to help us locate you"), preferredStyle: .alert)
                let okAction = UIAlertAction(title: obj.createString(Str: "Settings"), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    self.showUserSettings()
                }
                
                
                let cancelAction = UIAlertAction(title: obj.createString(Str: "Cancel"), style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                }
                
                settingAlert.addAction(okAction)
                settingAlert.addAction(cancelAction)
                self.present(settingAlert, animated: true, completion: nil)
                
            }
            
            
        } else {
            print("Location services are not enabled")
        }
        
    }
    
    //TODO:- Custom Method to show user Location
    
    func showUserSettings() {
        guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(urlGeneral)
    }
}
