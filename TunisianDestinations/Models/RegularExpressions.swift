//
//  RegularExpressions.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class RegularExpressions{
    
    let pswRegEx  = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,40}$"
    let nameStringRegEx  = "([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}"
    let userNameRegEx = "[a-zA-Z][a-zA-Z0-9-_.]{3,50}"
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,60}"
    let minCaractersRegEx = "^.{20,}$"
    let phoneRegEx = "^[0-9]{8}$"
    func hasMincaracters(_ text: String) -> Bool{
        
        let textPred = NSPredicate(format:"SELF MATCHES %@", minCaractersRegEx)
          return textPred.evaluate(with: text)
    }
    
    func isDateValid(_ date: String) -> Bool{
          let dateFormatterGet = DateFormatter()
          dateFormatterGet.dateFormat = "yyyy-MM-dd"
          
          if dateFormatterGet.date(from: date) != nil {
              return true
          } else {
              return false
          }
      }
    
    
       func isValidePeriode(startDate: String, endDate: String) -> Bool{
           
        if  isDateValid(startDate) && isDateValid(endDate){
            // check start date , end date
            let sdate = startDate.StringToDate()
            let edate = endDate.StringToDate()
            
            return edate > sdate
        }else{
            return false
        }
       }
      
      func isValidEmail(_ email: String) -> Bool {
          
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: email)
      }
      
      func isValidUserName(_ userName:String) -> Bool {
          
          let userNamePred = NSPredicate(format:"SELF MATCHES %@", userNameRegEx )
          return userNamePred.evaluate(with: userName)
      }
      
      func isValidNameString(_ nameString: String) -> Bool{
          
          let stringPred = NSPredicate(format:"SELF MATCHES %@", nameStringRegEx)
          return stringPred.evaluate(with: nameString)
      }
      
      func isValidPassword(_ password: String) -> Bool{
          
          let pswPred = NSPredicate(format:"SELF MATCHES %@", pswRegEx)
          return pswPred.evaluate(with: password)
      }
    
    func isValidPhone(_ phoneNumber: String) -> Bool{
        
        let stringPred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return stringPred.evaluate(with: phoneNumber)
    }
    
}
