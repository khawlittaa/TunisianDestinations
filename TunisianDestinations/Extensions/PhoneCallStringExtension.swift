//
//  RegularExpressionPhone.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/25/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        let urlSchema = "tel:"
        let numberToCall = self.onlyDigits()
        //"26050169".
        if let phoneURL = URL(string: "\(urlSchema)\(numberToCall)"){
            if UIApplication.shared.canOpenURL(phoneURL){
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }else{
                // alert can't make the call
            }
        }
    }
}
