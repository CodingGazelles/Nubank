//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import UIKit
import ReSwift
import BrightFutures




/*
 */
class NUNoticeViewController: UIViewController {
    
    
    // Properties
    // Store of the Application State
    let store = NUStore.defaultStore()
    
    
    
    /*
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("NUNoticeViewController did load")
        
        
        // Launch data loading of data in Application State
        let entryPointFuture: Future<NUUpdateStateAction, NUResourceError> = NUAPIStack.defaultStack().entryPointLink
            |> callAPI
            |> getResource
            |> getUpdateStateAction
        
        
        entryPointFuture
            .onSuccess { resource in
                    
            }
            .onFailure { error in
                    
            }
        
        
        
        
        // Update UI
        updateUI()
        
    }
    
    
    
    /*
    */
    func updateUI() {
        
    }

    
}




/*
 Get called when application State changes
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
extension NUNoticeViewController: StoreSubscriber {
    
    
    
    /*
     Called when an Action is dispatched in the Store and updated the State
     */
    func newState(state: NUApplicationState) {
        
        
        // Update the UI
        updateUI()
        
        
        // Remove Progress
        if state.noticeViewState.hasData() {
//            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
    
    }
    
    
    
    /*
     Subscribes to AppState notifications
     */
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear( animated)
        store.subscribe(self)
    }
    
    
    
    /*
     Cancels subscription to AppState notifications
     */
    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear( animated)
        store.unsubscribe(self)
    }
    
}
