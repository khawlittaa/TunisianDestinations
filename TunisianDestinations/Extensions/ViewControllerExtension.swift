//
//  ViewControllerExtension.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/22/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{

    func getVCfromStoryboard(storyboard: String, VCIdentifier: String) -> UIViewController{
        let viewcontroller = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(identifier: VCIdentifier)
        return viewcontroller
    }
}
