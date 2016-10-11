//
//  NUApplicationStateStore.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import ReSwift




/*
 The Store 'stores' the Application State and dispatches all the Actions to the appropriate Receiver
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
class NUStore {
    
    // Singleton
    private init(){}
    private static let defaultInstance = Store<NUApplicationState>( reducer: NUReducer(), state: nil)
    static func defaultStore() -> Store<NUApplicationState> {
        return defaultInstance
    }
    
    
}
