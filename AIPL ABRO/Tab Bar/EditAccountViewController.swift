//
//  MyAccountViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//
import TOCropViewController

import UIKit


class EditAccountViewController: UIViewController , UIImagePickerControllerDelegate , UIPopoverControllerDelegate , UINavigationControllerDelegate, TOCropViewControllerDelegate , UITextFieldDelegate {
    
    //MARK: Outlet
    
    @IBOutlet var userType_label: UILabel!
    
    @IBOutlet var parentUserId_label: UILabel!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var saveChanges_button: UIButton!
    
    @IBOutlet weak var yourName_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var email_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phone_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password_textField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var camera_button: UIButton!
    
    @IBOutlet var profilePic_ImageView: UIImageView!
    
    
    //MARK: Variables
    
    var selectUserType = ""
    
    var parentUserId = ""
    
    var photoPicker : UIImagePickerController? = UIImagePickerController()
    
    var cropingStyle:TOCropViewCroppingStyle!
    
    var cropViewController = TOCropViewController()
    
    var image_pass_data = NSData()
    
    var password = ""
    
    
    //MARK: WEB service Variables
    
    var validation = Validation()
    
    var conn = webservices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        saveChanges_button.layer.cornerRadius =  self.saveChanges_button.frame.size.height/2
        
        saveChanges_button.layer.masksToBounds = true
        
        camera_button.layer.cornerRadius =  camera_button.frame.height/2
        
        camera_button.layer.masksToBounds = true
        
        camera_button.layer.borderColor = UIColor.white.cgColor
        
        camera_button.layer.borderWidth = 2
        
        profilePic_ImageView.layer.masksToBounds = true
        
        profilePic_ImageView.layer.cornerRadius = profilePic_ImageView.frame.height/2
        
        profilePic_ImageView.layer.borderWidth = 2
        
        profilePic_ImageView.layer.borderColor = UIColor(red: 14/255, green:  28/255, blue:  121/255, alpha: 1.0).cgColor
        
        photoPicker?.delegate = self
        
        password_textField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Edit Account"
        
        self.fetchData()
        
    }
    
    
    //MARK: Tecxtfield delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == password_textField{
            
            if (password_textField.text?.isEmpty)!{
                
            
            }else{
                
                if password_textField.text!.characters.count<6 || password_textField.text!.characters.count>15{
                    
                    self.alertWithHandler(message: "Password length should between 6-15 Characters"){
                        
                        self.password_textField.becomeFirstResponder()
                   
                    }
              
                }
           
            }
            
            
        }else{
            
            
        }
        
    }
    
    //MARK: Functions
    
    func fetchData(){
        
        //        print(NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "UserData") as! Data) as! NSDictionary)
        
        if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).count != 0{
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String == "<null>" ||  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") is NSNull{
                
                self.profilePic_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
                
            }else{
                
                self.profilePic_ImageView.setImageWith(NSURL(string: userImage_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
                
//                if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 1{
//
//                    self.profilePic_ImageView.setImageWith(NSURL(string: DISTRIBUTOR_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 2{
//
//                    self.profilePic_ImageView.setImageWith(NSURL(string: DIRECT_DEALER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 3{
//
//                    self.profilePic_ImageView.setImageWith(NSURL(string: RETAILER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//
//                }else if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName")as? NSDictionary)?.value(forKey: "id")as? Int)! == 4{
//
//                    self.profilePic_ImageView.setImageWith(NSURL(string: END_USER_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
//                }else{
//
//
//                }
                
                ///var/www/html/aipl_api/images/
                
                //                self.profilePic_ImageView.setImageWith(NSURL(string: image_url + ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "image") as? String)!) as URL?, placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String != nil{
                
                self.yourName_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "name") as? String
                
            }
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String != nil{
                
                self.email_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "email") as? String
                
            }
            
            if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "phone") as? String != nil{
                
                self.phone_textField.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "phone") as? String
                
            }
            
            if (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "password") as? String != nil{
                
                self.password =  ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "password") as? String)!
                
            }
            
            if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "name") as? String) != nil{
                
                self.userType_label.text =  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)?.value(forKey: "name") as? String)
                
            }
            
            if  (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "id") as? Int) != nil{
                
                if (((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "UserTypeName") as? NSDictionary)!.value(forKey: "id") as? Int) == 4{
                    
                    parentUserId_label.isHidden = true
                    
                    codeLabel.isHidden = true
                    
                }else{
                    
                    if  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "business_id") as? String != nil{
                        
                        parentUserId_label.isHidden = false
                        
                        codeLabel.isHidden = false
                        
                        self.parentUserId_label.text =  (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "business_id") as? String
                        
                    }
                    
                }
                
            }
            
        }
    
    }
    
//    //MARK: random String
//
//    func randomStringWithLength (len : Int) -> NSString {
//
//        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//
//        var randomString : NSMutableString = NSMutableString(capacity: len)
//
//        for i in 0...len{
//            var length = UInt32 (letters.length)
//
//            var rand = arc4random_uniform(length)
//
//            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
//        }
//
//        return randomString
//    }
    
    func connection(){
        
        let userId = (NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "id") as? Int
        
        let parentUserID = String(describing:((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "LoginData") as! Data) as! NSDictionary).value(forKey: "business_id"))! )
        
        // let userId = String(describing:( singleton.sharedInstance.UserData.value(forKey: "id"))!)
        
        var parameters : [NSString: NSObject] = [:]
        
        if password_textField.text!.isEmpty || password_textField.text!.replacingOccurrences(of: " ", with: "") == "" {
            
            parameters = [ "id": userId! as NSObject ,
                           "name": yourName_textField.text! as NSObject  ,
                           "phone" : phone_textField.text! as NSObject ,
                           "password" : "" as NSObject,
                           "parent_user_id" : parentUserID as NSObject]
            
        }else{
            
            parameters = [ "id": userId! as NSObject ,
                           "name": yourName_textField.text! as NSObject ,
                           "password" : password_textField.text! as NSObject ,
                           "phone" : phone_textField.text! as NSObject ,
                           "parent_user_id" : parentUserID as NSObject ]
            
        }
        print(parameters)
        
        Indicator.shared.showProgressView(self.view)
      
//        self.conn.startConnectionWithData(imageData: (UIImageJPEGRepresentation(profilePic_ImageView.image!,0.9)as NSData!), fileName: "profile.jpeg", imageparm: "image", getUrlString: "edit-profile", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject])
            
        self.conn.startConnectionWithData(imageData: NSData(), fileName: "profile.jpeg", imageparm: "image", getUrlString: "edit-profile", method_type: methodType.post, params: parameters as NSObject as! [NSString : NSObject])
        { (receivedData) in
             
            print(receivedData)
            
            Indicator.shared.hideProgressView()
            
            if self.conn.responseCode == 1{
//
//                UserDefaults.standard.removeObject(forKey: "Login_Status")
//
              
                if (receivedData.value(forKey: "response") as? Int)! == 1{
                    
                    UserDefaults.standard.removeObject(forKey: "LoginData")
                   
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: receivedData.value(forKey: "data") as! NSDictionary), forKey: "LoginData")
                    
                    let  alert = UIAlertController(title: "AIPL ABRO", message: receivedData.value(forKey: "message") as? String, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                        
                      //UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: receivedData.value(forKey: "data") as! NSDictionary), forKey: "LoginData")
                        //PushViewController
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    } ))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    self.alert(message: receivedData.value(forKey: "message") as! String)
                    
                    
                }
                
            }else{
                
                self.alert(message: receivedData.value(forKey: "Error") as! String)
                
            }
            
        }
        
    }
    
    //MARK: Alert Functions
    
    func alert(message : String)
    {
        let  alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertWithHandler(message : String , block:  @escaping ()->Void ){
        
        let alert = UIAlertController(title: "AIPL ABRO", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action : UIAlertAction) in
            
            block()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    //MARK: Action
    
    @IBAction func saveChanges_button(_ sender: UIButton) {
        
        //Name
        if yourName_textField.text!.isEmpty{
            
            self.alertWithHandler(message: "Name cannot be empty"){
                
                self.yourName_textField.becomeFirstResponder()
                
            }
            
        }else if yourName_textField.text!.replacingOccurrences(of: " ", with: "") == "" {
            
            self.alertWithHandler(message: "Invalid Name"){
                
                self.yourName_textField.becomeFirstResponder()
                
                    
                }
                
            }else if self.validation.isValidCharacters(yourName_textField.text!) == false{
                    
                    self.alertWithHandler(message: "Invalid Name"){
                        
                        self.yourName_textField.becomeFirstResponder()
                        
                    }
                    
                }else  if email_textField.text!.isEmpty{
                        
                        self.alertWithHandler(message: "Email cannot be empty"){
                            
                            self.email_textField.becomeFirstResponder()
                        }
                        
                        
                    }else if self.validation.isValidEmail(email_textField.text!) == false{
                        
                        self.alertWithHandler(message: "Invalid Email Id"){
                            
                            self.email_textField.becomeFirstResponder()
                            
                            
                        }
                        
                    }else if phone_textField.text!.isEmpty{
                            
                            self.alertWithHandler(message: "Phone number cannot be empty"){
                                
                                self.phone_textField.becomeFirstResponder()
                            }
                            
                        }else if validation.isValidPhoneNumber(phone_textField.text!) == false{
                                
                                self.alertWithHandler(message: "Phone number is not Valid"){
                                    
                                    self.phone_textField.becomeFirstResponder()
                                    
                                }
            
        }else{
            
            self.connection()

        }
  
    }
    
    
    @IBAction func camera_Button(_ sender: UIButton) {
        
        self.showActionSheet()
        
    }
 
    
    func showActionSheet() {
        
        let actionSheet = UIAlertController(title: "Choose Image From ", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.pickUsingCamera()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.pickUsingGallery()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func pickUsingGallery(){
        
        photoPicker!.allowsEditing = false
        
        photoPicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(photoPicker!, animated: true, completion: nil)
        
    }
    
    func pickUsingCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            
            photoPicker!.allowsEditing = false
            
            photoPicker!.sourceType = UIImagePickerController.SourceType.camera
            
            photoPicker!.cameraCaptureMode = .photo
            
            present(photoPicker!, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        
        }
        
    }
    
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       // let profilePic = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let profilePic = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
      //  let profilePic = info[UIImagePickerController] as! UIImage
        
        cropingStyle = TOCropViewCroppingStyle.default
        
        cropViewController.customAspectRatio = CGSize(width: self.profilePic_ImageView.frame.size.width, height: profilePic_ImageView.frame.size.height)
        
        cropViewController = TOCropViewController(croppingStyle: cropingStyle, image: profilePic)
        
        //  user_image.image = chosenImage
        
        cropViewController.toolbar.clampButtonHidden = true
        
        cropViewController.toolbar.rotateClockwiseButtonHidden = true
        
        cropViewController.cropView.setAspectRatio(CGSize(width: self.profilePic_ImageView.frame.size.width, height: self.profilePic_ImageView.frame.size.height  ), animated: true)
        
        cropViewController.cropView.aspectRatioLockEnabled = true
        
        cropViewController.toolbar.rotateButton.isHidden = true
        
        cropViewController.toolbar.resetButton.isHidden = true
        
        cropViewController.delegate = self
        
        let im = UIImage(cgImage:profilePic.cgImage!, scale:profilePic.scale, orientation:profilePic.imageOrientation)
        
        // self.imageData =  UIImageJPEGRepresentation(im, 0.4)as NSData!
        
        dismiss(animated: true, completion: nil)
        
        self.navigationController?.present(cropViewController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }

    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        
        self.dismiss(animated: true, completion: nil)
        
        let alert = UIAlertController(title: "AIPL ABRO", message: "Are you sure \n you want to update profile photo?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
            
          //  self.image_pass_data = UIImageJPEGRepresentation(image.fixOrientation(), 0.5)! as NSData
            
          //  self.profilePic_ImageView.image = UIImage(data: self.image_pass_data as Data)
            
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
   
}

extension UIImage {
    
    func fixOrientation() -> UIImage {
        
        if self.imageOrientation == UIImage.Orientation.up {
            
            return self
            
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return normalizedImage;
        
    }
}

