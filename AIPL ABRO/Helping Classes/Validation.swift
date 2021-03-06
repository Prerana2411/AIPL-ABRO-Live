//
//  Validation.swift
//  Pet Therappy
//
//  Created by prmatics on 1/9/17.
//  Copyright © 2017 Promatics. All rights reserved.
//

import Foundation
import UIKit

class Validation {
    
    func isValidEmail(_ emailString: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: emailString)
    }
    
    func isValidZipCode(_ zipcodeString: String) -> Bool {
        
        let zipcodeRegex = "[0-9]{5}"
        
        let zipcodeTest = NSPredicate(format: "SELF MATCHES %@", zipcodeRegex)
        
        return zipcodeTest.evaluate(with: zipcodeString)
    }
    
    func isValidNumber(_ numberString: String) -> Bool {
        
        let numberRegex = "[0-9]{10,15}"
        
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return numberTest.evaluate(with: numberString)
    }
    
    func isValidYear(_ yearString: String) -> Bool {
        
        let yearRegex = "[0-9]{4}"
        
        let yearTest = NSPredicate(format: "SELF MATCHES %@", yearRegex)
        
        return yearTest.evaluate(with: yearString)
    }
    
    func isValidPhoneNumber(_ phoneString: String) -> Bool {
        
        let phoneRegex = "[0-9]{10}"
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phonePredicate.evaluate(with: phoneString)
    }
    
    func isValidCharacters(_ string: String) -> Bool {
        
              
        let regex = "[A-Za-z ]{1,}"
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: string)
        
    }
    
    func hasValidPasswordLength(_ pstring: String) -> Bool {
        
        
        let regex = "[A-Za-z0-9 ]{8,32}"
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: pstring)
        
    }
    
    func hasOnlySpace(string: String) -> Bool {
        
        return string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
    }


    func isValidPassword(_ string: String) -> Bool {
        
        
        let regex = " "
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: string)
        
    }
    
    
    func validate(_ string: String, equalTo match: String) -> Bool {
        
        if (string == match) {
            
            return true
            
        }else {
            
            return false
            
        }
    }
}
