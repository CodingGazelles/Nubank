//
//  Nubank
//
//  Created by Tancrède on 10/14/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import XCGLogger



// MARK: - Logger

/*
 */

var log: XCGLogger {
    
    
    
    let logger = XCGLogger(identifier: "NULogger", includeDefaultDestinations: false)
    
    let destination = ConsoleDestination()
    
    logger.add(destination: destination)
    
    // Optionally set some configuration options
    destination.outputLevel = .debug
    destination.showLogIdentifier = true
    destination.showFunctionName = true
    destination.showThreadName = true
    destination.showLevel = true
    destination.showFileName = true
    destination.showLineNumber = true
    destination.showDate = true
    
//    let colorLogFormatter: XcodeColorsLogFormatter = XcodeColorsLogFormatter()
//    colorLogFormatter.colorize(level: .verbose, with: .green)
//    colorLogFormatter.colorize(level: .debug, with: .black)
//    colorLogFormatter.colorize(level: .info, with: .blue)
//    colorLogFormatter.colorize(level: .warning, with: .red)
//    colorLogFormatter.colorize(level: .error, with: .red)
//    colorLogFormatter.colorize(level: .severe, with: .white, on: .red)
//    destination.formatters = [colorLogFormatter]
    
//    logger.logAppDetails()
    
    return logger
}

//class log {
//    
//    static var logger: XCGLogger {
//       let logger = XCGLogger.default
//        logger.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "path/to/file", fileLevel: .debug)
//        return logger
//    }
//    
//    static func verbose( message: String){
//        logger.verbose( message)
//    }
//    
//    static func debug( message: String){
//        logger.debug(message)
//    }
//    
//    static func info( message: String){
//        logger.info(message)
//    }
//    
//    static func warn( message: String){
//        logger.warning(message)
//    }
//    
//    static func error( message: String){
//        logger.error(message)
//    }
//    
//}



// MARK: - Loggable

/*
 Protocol used to mark all objects that we need to print in the logs
 */
protocol Loggable: CustomDebugStringConvertible, CustomStringConvertible {}





// MARK: - CustomStringConvertible

/*Implementation of the CustomStringConvertible protocol
 */
public extension CustomStringConvertible {
    var description: String {
        return description()
    }
    
    func description(indentationLevel: Int = 0) -> String {
        
        let indentString = (0..<indentationLevel).reduce("") { tabs, _ in tabs + "\t" }
        
        var s = "\(type(of: self))"
        
        let mirror = Mirror(reflecting: self)
        let children = mirror.children
        
        if children.count == 0 && indentationLevel == 0 {
            return s
        }
        
        if children.count == 0 {
            return "\(s) = \(description),"
        }
        
        s += " {"
        
        s = children.reduce(s) {
            reducedString, child in
            
            if let aChild = child.1 as? CustomStringConvertible {
                let childDescription = aChild.description(indentationLevel: indentationLevel + 1)
                return reducedString + "\n\(indentString)\t\(child.0!): \(childDescription)"
            } else {
                
                return reducedString +  "\n\(indentString)\t\(child.0!): \(child.1),"
            }
        }
        
        s = s.substring(to: s.index(before: s.endIndex))
        s += "\n\(indentString)}"
        
        return s
    }
}




// MARK: - CustomDebugStringConvertible

/*Implementation of the CustomDebugStringConvertible protocol
 */
public extension CustomDebugStringConvertible {
    var debugDescription: String {
        return debugDescription()
    }
    
    func debugDescription(indentationLevel: Int = 0) -> String {
        
        let indentString = (0..<indentationLevel).reduce("") { tabs, _ in tabs + "\t" }
        
        var s = "\(type(of: self))"
        
        let mirror = Mirror(reflecting: self)
        let children = mirror.children
        
        if children.count == 0 && indentationLevel == 0 {
            return s
        }
        
        if children.count == 0 {
            return "\(s) = \(debugDescription),"
        }
        
        s += " {"
        
        s = children.reduce(s) {
            reducedString, child in
            
            if let aChild = child.1 as? CustomDebugStringConvertible {
                let childDescription = aChild.debugDescription( indentationLevel: indentationLevel + 1)
                return reducedString + "\n\(indentString)\t\(child.0!): \(childDescription)"
            } else {
                
                return reducedString +  "\n\(indentString)\t\(child.0!): \(child.1),"
            }
        }
        
        s = s.substring(to: s.index(before: s.endIndex))
        s += "\n\(indentString)}"
        
        return s
    }
}




