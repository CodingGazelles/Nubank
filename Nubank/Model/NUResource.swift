//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import BrightFutures




/*
 Represents a Resource
 
 Model of Hypertext Application Language (HAL) Resources
 See http://stateless.co/hal_specification.html
 
 */

protocol NUHALResourceProtocol: Loggable {}




/*
 Base implementation
 */
class NUResource: NUHALResourceProtocol {}




/*
 Points a Resource that can update the Application State
 */
protocol NUResourceCanUpdateStateProtocol {
    func getUpdateStateAction() -> NUUpdateStateAction
}




/*
 Futurization of NUHALResourceProtocol
 */
extension Future where T: NUHALResourceProtocol, E: NUResourceError {


    
    /*
     Converts a Future of a NUResource into a Future of a NUAction
    */
    func getUpdateStateAction() -> Future< NUUpdateStateAction, Value.Error> {
        log.info( "Getting Update Action of \(self.value)")
        
        
        
        // Mapping the Future to a new Future
        return flatMap { resource in
            
            
            
            // Build new Future that encapsulates the UpdateStateAction
            return Future< NUUpdateStateAction, Value.Error> { complete in
                DispatchQueue.global().async {
                
                    
                    
                    // Tests the Resource
                    if resource is NUResourceCanUpdateStateProtocol {
                        
                        
                        
                        // Get the action
                        let action = (resource as! NUResourceCanUpdateStateProtocol).getUpdateStateAction()
                        complete( .success( action ))
                        
                        
                        
                    } else {
                        
                        
                        // Throw Error
                        let error = ResourceCanEmitUpdateStateAction( message: "This Resource \(resource.self) can not emit an UpdateStateAction", rootError: nil)
                        
                        complete( .failure( error as! Value.Error))
                        
                        
                    }
                    
                    
                
                }
                
                
            }
            
        }
        
    }


}




/*
 Functional implementation
 */
func getUpdateStateAction( _ resource: Future<NUResource, NUResourceError>)
    -> Future<NUUpdateStateAction, NUResourceError> {
    return resource.getUpdateStateAction()
}
    
    


// MARK: - Implementation


/*
 */
class NUEntryPointResource: NUResource {
    
    
    
    // Properties
    var noticeLink: NUNoticeLink
    
    
    
    /*
    */
    init( noticeLink: NUNoticeLink) {
        self.noticeLink = noticeLink
    }
    
    
    
    /*
     Returns the Resource pointed at by the Link encapsulated in a Future
    */
    internal func loadNoticeResource() -> Future<NUNoticeResource, NUResourceError> {
        return noticeLink.callAPI().getResource()
    }
    
}




/*
 */
class NUNoticeResource: NUResource, NUResourceCanUpdateStateProtocol {
    
    
    
    // Properties
    var title: String
    var description: String
    var continueActionTitle: String
    var cancelActionTitle: String
//    var chargebackLink: NUChargebackLink
    
    
    
    /*
    */
    init(title: String, description: String, continueActionTitle: String, cancelActionTitle: String /*, chargebackLink: NUChargebackLink*/ ) {
        self.title = title
        self.description = description
        self.continueActionTitle = continueActionTitle
        self.cancelActionTitle = cancelActionTitle
//        self.chargebackLink = chargebackLink
    }
    
    
    
    /*
     */
    func getUpdateStateAction() -> NUUpdateStateAction {
        return NUNoticeUpdateStateAction(
            viewTitle: self.title,
            viewContent: self.description,
            continueButtonLabel: self.continueActionTitle,
            cancelButtonLabel: self.cancelActionTitle)
    }
    
}











