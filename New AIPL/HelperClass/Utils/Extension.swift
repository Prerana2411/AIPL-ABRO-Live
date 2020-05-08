//
//  Extension.swift
//  AIPL
//
//  Created by apple on 06/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

extension UIView {
    
   
    func center(inView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func popup(inView:UIView,width:CGFloat,height:CGFloat){
        
        center(inView: inView)
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func anchorWithoutRigthAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat,view:UIView){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        NSLayoutConstraint.activate([widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
                                     heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)])
        
    }
    
    func anchorForLogo(left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, width: CGFloat, height: CGFloat,view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func scrollAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
    }
    func withoutBottomAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if height != 0 {
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
            
        }
    }
    
    func withoutBottomAnchorHeightGreater(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if height != 0 {
            //heightAnchor.constraint(equalToConstant: height).isActive = true
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }
    }
    
    func lbl_Constraint(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,isRight:Bool,paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
               
               if let top = top {
                   self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
               }
        
              if isRight == true{
            
                if let right = right {
                     rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
                 }
              }
             else{
                if let left = left {
                   self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
               }
               
        }
        
    }
    
    func naviView(navView:UIView,rightBtn:UIButton,leftBtn:UIButton,logoImg:UIImageView,title:UILabel,isLogoHidden:Bool) -> UIView{
        
        
        navView.addSubview(leftBtn)
        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        
        leftBtn.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        leftBtn.leftAnchor.constraint(equalTo: navView.leftAnchor, constant: 0).isActive = true
        leftBtn.heightAnchor.constraint(equalToConstant: 54).isActive = true
        leftBtn.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        navView.addSubview(rightBtn)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        
        rightBtn.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        rightBtn.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: 0).isActive = true
        rightBtn.heightAnchor.constraint(equalToConstant: 54).isActive = true
        rightBtn.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        if isLogoHidden == true{
            
            navView.addSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false
            
            title.centerXAnchor.constraint(equalTo: navView.centerXAnchor, constant: 0).isActive = true
            title.centerYAnchor.constraint(equalTo: leftBtn.centerYAnchor, constant: 0).isActive = true
            
        }else{
            navView.addSubview(logoImg)
            logoImg.translatesAutoresizingMaskIntoConstraints = false
            
            logoImg.centerXAnchor.constraint(equalTo: navView.centerXAnchor, constant: 0).isActive = true
            logoImg.centerYAnchor.constraint(equalTo: leftBtn.centerYAnchor, constant: 0).isActive = true
            NSLayoutConstraint.activate([logoImg.heightAnchor.constraint(equalToConstant: 35),
                                         logoImg.widthAnchor.constraint(greaterThanOrEqualToConstant: 35)])
        }
        
        
        
        return navView
    }
    
    func searchBar(view:UIView,insideView:UIView,filterBtn:UIButton,searBar:UISearchBar,searchBtn:UIButton) -> UIView{
        
        insideView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([insideView.heightAnchor.constraint(equalToConstant: 40),
                                     insideView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     insideView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                                     insideView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)])
        insideView.layer.cornerRadius = 40/2
        insideView.clipsToBounds = true
        insideView.addSubview(filterBtn)
        insideView.addSubview(searBar)
        insideView.addSubview(searchBtn)
        filterBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([filterBtn.heightAnchor.constraint(equalToConstant: 40),
                                     filterBtn.widthAnchor.constraint(equalToConstant: 40),
                                     filterBtn.rightAnchor.constraint(equalTo: insideView.rightAnchor, constant: 0),
                                     filterBtn.centerYAnchor.constraint(equalTo: insideView.centerYAnchor)])
        
        searBar.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: filterBtn.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
        searBar.layer.cornerRadius = 40/2
        searBar.clipsToBounds = true
        searchBtn.scrollAnchor(top: insideView.topAnchor, left: insideView.leftAnchor, bottom: insideView.bottomAnchor, right: filterBtn.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
        
        return insideView
    }
    
    func CommonViewLableButton(view:UIView,btn:UIButton,lbl:UIView) -> UIView{
        
        view.addSubview(lbl)
        view.addSubview(btn)
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1.0
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15 , paddingBottom: 0, paddingRight: 0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
        btn.contentHorizontalAlignment = .right
        
        return view
    }
    
    //MARK:- Custom DatePicker
    //MARK:-
    
    func openDatePicker(sender:Int,baseview:UIView,doneButton:UIButton,cancelButton:UIButton,txtDate:UITextField) -> UIView{
        
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.backgroundColor = UIColor.clear
        baseview.addSubview(doneButton)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.backgroundColor = UIColor.clear
        baseview.addSubview(cancelButton)
        
        //let minDate = Date()
        let maxDate = setMinAndMaxDateForDatePicker(maxYear: 80, minYear: 20).1
        
        var datePickerView: UIDatePicker!
        datePickerView  = UIDatePicker(frame: CGRect(x:0, y: 50, width: baseview.frame.width, height:baseview.frame.height - 50))
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.backgroundColor = UIColor.white
        datePickerView.tag = 5454
        datePickerView.maximumDate = maxDate
        datePickerView.minimumDate = NSDate(timeIntervalSinceNow:  30) as Date // Change for current date
        baseview.addSubview(datePickerView)
        
        if(sender == sender){
            
            if(txtDate.text!.count > 0 )
            {
                let selectedDate = txtDate.text!
                let dateFormatter = DateFormatter()
               // dateFormatter.dateFormat =  "dd-MM-yyyy"
                 dateFormatter.dateFormat =  "yyyy-MM-dd"
                let dateObj = dateFormatter.date(from: selectedDate)
                datePickerView.setDate(dateObj!, animated: false)
            }
        }
        
        return baseview
    }
    
    func setMinAndMaxDateForDatePicker(maxYear: Int,minYear: Int) -> (Date , Date)
    {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        
        components.calendar = calendar
        components.year = -minYear
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = maxYear
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        return( minDate,maxDate)
    }
    
    //MARK:- Custom TimePicker
    //MARK:-
    
    func openTimePicker(sender:Int,baseview:UIView,doneButton:UIButton,cancelButton:UIButton,txtTime:UITextField) -> UIView{
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.backgroundColor = UIColor.clear
        baseview.addSubview(doneButton)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.backgroundColor = UIColor.clear
        baseview.addSubview(cancelButton)
        
        var timePickerView: UIDatePicker!
        timePickerView  = UIDatePicker(frame: CGRect(x:0, y: 50, width: baseview.frame.width, height:baseview.frame.height - 50))
        timePickerView.datePickerMode = UIDatePicker.Mode.time
        
        let dateFormeter = DateFormatter()
        dateFormeter.dateFormat = "yyyy-MM-dd"
        let strSelectdate = txtTime.text!
        let CurrentDate = Date()
        let strCurrentDate = dateFormeter.string(from: CurrentDate)
        if strCurrentDate == strSelectdate{
            
            timePickerView.minimumDate = Date()
        }
        
        timePickerView.backgroundColor = UIColor.white
        timePickerView.tag = 5450
        
        baseview.addSubview(timePickerView)
        
        if(sender == 8){
            
            if(txtTime.text!.count > 0)
            {
                let selectedTime = txtTime.text!
                let timeFormatter = DateFormatter()
                timeFormatter.timeStyle = .short
                let dateObj = timeFormatter.date(from: selectedTime)
                timePickerView.setDate(dateObj!, animated: false)
            }
        }
        
        return baseview
    }
}
extension UIFont {

    class func appCustomFont(fontName:String,size:CGFloat) -> UIFont {
        
        return UIFont(name: fontName, size: size)!
    }
}

/// Computed properties, based on the backing CALayer property, that are visible in Interface Builder.
extension UIView {
    
    
    /// When positive, the background of the layer will be drawn with rounded corners. Also effects the mask generated by the `masksToBounds' property. Defaults to zero. Animatable.
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    /// The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    
    
}

//#MARK: - Gradiont Color
extension UIView {
    
    func applyGradient(btn: UIView,with CornerRadius: Float) {
        
        //        let gradient:CAGradientLayer = CAGradientLayer()
        //        gradient.colors = [GlobleConstants.gradientColorTop.cgColor, GlobleConstants.gradientColorBottom.cgColor]
        //        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        //        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        //        btn.layer.masksToBounds = true
        //        btn.clipsToBounds = true
        //        gradient.frame = btn.bounds
        //        gradient.cornerRadius = CGFloat(CornerRadius)
        //        btn.layer.addSublayer(gradient)
        
    }
    
    func shake(duration: CFTimeInterval) {
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (M_PI_2 * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    //FadeIn Animation.. Usage likes self.lbl.fadeIn()
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    //FadeOut Animation.. Usage likes self.lbl.fadeOut()
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    
    func fadeOutImmidiatlyWithoutshowingEffect(_ duration: TimeInterval = 0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    
}


//Mark: extension for round two cornor

extension UIView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
}

extension UIButton {
    
    func roundCornersButton(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
}

//#MARK: - Extension String

extension String
{
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    var length: Int {
        return 23
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

//#MARK: - Extension UIApplication

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


//#MARK: - Extension TextField Placeholder

extension UITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func lenth()-> Int{
        
        
        return self.text!.count
        
    }
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    
}

//#MARK: - UIViewController

extension UIViewController {
    
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//#MARK: - Double
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
//#MARK: - Image Extension

extension UIImage {
    
    
    func maskWithColor(_ color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
 /*
    func resizeImage(image:UIImage, maxHeight:Float, maxWidth:Float) -> UIImage
    {
        var actualHeight:Float = Float(image.size.height)
        var actualWidth:Float = Float(image.size.width)
        
        var imgRatio:Float = actualWidth/actualHeight
        let maxRatio:Float = maxWidth/maxHeight
        
        if (actualHeight > maxHeight) || (actualWidth > maxWidth)
        {
            if(imgRatio < maxRatio)
            {
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio)
            {
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else
            {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:NSData = UIImageJPEGRepresentation(img, 1.0)! as NSData
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData as Data)!
        
    }
    */
    
}

//#MARK:- random color

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}


//#MARK:- ********* Extenstion Device name********

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}



//#MARK:- ********* Extenstion Array********
extension Array {
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}
//#MARK:- ********* Extenstion CG POINT********
extension CGPoint {
    
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
    
}
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}


// EXTENSION FOR BLUR IMAGE

extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.6
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetImageView?.addSubview(blurEffectView)
        
    }
    
    
}

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    
}


extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Bold", size: 12)!,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 12)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        let normal =  NSAttributedString(string: text,  attributes:attrs)
        self.append(normal)
        return self
    }
}

extension UIAlertController{
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertWithHandler(message : String , block:  @escaping ()->Void ){
        
       let  alert = UIAlertController(title: CommonClass.sharedInstance.createString(Str: "AIPL"), message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: CommonClass.sharedInstance.createString(Str: "OK"), style: .default, handler: {(action : UIAlertAction) in
            
            block()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension UIButton{
    
    func setDataOnButton(btn:UIButton,text:String,font:String,size:CGFloat,textcolor:UIColor,image:UIImage,backGroundColor:UIColor,aliment:UIControl.ContentHorizontalAlignment){
              
              btn.backgroundColor = backGroundColor
              btn.setTitle(CommonClass.sharedInstance.createString(Str: text), for: .normal)
              btn.setTitleColor(textcolor, for: .normal)
              btn.titleLabel?.font = UIFont(name: font, size: size)
              btn.setImage(image, for: .normal)
              btn.layer.cornerRadius = CGFloat(CommonClass.sharedInstance.commonHeight/2)
              btn.contentHorizontalAlignment = aliment
    }
}

extension UITextField{
    
    func setFontandColor(txtFld:UITextField,color:UIColor,font:String,size:CGFloat,text:String){
        
        txtFld.placeholder = CommonClass.sharedInstance.createString(Str: text)
        txtFld.textColor = color
        txtFld.font = UIFont.appCustomFont(fontName: font, size: size)
        
    }
    
}

extension UILabel{
    
    func setFontAndColor(lbl:UILabel,text:String,textColor:UIColor,font:String,size:CGFloat){
        
        lbl.text = CommonClass.sharedInstance.createString(Str: text)
        lbl.textColor = textColor
        lbl.font = UIFont(name: font, size: size)
        
    }
    
}
extension UIColor{
    
  
}
