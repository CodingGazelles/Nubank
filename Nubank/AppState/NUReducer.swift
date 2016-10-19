//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import ReSwift




/*
 Modifies the State according to the Action dispatched
 Is called by the Store when an Action is dispatched
 */
class NUReducer: Reducer {
    
    func handleAction(action: Action, state: NUApplicationState?) -> NUApplicationState {
        
        
        var state = state ?? NUApplicationState()
        
        switch action {
        case let action as NUNoticeUpdateStateAction:
            
            state.noticeViewState.viewTitleLabel = action.viewTitle
            state.noticeViewState.viewContent = action.viewContent
            state.noticeViewState.continueButtonLabel = action.continueButtonLabel
            state.noticeViewState.cancelButtonLabel = action.cancelButtonLabel
            
        default:
            break
        }
        
        return state
        
    }
    
    
}
