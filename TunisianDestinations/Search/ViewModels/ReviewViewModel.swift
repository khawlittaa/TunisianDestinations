//
//  ReviewViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ReviewViewModel {
    
    @Published var reviewText: String = ""
    @Published var starRatingValue: String = ""
    @Published var starRating: Double = 0
    @Published  var reviewImages: [UIImage] = [UIImage]()
    var userID: String?
    
    let validator = RegularExpressions()
    
     lazy var validatedReviewText = Publishers.CombineLatest($reviewText, $reviewText)
         .map {self.validator.hasMincaracters($0) && self.validator.hasMincaracters($1) }
         .eraseToAnyPublisher()
    
    // hide review lbl when raing not
    lazy var validatedReviewStars = Publishers.CombineLatest($starRating, $starRatingValue)
        .map { _ in Double(self.starRating) == 0
    }
        .eraseToAnyPublisher()
  
}
