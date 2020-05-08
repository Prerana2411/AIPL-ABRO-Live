//
//  NewPlannerCell.swift
//  AIPL
//
//  Created by apple on 08/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import DropDown

protocol NewPlannerCelldelegate {
    
    func newValueForCity(text:String,index:Int)
    func newValueForBeat(text:String,index:Int)
    func newValueForNightHalt(text:String,index:Int)
}

class NewPlannerCell: UITableViewCell {
    
    
    //MARK:- Variable
    //MARK:-
    
    lazy var lbl_Date = UILabel()
   
    lazy var lbl_City = UILabel()
    lazy var lbl_Beat = UILabel()
    lazy var btn_City = UIButton()
    lazy var btn_Beat = UIButton()
    var dropDown = DropDown()
    lazy var view_City = UIView()
    lazy var view_Beat = UIView()
    lazy var view1 = UIView()
    lazy var view2 = UIView()
    lazy var view3 = UIView()
    var getCityBeatFromViewModel = StartDayViewModel()
    var getPlannerViewModel = PlannerViewModel()
    
    let userData = UserDefaults.standard.value(forKey: "loginData") as? NSDictionary ?? [:]
    lazy var HStack : UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 1
        return stack
    }()
    var delegate : NewPlannerCelldelegate?
    var index = Int()
    let obj = CommonClass.sharedInstance
    var nav = UINavigationController()
    
    //MARK:- LifeCycle
    //MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = CommonClass.sharedInstance.commonAppLightblueColor
        
        addSubview(lbl_Date)
        addSubview(HStack)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Configure UIComponent
    //MARK:-
    
    func configureComponent(){
        
        lbl_Date.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lbl_Date.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     lbl_Date.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
                                     lbl_Date.widthAnchor.constraint(equalToConstant: 70),
                                     lbl_Date.heightAnchor.constraint(equalToConstant: 55)])
        
        HStack.scrollAnchor(top: topAnchor, left: lbl_Date.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 1, paddingBottom: 0, paddingRight: 0)
        HStack.heightAnchor.constraint(equalToConstant: 55).isActive = true
        contentView.backgroundColor = CommonClass.sharedInstance.commonAppLightblueColor
        HStack.addArrangedSubview(view_City)
        HStack.addArrangedSubview(view_Beat)
        commonConstraint(view: view_City, item: lbl_City)
        commonConstraint(view: view_City, item: btn_City)
        commonConstraint(view: view_Beat, item: lbl_Beat)
        commonConstraint(view: view_Beat, item: btn_Beat)
        boderConstraint(item: lbl_Date, view1: view1)
        boderConstraint(item: view_City, view1: view2)
        boderConstraint(item: view_Beat, view1: view3)
        btn_City.addTarget(self, action:#selector(cellCityClick(sender:)) , for: .touchUpInside)
        btn_Beat.addTarget(self, action: #selector(cellBeatClick(sender:)), for: .touchUpInside)
       
    }
    
    func commonConstraint(view:UIView,item:UIView){
        
        view.addSubview(item)
        item.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 25)
        
    }
    
    
    func boderConstraint(item:UIView,view1:UIView)  {
        
        addSubview(view1)
        view1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([view1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                                     view1.centerXAnchor.constraint(equalTo: item.centerXAnchor, constant: 0),
                                     view1.widthAnchor.constraint(equalTo: item.widthAnchor, multiplier: 0.7),
                                     view1.heightAnchor.constraint(equalToConstant: 1)])
        
        item.backgroundColor = .white
        view1.backgroundColor = CommonClass.sharedInstance.tableDarkGray
        
    }
    //MARK:- Cell Btn Action
    //MARK:-
    
    @objc func cellCityClick(sender:UIButton){
        
        self.index = sender.tag
        self.lbl_City.tag = 10
        
        if self.getCityBeatFromViewModel.getCityDataArr.count > 0 {
            
            self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "city") as? [String] ?? []), txtFld: self.lbl_City, anchorView: self.view_City)
            
        }
    }
    
    
    
    
    @objc func cellBeatClick(sender:UIButton){
        
        self.index = sender.tag
        self.lbl_Beat.tag = 11
        
        if self.getCityBeatFromViewModel.getBeatDataArr.count > 0 {
            
            self.dropDownDataSource(dataSource: (self.getCityBeatFromViewModel.DictForCityAndBeat.value(forKey: "beat") as? [String] ?? []), txtFld: self.lbl_Beat, anchorView: self.view_Beat)
            
        }
    }
    
    @objc func cellNightHaltClick(sender:UIButton){
        
      
        
    }
    
    @objc func btnRemark(sender:UIButton){
        
        let vc = RemarkVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.nav.present(vc, animated: false, completion: nil)
        
    }
    
    
    //MARK:- DropDown
    //MARK:-
    func dropDownDelegate(textField:UILabel,view:UIView) {
        
        dropDown.anchorView = view
        dropDown.animationEntranceOptions = .allowAnimatedContent
        dropDown.backgroundColor = obj.commonAppRedColor
        dropDown.textColor = UIColor.white
        dropDown.textFont = UIFont(name: obj.MediumFont, size: obj.semiBoldfontSize) ?? UIFont()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            textField.text = item
            
            if textField.tag == 10{
                self?.delegate?.newValueForCity(text: item, index: self?.index ?? 0)
            }else if textField.tag == 11{
                self?.delegate?.newValueForBeat(text: item, index: self?.index ?? 0)
            }else if textField.tag == 12{
                
                self?.delegate?.newValueForNightHalt(text: item, index: self?.index ?? 0)
            }
            
        }
    }
    
    func dropDownDataSource(dataSource:[String],txtFld:UILabel,anchorView:UIView){
        
        
        DispatchQueue.main.async {
            
            if dataSource.count > 0 {
                
                if self.dropDown.dataSource.count > 0 {
                    
                    self.dropDown.dataSource.removeAll()
                }
                self.dropDownDelegate(textField: txtFld,view:anchorView)
                self.dropDown.dataSource = dataSource
                self.dropDown.show()
               
                
            }
        }
        
    }
    
}

extension NewPlannerCell:RemarkVCDelegate{
    
    func remark(endDay remarks: String) {
        
      //  self.lbl_Remark.text = remarks
        
    }
     
}
