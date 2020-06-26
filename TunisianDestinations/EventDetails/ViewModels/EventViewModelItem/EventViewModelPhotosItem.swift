//
//  EventViewModelPhotosItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class EventViewModelPhotosItem: EventViewModelItem {
     var type: EventViewModelType{
        return .photos
       }
       
       var sectionTitle: String{
           return ""
       }
    
    var images: [String]
      
      init(images:[String]) {
          self.images = images
      }
}
