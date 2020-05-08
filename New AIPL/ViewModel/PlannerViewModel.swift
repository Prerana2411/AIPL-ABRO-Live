//
//  PlannerViewModel.swift
//  AIPL ABRO
//
//  Created by CST on 22/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
import iOSDropDown

class PlannerViewModel {
    
    var apiHandler = ApiHandler()
   // var getDataArr = [PlannerModel]()
    var getDataArrForEditList = [EditPlannerModel]()
 //   var getEditArr = [EditPlnnerArrModel]()
    var delegate : ReloadTableView?
    
    var getDataArr : [PlannerModel] = []{
         
         didSet{
            if (self.getDataArr != oldValue){
                delegate?.reloadTable()
             }
             
         }willSet(newValue){
             
            self.getDataArr = newValue
         }
     }
    
    var getEditArr : [EditPlnnerArrModel] = []{
            
            didSet{
               if (self.getEditArr != oldValue){
                   delegate?.reloadTable()
                }
                
            }willSet(newValue){
                
               self.getEditArr = newValue
            }
        }
    
    
    func getDataFromApiHandlerClass(url:String,passDict:[String:Any],complitionBlock1:@escaping ([PlannerModel],_ message:String) ->(),complitionBlock2:@escaping ([EditPlannerModel],_ message:String) ->()){
     
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
             let message = responseJSON["message"].string ?? ""
            if responseJSON["response"].bool == true && responseJSON["gotoEdit"].bool == true{
                
                 if let dataObj = responseJSON["dataObj"].dictionary{
                
                    if self.getDataArrForEditList.count > 0 {
                        
                        self.getDataArrForEditList.removeAll()
                        
                    }
                    
                  var PlannerNoR = String()
                  var SalesPersonCodeR = String()
                  var SalesPersonNameR = String()
                  var SalePersonMobileR = String()
                  var SalePersonEMailR = String()
                  var HQR = String()
                  var FromDateR = String()
                  var ToDateR = String()
                  var CreateDateR = String()
                  var No_SeriesR = String()
                  var MonthR = String()
                  var YearR = String()
                  var StatusR = String()
                    
                    if let PlannerNo = dataObj["Planner No"]?.string{
                        
                        PlannerNoR = PlannerNo
                        
                    }
                    if let SalesPersonCode = dataObj["Sales Person Code"]?.string{
                        
                        SalesPersonCodeR = SalesPersonCode
                    }
                    if let SalePersonMobile = dataObj["SalePerson Mobile"]?.string{
                                           
                        SalePersonMobileR = SalePersonMobile
                    }
                    if let SalesPersonName = dataObj["SalePerson Name"]?.string{
                        
                        SalesPersonNameR = SalesPersonName
                    }
                    if let SalePersonEMail = dataObj["SalePerson E-Mail"]?.string{
                        
                       SalePersonEMailR = SalePersonEMail
                    }
                    if let HQ = dataObj["HQ"]?.string{
                        
                        HQR = HQ
                    }
                    if let FromDate = dataObj["From Date"]?.string{
                        
                        FromDateR = FromDate
                    }
                    if let ToDate = dataObj["To Date"]?.string{
                        
                         ToDateR = ToDate
                    }
                    if let CreateDate = dataObj["Create Date"]?.string{
                        
                        CreateDateR = CreateDate
                    }
                    if let No_Series = dataObj["No_ Series"]?.string{
                        
                        No_SeriesR = No_Series
                    }
                    if let Month = dataObj["Month"]?.int{
                        
                        MonthR = String(Month)
                    }
                    if let Year = dataObj["Year"]?.int{
                        
                       YearR = String(Year)
                        
                    }
                    if let Status = dataObj["Status"]?.string{
                        
                         StatusR = Status
                    }
                
                    if let planData = dataObj["planData"]?.arrayObject{
                        
                        if self.getDataArr.count > 0 {
                            
                            self.getDataArr.removeAll()
                        }
                        
                        for item in planData{
                           
                            var PlannerNoT = String()
                            var SalesPersonCodeT = String()
                            var SalesPersonNameT = String()
                            var LineNoT = String()
                            var PlannerDateT = String()
                            var HQT = String()
                            var PlannerDaysT = String()
                            var CityT = String()
                            var RemarksT = String()
                            var NightHaltT = String()
                            var EditedT = String()
                            var BeatT = String()
                            
                            if let planDict = item as? NSDictionary{
                                
                                if let plannerNo = planDict.value(forKey: "Planner No") as? String{
                                    
                                    PlannerNoT = plannerNo
                                }
                                if let SalesPersonCode = planDict.value(forKey: "Sales Person Code") as? String{
                                    
                                    SalesPersonCodeT = SalesPersonCode
                                }
                                if let SalesPersonName = planDict.value(forKey: "SalePerson Name") as? String{
                                    
                                    SalesPersonNameT = SalesPersonName
                                }
                                if let LineNo = planDict.value(forKey: "Line No") as? Int{
                                    
                                    LineNoT = String(LineNo)
                                }
                                if let PlannerDate = planDict.value(forKey: "Planner Date") as? String{
                                    
                                    PlannerDateT = String(PlannerDate.prefix(10))
                                }
                                if let PlannerDays = planDict.value(forKey: "Planner Days") as? String{
                                    
                                    PlannerDaysT = PlannerDays
                                }
                                if let City = planDict.value(forKey: "City") as? String{
                                    
                                    CityT = City
                                }
                                if let Remarks = planDict.value(forKey: "Remarks") as? String{
                                    
                                    RemarksT = Remarks
                                }
                                if let SalePersonHQ = planDict.value(forKey: "SalePerson HQ") as? String{
                                    
                                    HQT = SalePersonHQ
                                }
                                if let NightHalt = planDict.value(forKey: "Night Halt") as? Int{
                                    
                                    NightHaltT = String(NightHalt)
                                }
                                if let Edited = planDict.value(forKey: "Edited") as? Int{
                                    
                                    EditedT = String(Edited)
                                }
                                if let Beat = planDict.value(forKey: "Beat") as? String{
                                    
                                    BeatT = Beat
                                }
                                
                            }
                            
                         //   let item = PlannerModel(compareDate: String(), SalesPersonCode: SalesPersonCodeT, SalesPersonName: SalesPersonNameT, plannerDate: PlannerDateT, plannerDays: PlannerDaysT, Headquarter: HQT, City: CityT, remarks: RemarksT, salePersonHQ: HQT, Edited: EditedT, nightHalt: NightHaltT, beat: BeatT)
                            
                            let item1 = EditPlnnerArrModel(plannerNo: PlannerNoT, SalesPersonCode: SalesPersonCodeT, SalesPersonName: SalesPersonNameT, plannerDate: PlannerDateT, plannerDays: PlannerDaysT, Headquarter: HQT, City: CityT, remarks: RemarksT, salePersonHQ: HQT, Edited: EditedT, nightHalt: NightHaltT, beat: BeatT, lineNo: LineNoT)
                            
                            self.getEditArr.append(item1)
                            
                        }
                        
                        
                    }
                    
                    let item = EditPlannerModel(PlannerNo: PlannerNoR, SalesPersonCode: SalesPersonCodeR, SalesPersonName: SalesPersonNameR, SalePersonMobile: SalePersonMobileR, SalePersonEMail: SalePersonEMailR, HQ: HQR, FromDate: FromDateR, ToDate: ToDateR, CreateDate: CreateDateR, No_Series: No_SeriesR, Month: MonthR, Year: YearR, Status: StatusR, plannerModelArr: self.getEditArr)
                    
                    self.getDataArrForEditList.append(item)
                    
                    complitionBlock2(self.getDataArrForEditList,message)
                  
                 }else{
                    
                    complitionBlock2(self.getDataArrForEditList,message)
                }
                 
            }else if responseJSON["response"].bool == false && responseJSON["gotoEdit"].bool == false{
                
                
                if let planData = responseJSON["planData"].arrayObject{
                                       
                    if self.getDataArr.count > 0 {
                        
                        self.getDataArr.removeAll()
                    }
                    
                    for item in planData{
                        
                        var PlannerNoT = String()
                        var SalesPersonCodeT = String()
                        var SalesPersonNameT = String()
                        var LineNoT = String()
                        var PlannerDateT = String()
                        var HQT = String()
                        var PlannerDaysT = String()
                        var CityT = String()
                        var RemarksT = String()
                        var NightHaltT = String()
                        var EditedT = String()
                        var BeatT = String()
                        
                        if let planDict = item as? NSDictionary{
                            
                            if let plannerNo = planDict.value(forKey: "Planner No") as? String{
                                
                                PlannerNoT = plannerNo
                            }
                            if let SalesPersonCode = planDict.value(forKey: "salesPersonCode") as? String{
                                
                                SalesPersonCodeT = SalesPersonCode
                            }
                            if let SalesPersonName = planDict.value(forKey: "salePersonName") as? String{
                                
                                SalesPersonNameT = SalesPersonName
                            }
                            if let LineNo = planDict.value(forKey: "Line No") as? String{
                                
                                LineNoT = LineNo
                            }
                            if let PlannerDate = planDict.value(forKey: "plannerDate") as? String{
                                
                                PlannerDateT = PlannerDate
                            }
                            if let PlannerDays = planDict.value(forKey: "plannerDays") as? String{
                                
                                PlannerDaysT = PlannerDays
                            }
                            if let City = planDict.value(forKey: "city") as? String{
                                
                                CityT = City
                            }
                            if let Remarks = planDict.value(forKey: "remarks") as? String{
                                
                                RemarksT = Remarks
                            }
                            if let SalePersonHQ = planDict.value(forKey: "salePersonHQ") as? String{
                                
                                HQT = SalePersonHQ
                            }
                            if let NightHalt = planDict.value(forKey: "nightHalt") as? Int{
                                
                                NightHaltT = String(NightHalt)
                            }
                            if let Edited = planDict.value(forKey: "edited") as? Int{
                                
                                EditedT = String(Edited)
                            }
                            if let Beat = planDict.value(forKey: "beat") as? String{
                                
                                BeatT = Beat
                            }
                            
                        }
                        
                        let item = PlannerModel(compareDate: String(), SalesPersonCode: SalesPersonCodeT, SalesPersonName: SalesPersonNameT, plannerDate: PlannerDateT, plannerDays: PlannerDaysT, Headquarter: HQT, City: CityT, remarks: RemarksT, salePersonHQ: HQT, Edited: EditedT, nightHalt: NightHaltT, beat: BeatT)
                        
                        self.getDataArr.append(item)
                        
                    }
                                       
                    complitionBlock1(self.getDataArr,message)
                }else{
                    
                    complitionBlock1(self.getDataArr,message)
                }
                
            }
            
        }
        
    }
  
    //MARK:- Add Planner Api
    //MARK:-
    
    func addPlannerApi(url:String,passDict:[String:Any],complition:@escaping (_ message:String)->()){
        
        apiHandler.getDataFromApi(withUrl: url, passDict: passDict) { (responseJSON) in
            
            print(responseJSON)
            
            let message = responseJSON["message"].string ?? ""
            
            complition(message)
        }
        
    }
    
    
    func getNumberOfRowInSection(count:Int) ->Int{
        
        return count + 1
        
    }
    
    func getDayForEachRow(index:Int) -> String{
        
        return getDataArr[index - 1].plannerDays ?? ""
    }
    
    func getEditDayForEachRow(index:Int) -> String{
        
        return getEditArr[index - 1].plannerDays ?? ""
    }
    
    func getDateForEachRow(index:Int) -> String{
        
        return String(index)
    }
    func getEditDateForEachRow(index:Int) -> String{
        
        return String(index)
    }
    
    func getCityForEachRow(index:Int) ->String{
        
        return getDataArr[index - 1].City ?? "" == ""  ? "City" : getDataArr[index - 1].City ?? ""
    }
    
    func getEditCityForEachRow(index:Int) ->String{
        
        return getEditArr[index - 1].City ?? "" == ""  ? "City" : getEditArr[index - 1].City ?? ""
    }
    
    func getBeatForEachRow(index:Int) ->String{
        
       return getDataArr[index - 1].beat ?? "" == ""  ? "Beat" : getDataArr[index - 1].beat ?? ""
    }
    
    func getEditBeatForEachRow(index:Int) ->String{
        
       return getEditArr[index - 1].beat ?? "" == ""  ? "Beat" : getEditArr[index - 1].beat ?? ""
    }
    
    func getNightForEachRow(index:Int) ->String{
       
       return getDataArr[index - 1].nightHalt ?? "" == ""  ? "0" : getDataArr[index - 1].nightHalt ?? ""
       
    }
    
    func getEditNightForEachRow(index:Int) ->String{
       
       return getEditArr[index - 1].nightHalt ?? "" == ""  ? "0" : getEditArr[index - 1].nightHalt ?? ""
       
    }
    
    func getRemarkForEachRow(index:Int) ->String{
        
    return getDataArr[index - 1].remarks ?? "" == ""  ? "Remark" : getDataArr[index - 1].remarks ?? "Remark"
      
    }
    
    func getEditRemarkForEachRow(index:Int) ->String{
        
    return getEditArr[index - 1].remarks ?? "" == ""  ? "Remark" : getEditArr[index - 1].remarks ?? "Remark"
      
    }
    
    //MARK:- Custom Method To Set Font and Color
         
      func setFontandColor(lbl:UILabel,color:UIColor,font:String,size:CGFloat,text:String,textAliment:NSTextAlignment){
          
        lbl.text = CommonClass.sharedInstance.createString(Str: text)
             lbl.textColor = color
             lbl.font = UIFont.appCustomFont(fontName: font, size: size)
             lbl.textAlignment = textAliment
             lbl.numberOfLines = 0
         }
    
    func setFontandColor1(lbl:DropDown,color:UIColor,font:String,size:CGFloat,text:String,textAliment:NSTextAlignment){
      
    lbl.text = CommonClass.sharedInstance.createString(Str: text)
         lbl.textColor = color
         lbl.font = UIFont.appCustomFont(fontName: font, size: size)
         lbl.textAlignment = textAliment
         //lbl.numberOfLines = 0
     }
    
      func commonMethodforBackColor(color:UIColor,view:UIView){
          
           view.backgroundColor = color
      }
      
    func commonMethoToSetImage(btn:UIButton,image:UIImage,hidden:Bool){
          btn.isHidden = hidden
          btn.setImage(image, for: .normal)
          btn.contentHorizontalAlignment = .right
      }
    func setColorFontImage(txtFld:UITextField,btn:UIButton,color:UIColor,image:UIImage,text:String){
        
            txtFld.placeholder = CommonClass.sharedInstance.createString(Str: text)
            txtFld.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
            txtFld.textColor = color
            btn.setImage(image, for: .normal)
        
    }
}
