//
//  UITextView+Publisher.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/30/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

extension UITextView{
    var textChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextView } // receiving notifications with objects which are instances of UITextView
            .map { $0.text ?? "" } // mapping UITextField to extract text
            .eraseToAnyPublisher()
    }

}
