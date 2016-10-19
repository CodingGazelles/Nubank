//
//  NUAPIResponse.swift
//  Nubank
//
//  Created by Tancrède on 10/17/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import BrightFutures
import Result




/*
 Contains the Response of the API
 */
protocol NUHTTPResponseProtocol: Loggable {
    
    /// The URL request sent to the server.
    var request: URLRequest? { get }
    
    
    /// The server's response to the URL request.
    var response: HTTPURLResponse? { get }
    
    
    /// The data returned by the server.
    var data: Data? { get }
    
    
    /// The result of response serialization.
    var result: Result<Any, NUResourceError> { get }
    
}




/*
 Base implementation
 */
class NUHTTPResponse: NUHTTPResponseProtocol {
    
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    public let data: Data?
    public let result: Result<Any, NUResourceError>
    
    
    //
    init( request: URLRequest?, response: HTTPURLResponse?, data: Data?, result: Result<Any, NUResourceError>){
        self.request = request
        self.response = response
        self.data = data
        self.result = result
    }
    
}




/*
 Futurization of NUHALResourceProtocol
 */
extension Future where T: NUHTTPResponseProtocol, E: NUResourceError {
    
    
    
    /*
     Converts a Future of a NUAPIResponse into a Future of a NUResource
     Parses the content of the HTTP Response and returns the result in a Resource Future
     */
    func getResource< U: NUHALResourceProtocol>() -> Future< U, Value.Error> {
        log.info( "Getting Resource of \(self.value)")
        
        
        
        // Mapping the Future to a new Future
        return flatMap { response in
            
            
            
            // Build new Future that will encapsulate the Resource
            return Future<U, Value.Error> { complete in
                DispatchQueue.global().async {
                    
                    
                    
                    // Get the Json
                    // We know at this point that by program logic value is not null
                    let json = response.result.value!
                    
                    
                    
                    // Parsing the Json of the Response
                    let parserResult = NUJsonParser<U>( data: json ).result()
                    
                    
                    
                    // Testing parsing result
                    switch parserResult {
                    case .success(let value):
                        log.info( "Parsing result of \(json): \(value)")
                        
                        
                        // Returning the Json in the Future
                        complete( .success( value ))
                        
                        
                        
                    case .failure(let error):
                        log.error( "Parsing error of \(json): \(error)")
                        
                        
                        // Returning the parsing Error in the Future
                        complete( .failure(
                            ParsingAPIContentFailed(
                                message: "Unabled to parse the response of the content of \(json)",
                                rootError:  error) as! Value.Error))
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
}




/*
 */
func getResource<U: NUHALResourceProtocol>( _ apiResponse: Future<NUHTTPResponse, NUResourceError>) -> Future< U, NUResourceError> {
    return apiResponse.getResource()
}
