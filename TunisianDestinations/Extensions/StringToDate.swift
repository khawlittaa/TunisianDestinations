//
//  StringToDate.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

extension String{
    
  func  StringToDate() -> Date{

        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.date(from: self)
        
        return date ?? Date()
    }
}
