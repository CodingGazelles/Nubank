//
//  NUNoticeViewController.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import UIKit




/*
 */
class NUNoticeViewController: UIViewController {
    
    
    // Properties
    // Store of the Application State
    let store = FOStore.defaultStore()
    
    
    /*
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("NUNoticeViewController did load")
        
        
        // Launch data loading of data in Application State
        
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




/*
 Get called when application State changes
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the Application State and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
extension NUNoticeViewController: StoreSubscriber {
    
    
    /*
     */
    func newState(state: FOAppState) {
        
        
        // Set new application State
        self.state = state
        
        
        // Update the UI
        tableView.reloadData()
        
        
        // Remove Progress
        if state.contractList  != nil {
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
        
    }
    
}
