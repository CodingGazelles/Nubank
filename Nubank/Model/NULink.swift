//
//  Nubank
//
//  Created by Tancrède on 10/13/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import Alamofire
import Result
import BrightFutures




/*
 HAL Link
 
 Model of Hypertext Application Language (HAL) Resources
 See http://stateless.co/hal_specification.html
 
 Does the API call,
 validates the Status and Content Type of the API Response,
 and returns a NUAPIResponseFuture
 
 */
protocol NUHALLinkProtocol: Loggable {}




/*
 Base implementation
 */
class NULink: NUHALLinkProtocol {
    
    
    
    // Properties
    var httpMethod: HTTPMethod = .get
    var expectedStatusCode = 200..<300
    var expectedContentType = "application/json"
    var href: URL
    
    
    
    //
    required init( href: URL){
        self.href = href
    }
    
    
    
    /*
     Calls the API pointed at by the Link and validates the StatusCode and the ContentType of the HTTP Response
     Call is asynchronous and returns a Future that encapsulates the response content or an Error
     */
    func callAPI() -> Future<NUHTTPResponse, NUResourceError> {
        log.info( "Calling API of \(self.href)")
        
        
        
        // Prepare the Future
        let future = Future<NUHTTPResponse, NUResourceError>{ complete in
            DispatchQueue.global().async {
                
                
                
                // Launch Alamofire Request
                // Future will be completed asynchronously
                Alamofire.request( self.href, method: self.httpMethod)
                    
                    
                    
                    // Validation of Status Code and Content Type
                    .validate( statusCode: self.expectedStatusCode)
                    .validate( contentType: [self.expectedContentType])
                    
                    
                    
                    // Serializing response data into Json
                    .responseJSON{ response in
                        
                        
                        
                        // Check Alamofire Response
                        switch response.result {
                        case .success( let value):
                            log.info( "Content of \(self.href): \(value)")
                            
                            
                            
                            // Building the APIResponse
                            let response = NUHTTPResponse(
                                request: response.request,
                                response: response.response,
                                data: response.data,
                                result: .success( response.result.value))
                            
                            
                            
                            // Encapsulating the APIResponse in the Future
                            complete( Result.success(response))
                            
                            
                            
                        case .failure(let error):
                            log.error( "Error while calling \(self.href): \(error)")
                            
                            
                            
                            // Returning the Error in the Future
                            complete( Result.failure(
                                LoadingAPIContentFailed(
                                    message: "Unabled to get a correct response from \(self.href)",
                                    rootError:  error)))
                            
                            

                            
                    }
                        
                }
                
            }
            
        }
        
        
        
        return future
        
    }
    
}




/*
 Functional implementation
 */
func callAPI( _ link: NULink) -> Future<NUHTTPResponse, NUResourceError> {
    return link.callAPI()
}




/*
 */
class NUEntryPointLink: NULink {}




/*
 */
class NUNoticeLink: NULink {}




/*
 */
class NUChargebackLink: NULink  {}




/*
 */
class NUCardUnblockLink: NULink  {}



/*
 */
class NUCardBlockLink: NULink {}


