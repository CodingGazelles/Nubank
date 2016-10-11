//
//  NUReducer.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
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
            
            state.noticeViewState.viewTitleLabel = 
            
            

            
        default:
            break
        }
        
        return state
        
    }
    
    
}
