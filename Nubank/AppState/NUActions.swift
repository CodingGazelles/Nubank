//
//  NUActions.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import ReSwift




/*
 Action is a message sent to the Application State Store in order to modify the Application State
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
class NUAction: Action {
    
    
    /*
     Dispatch the Action in the Store
    */
    func dispatch() {
        NUStore.defaultStore().dispatch(self)
    }
    
}




/*
 Updates the State with the content of the Notice Resource
 */
class NUNoticeUpdateStateAction: NUAction {
    var viewTitle: String = ""
    var viewContent: String = ""
    var cancelButtonLabel: String = ""
    var continueButtonLabel: String = ""
}


