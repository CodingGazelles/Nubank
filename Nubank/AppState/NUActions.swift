//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import ReSwift
import BrightFutures




/*
 An Action is a message sent to the Application State Store in order to modify the Application State
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
protocol NUActionProtocol {
    /*
     Dispatch the Action in the Store
     */
    func dispatchAction() -> Any
}




/*
 Base Implementation
*/
class NUAction: Action, NUActionProtocol {
    func dispatchAction() -> Any{
        return NUStore.defaultStore().dispatch(self)
    }
}




/*
 Action that updates the Application State
 */
class NUUpdateStateAction: NUAction {}




/*
 Futurization of NUActionProtocol
 */
extension Future where T: NUActionProtocol, E: NUResourceError {

    
    
    /*
     Dispatch the Action in the Store
     */
    func dispatchAction() -> Future< Any, Value.Error> {
        log.info( "Dispatching Action \(self.value)")
        
        
        // Mapping the Future to a new Future
        return flatMap { action in
            
            
            
            // Build new Future that encapsulates the UpdateStateAction
            return Future< Any, Value.Error> { complete in
                DispatchQueue.global().async {
                    
                    
                    
                    // Dispatch the action and encapsulates the result into the future
                    complete( .success( action.dispatch() ))
                    
                    
                }
                
            }
            
        }
        
    }

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


