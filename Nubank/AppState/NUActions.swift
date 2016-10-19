//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
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
 Action that updates the Application State
 */
class NUUpdateStateAction: NUAction {
}




/*
 Updates the State with the content of the Notice Resource
 */
class NUNoticeUpdateStateAction: NUUpdateStateAction {
    
    
    // Properties
    var viewTitle: String = ""
    var viewContent: String = ""
    var continueButtonLabel: String = ""
    var cancelButtonLabel: String = ""
    
    
    
    //
    init( viewTitle: String, viewContent: String, continueButtonLabel: String, cancelButtonLabel: String) {
        self.viewTitle = viewTitle
        self.viewContent = viewContent
        self.continueButtonLabel = continueButtonLabel
        self.cancelButtonLabel = cancelButtonLabel
    }
    
}


