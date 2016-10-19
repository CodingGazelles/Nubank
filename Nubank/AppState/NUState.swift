//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import ReSwift




/*
 The Application State contains all application information
 This is where the Views will get all they need to set their UI component values
 
 Is composed of 2 sub States: NUNoticeViewState and NUChargebackState
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
struct NUApplicationState: StateType {
    var noticeViewState = NUNoticeViewState()
    var chargebackViewState = NUChargebackState()
}




/*
 Sub State of the Notice View
 */
struct NUNoticeViewState {
    
    
    // State
    static var kNA = "..."
    var viewTitleLabel = kNA
    var viewContent = kNA
    var cancelButtonLabel = kNA
    var continueButtonLabel = kNA
    
    
    
    //
    func hasData() -> Bool {
        return viewTitleLabel != NUNoticeViewState.kNA
            && viewContent != NUNoticeViewState.kNA
            && cancelButtonLabel != NUNoticeViewState.kNA
            && continueButtonLabel != NUNoticeViewState.kNA
    }
    
}




/*
 Sub State of the Chargeback View
 */
struct NUChargebackState {
    var viewTitleLabel = "..."
    var merchantRecognizedReasonTitle = "..."
    var cardInPossessionReasonTitle = "..."
    var hint = "..."
}




/*
 Indicates that a Resource can generate an Action to update the Application State
 */
protocol NUResourceProtocolCanUpdateState {
    
    
    // Action to be emitted
    associatedtype A: Action
    
    
    /*
     Build the required Action
     */
    func getUpdateStateAction() -> A
    
}


