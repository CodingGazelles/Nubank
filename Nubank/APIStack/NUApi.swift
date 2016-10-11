//
//  NUApis.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation
import BrightFutures




/*
 */
class NUEndPointLink: HALLink {
    
    
    // Properties
    var rel = "endpoint"
    var target = URL(string: "https://nu-mobile-hiring.herokuapp.com")!
    
    
    func getResource<NUEndPointResource>() -> NUEndPointResourceFuture {
        let promise = NUEndPointResourcePromise()
        return promise.future
    }
    
}



/*
 */
protocol NUEndPointResourceProtocol {

    
    
}




