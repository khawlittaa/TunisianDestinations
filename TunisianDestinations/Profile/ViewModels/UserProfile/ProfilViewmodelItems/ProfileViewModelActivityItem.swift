//
//  ProfileViewModelActivityItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class ProfileViewModelActivityItem: CustomViewModelItem {
      var type: ProfileViewModelItemType {
        return .activity
     }
     
     var sectionTitle: String {
         return "Recent Activity"
     }

     var rowCount: Int {
        return recentReviews.count
     }
     
     var recentReviews: [String]
    
    init(recentReviews: [String]) {
           self.recentReviews = recentReviews
       }
}
