//
//  ListViewModelState.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/8/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
enum ListViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}
