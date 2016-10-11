//
//  NUFutures.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation




typealias NUEndPointResourcePromise = Promise<NUEndPointResource, HALLinkError>
class NUEndPointResource: Future<NUEndPointResource, HALLinkError> {
    func get
}


extension NUEndPointResource: NUEndPointResourceProtocol {
    
}

extension NUEndPointResource: HALResource, NUResourceCanUpdate {
    
}
