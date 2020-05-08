//
//  MacrosForAll.swift
//  Monami
//
//  Created by abc on 22/11/18.
//  Copyright © 2018 mobulous. All rights reserved.
//

import Foundation
import UIKit



public class MacrosForAll:NSObject{
    public class var sharedInstanceMacro: MacrosForAll {
        struct Singleton {
            static let instance: MacrosForAll = MacrosForAll()
        }
        return Singleton.instance
    }
    override init() {}
    
    let API_BASE_URL = "http://3.135.167.41/api/usercontroller/"
    
    enum APINAME : String {
        case apiSignup                = "adduser"
        case apiMobEmail              = "checkEmail"
        case apilogin                 = "login"
        case apiUserProfile           = "userProfile"
        case apiUpdateProfile         = "updateProfile"
        case apiChangePass            = "changePassword"
        case apiforgotPassword        = "forgotPassword"
        case apiAddMem                = "addMember"
        case apiMemList               = "memberList"
        case apiEditMem               = "editMember"
        case apiDeleteMem             = "deleteMember"
        case apiLogout                = "logout"
        case apiDoctorList            = "doctorListing"
        case apicallVistListing       = "callVistListing"
        case apiSearchDoctor          = "searchDoctor"
        case apiAddBooking            = "addBooking"
        case apiNotification          = "notification"
        case apigetNotificationStatus = "getNotificationStatus"
        case apiAddCallBook           = "addCallBooking"
        case apiMyBooking             = "myBooking"
        case apimedicalHistory        = "medicalHistory"
        case apiaddSpecialty          = "addSpecialty"
        case apiaddLab                = "addLab"
        case apiaddHospitalRecords    = "addHospitalRecords"
        case apiaddPharmacy           = "addPharmacy"
        case apimemberList            = "memberListById"
        case apiaddScheduling         = "addScheduling"
        case apiupcomingBooking       = "upcomingBookingList"
        case apipastBookingList       = "pastBookingList"
        case apidoctorType            = "doctorType"
        case apiupdatepassword        = "updatepassword"
        case apiaddPhysicalTherapy    = "addPhysicalTherapy"
        case apiaddOther              = "addOther"
        case apideleteMedicalRecords  = "deleteMedicalRecords"
        case apicheckSocialToken      = "checkSocialToken"
        case apiaddRating             = "addRating"
        case apieditHospitalRecords   = "editHospitalRecords"
        case apieditSpecialty         = "editSpecialty"
        case apieditLab               = "editLab"
        case apieditPhysicalTherapy   = "editPhysicalTherapy"
        case apieditOther             = "editOther"
        case apieditPharmacy          = "editPharmacy"
        case apipastMedicalDetails    = "pastMedicalDetails"
        case apidileveryStatus        = "dileveryStatus"
        case apigetDoctorByLatlong    = "getDoctorByLatlong"
        case apimyNotification        = "myNotification"
        case apinotificationDetails   = "notificationDetails"
        case apidoctorTrackingLatlong = "doctorTrackingLatlong"
        case apigenerateChecksum      = "generateChecksum"
        case apiaddPayment            = "addPayment"
        case apinotificationRead       = "notificationRead"
        case apichatList              = "chatList"
        case apiSaveUserChat          = "SaveUserChat"
        case saveLanguage             = "saveLanguage"
        case apispecificPromocode     = "specificPromocode"
        case apiContactUs             = "contactus"
        case apinotificationCount     = "notificationCount"
        case apidocumentList          = "documentList"
        
        
    }
    enum VALIDMESSAGE : String {
        //Basic Signup
        case EnterFullName                           = "Please enter full name"
        case EnterValidFullName                      = "Please enter your valid full name. (Full Name contains A-Z or a-z, no special character or digits are allowed.)"
        case EnterValidFullNameLength                = "Full name length should atleast of 4 characters."
        case EnterMobileNumber                       = "Please enter phone number"
        case EnterMobileNumberLength                 = "Mobile number should be numeric digits"
        case EmailAddressNotBeBlank                  = "Please enter Email ID"
        case EnterValidEmail                         = "Please enter valid email address"
        case PasswordNotBeBlank                      = "Please enter password"
       // case PasswordShouldBeLong                    = "Please enter new password"
        case ConfirmPasswordNotBeBlank               = "Please enter confirm password"
        case ConfirmPasswordShouldBeLong             = "Confirm password length should be 6-10 characters"
        case NewPasswordNotBeBlank                   = "Please enter new password"
        case NewPasswordShouldBeLong                 = "Password length should be 6-16 characters and it should be the combination of letters in uppercase and lowercase, numbers and symbols (@,#,$,%,etc.)"
        case PasswordAndConfimePasswordNotMatched    = "Password and Confirm Pasword is not matching"
        case AcceptTermsAndConditions                = "Please accept Terms & Conditions"
        case OldPasswordNotBeBlank                   = "Please enter old password"
        case OldPasswordShouldBeLong                 = "Old Password length should be 6-10 characters."
       // case NewPasswordAndConfimePasswordNotMatched = "Password and Confirm Pasword is not matching"
        case CompanyName                             = "Please enter company name"
        case StateNotBlank                           = "Please select your state"
        case DistrictNotBeBlank                      = "Please select your district"
        case TalukaNotBeBlank                        = "Please select your taluka"
        case MobileOrEmail                           = "Please enter Phone Number/Email Id"
        case AddressNotBlank                         = "Please enter your address"
        case LoginTokenExp                           = "This credential is logged in through other device"
    }
    enum ERRORMESSAGE : String {
        case NoInternet                              = "Internet not available, Cross check your internet connectivity and try again"
        case ErrorMessage                            = "There is something wrong!."
        case OtpError                                = "Enter correct OTP"
    }
    
    
    
    
}
