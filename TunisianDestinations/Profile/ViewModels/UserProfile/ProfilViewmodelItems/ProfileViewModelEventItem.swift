//
//  ProfileViewModelEventItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class ProfileViewModelEventItem: CustomViewModelItem {
      var type: ProfileViewModelItemType {
        return .favoriteEvents
     }
     
     var sectionTitle: String {
         return "My Events"
     }

     var rowCount: Int {
        return myevents.count
     }
     
     var myevents: [String]
    
    init(myevents: [String]) {
           self.myevents = myevents
       }
}
