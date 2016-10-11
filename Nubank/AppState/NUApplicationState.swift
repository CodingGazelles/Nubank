//
//  NUApplicationState.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import ReSwift




/*
 The application State contains all application information
 This is where the Views will get all they need to set their UI component values
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
struct NUApplicationState: StateType {
    var noticeViewState = NUNoticeViewState()
}




/*
 Sub State of the Notice View
 */
struct NUNoticeViewState {
    var viewTitleLabel = "..."
    var viewContent = "..."
    var cancelButtonLabel = "..."
    var continueButtonLabel = "..."
}




