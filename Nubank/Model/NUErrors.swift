//
//  NUError.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithMojito. All rights reserved.
//

import Foundation




/*
 */
protocol NUError: Error {}




/*
 */
protocol HALError: NUError {}



/*
 */
enum HALLinkError: HALError {
    case GetResourceFailed( message: String?, rootError: Error?)
}
