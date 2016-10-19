//
//  Nubank
//
//  Created by Tancrède on 10/12/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation




/*
 */
class NUAPIStack {
   
    
    // Singleton
    private static let defaultInstance = NUAPIStack()
    static func defaultStack() -> NUAPIStack {
        return defaultInstance
    }
    
    
    //
    var entryPointLink: NUEntryPointLink
    
    
    //
    private init() {
        self.entryPointLink = NUEntryPointLink( href: URL(string: "https://nu-mobile-hiring.herokuapp.com")!)
    }
    
}




