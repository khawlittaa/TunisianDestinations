//
//  DatetoString.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

extension Date{
    
    func   DateToString() -> String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate =  dateformatter.string(from: self)
        return formattedDate
    }
}


