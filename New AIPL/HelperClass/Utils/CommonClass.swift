//
//  CommonClass.swift
//  AIPL
//
//  Created by apple on 06/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit
class CommonClass{
    
static let sharedInstance = CommonClass()
   
   let commonTxtFldColor = UIColor.darkGray as UIColor
   let commonAppRedColor = #colorLiteral(red: 0.9294338822, green: 0.1960918307, blue: 0.2157041132, alpha: 1) as UIColor
   let commonAppGreenColor = #colorLiteral(red: 0.250670284, green: 0.7255248427, blue: 0.2430937886, alpha: 1) as UIColor
   let commonAppblueColor = #colorLiteral(red: 0, green: 0.4863165617, blue: 0.862636745, alpha: 1) as UIColor
   let commonAppLightblueColor = #colorLiteral(red: 0.6979563236, green: 0.7725954652, blue: 0.8744030595, alpha: 1) as UIColor
   let commonAppbackgroundColor = #colorLiteral(red: 0.9371666312, green: 0.9608388543, blue: 0.9920384288, alpha: 1) as UIColor
   let tableDarkGray = #colorLiteral(red: 0.8705055118, green: 0.8941686153, blue: 0.9214581251, alpha: 1)
   let lightGray = #colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)
   let tablelightGray = #colorLiteral(red: 0.9371666312, green: 0.9608388543, blue: 0.9920384288, alpha: 1)
   var commonwhiteColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
   let commonAppTextLightColor = UIColor.lightGray
   let commonAppTextDrakColor = #colorLiteral(red: 0.156845212, green: 0.1568739414, blue: 0.1568388939, alpha: 1)
   let regularfontSize = 15 as CGFloat
   let semiBoldfontSize = 16 as CGFloat
   let BoldfontSize = 17 as CGFloat
   let appName = "AIPL"
   let MediumFont = "SourceSansPro-Semibold"
   let BoldFont = "SourceSansPro-Bold"
   let RegularFont = "SourceSansPro-Regular"
   let baseURL =  "http://13.58.229.225:5002/"
   let imageStartDay = "http://13.58.229.225/public/images/startday/"
   let retailerImageUrl = "http://13.58.229.225/public/images/retailers/"
   let commonHeight = 45
    func createString<T>(Str: T) -> T
    {
        return Str
    }
}
