//
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation




/*
 Modelization of Errors
 */




/*
 Base Nubank Error
 */
protocol NUErrorProtocol: Error, Loggable {}


class NUResourceError: NUErrorProtocol {
    var message: String?
    var rootError: Error?
    init( message: String?, rootError: Error?){
        self.message = message
        self.rootError = rootError
    }
}


/*
 Errors thrown from the API
 */

    
class LoadingAPIContentFailed: NUResourceError {}
class ParsingAPIContentFailed: NUResourceError {}
class NoJsonParserFound: NUResourceError {}
class ResourceCanEmitUpdateStateAction: NUResourceError {}
    


