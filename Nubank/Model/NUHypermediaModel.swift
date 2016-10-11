//
//  NUAPIs.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import BrightFutures
import ReSwift




/*
 HAL Resource
 See http://stateless.co/hal_specification.html
 */
protocol HALResource {
    
    
    /*
     Validate if Resource is compliant with what's expected
     */
    var responseStatusCode: Int? { get }
    var responseContentType: String? { get }
    
    
    /*
     Validates the StatusCode and the ContentType of the HTTP Response
    */
    func validateResponse() -> Self
    
    
    /*
     Parsing the JSON
    */
    func parseContent() -> Self
    
    
    
    
}




/*
 Marks a Resource which content can be used to update the Application State
 */
protocol NUResourceCanUpdate {
    
    
    /*
     Build the required Action
     */
    func getUpdateStateAction<A: Action>() -> A
    
}





/*
 HAL Link
 See http://stateless.co/hal_specification.html
 */
protocol HALLink {
    
    
    // Properties
    var rel: String! { get }
    var target: URL! { get }
    
    
    /*
     Returns the resource pointed at by the Link
    */
    func getResource<R: HALResource>() -> Future<R, HALLinkError>
    
}




// MARK: - Default implementation of protocols



/*
 */
class HALBaseResource: HALResource {
    
    
    // Props
    var expectedStatusCode = 200
    var expectedContentType = "application/json"
    var responseStatusCode: Int?
    var responseContentType: String?
    
    var links = [String:HALLink]()

    
    // Default validation
    func validate() -> Bool {
        return expectedStatusCode == responseStatusCode && expectedContentType == responseContentType
    }

}



/*
 */
class HALBaseLink: HALLink {
    var rel: String!
    var target: URL!
    
    func getResource<R : HALResource>() -> Future<R, HALLinkError> {
        <#code#>
    }
}






