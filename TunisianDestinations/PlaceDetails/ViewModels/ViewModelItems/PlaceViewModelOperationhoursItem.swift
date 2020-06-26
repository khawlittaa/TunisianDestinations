//
//  PlaceViewModelOperationhoursItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceViewModelOperationhoursItem: PlaceViewModelItem{
    var type: PlaceViewModelType{
        return .operationHours
    }
    
    var sectionTitle: String{
        return "Operation Hours"
    }
    
    var rowCount: Int{
        return operatingHours.count
    }
    var operatingHours: [String]
      
      init(operatingHours: [String]) {
          self.operatingHours = operatingHours
      }
    
    
}
