//
//  EventViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine
class EventViewModel: NSObject {
    
    @Published private(set) var state: ListViewModelState = .loading
    @Published var items = [EventViewModelItem]()
     var event: Event? {
        
        didSet {
            
            // init each PlaceVM type item with needed values here and append items
            if /*let  name = event?.eventCategory,*/ let type = event?.eventTitle, let numPlaces = event?.numberPlaces
            {
                let generalInfo = EventViewModelGeneralInfoItem()
                items.append(generalInfo)
            }

            if let startDate = event?.startDate, let startTime = event?.startTime, let endDate = event?.endDate, let endTime = event?.endTime{
                let locationAndDates = EventViewModelLocationAndDatesItem()
                items.append(locationAndDates)
            }
            
            if let phone = event?.description {
                let description = EventViewModelDescriptionItem()
                items.append(description)
            }
            
            if let phone = event?.phone{
                let organizer = EventViewModelOrganizerInfoItem()
                items.append(organizer)
                
            }
            
            if let images = event?.pictures {
                let photos = EventViewModelPhotosItem(images: images)
                items.append(photos)
                let review = EventViewModelReviewsItem()
                items.append(review)
            }
            
        }
    }
}

