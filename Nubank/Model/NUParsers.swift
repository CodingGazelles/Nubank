//
//  Nubank
//
//  Created by Tancrède on 10/13/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import Foundation
import Result





/*
 Objects used to parse the Json Content of the API's Response into Resources
 */




/*
 Definition of Json
 */
typealias JsonDictionary = Dictionary<String, AnyObject>




/*
 */
class NUJsonParser<R: NUResourceProtocol> {
    
    // Store the json
    let data: Any
    init(data: Any) {
        self.data = data
    }
    
    
    
    func result() -> Result<R, NUResourceError> {
        
        return findParser().flatMap { parser in
            parser.result() //as! Result< NUEntryPointResource , NUResourceError>
        }
        
    }
    
    
    
    func findParser() -> Result<NUJsonParser<R>, NUResourceError> {
        log.debug("Looking for a Json Parser for \(R.self)")
        
        
        // Search for the appropriate Parser
        switch R.self {
        case is NUEntryPointResource.Type:
            log.info("Found NUEntryPointJsonParser")
            
            // Returning NUEntryPointJsonParser
            return .success( NUEntryPointJsonParser( data: data) as! NUJsonParser<R>)
            

        // No Parser found
        default:
            log.error("No Json Parser found for \(R.self)")
            
            // Returning an Error
            return .failure( NoJsonParserFound( message: "No Json Parser found for \(R.self)", rootError: nil ))
            
            
        }
        
        
    }
    
}




/*
 Reads the json file and intanciates EntryPoint Resource
 */
class NUEntryPointJsonParser: NUJsonParser<NUEntryPointResource> {
    
    
    
    /*
     Keys of the json file
     */
    enum JsonKeys: String {
        case Links = "links"
        case Notice = "notice"
        case Href = "href"
    }

    
    
    
    /*
     */
    override func result() -> Result< NUEntryPointResource , NUResourceError> {
        
        
        
        // Convert Data to JsonDictionary
        guard let json = super.data as? JsonDictionary else {
            return .failure ( ParsingAPIContentFailed(message: "Response returned by API is not Json", rootError: nil))
        }
        
        // reading the Json
        guard let links = json[.Links] as? JsonDictionary else {
            return .failure ( ParsingAPIContentFailed(message: "Unable to parse Links element in Json returned by API", rootError: nil))
        }
        
        guard let notice = links[.Notice] as? JsonDictionary else {
            return .failure ( ParsingAPIContentFailed(message: "Unable to parse Notice element in Json returned by API", rootError: nil))
        }
        
        guard let href = notice[.Href] as? String else {
            return .failure ( ParsingAPIContentFailed(message: "Unable to parse Href element in Json returned by API", rootError: nil))
        }
        
        
        guard let url = URL( string: href) else {
            return .failure ( ParsingAPIContentFailed(message: "Href element in Json returned by API is not a valid URL", rootError: nil))
        }
        
        
        
        //
        let resource = NUEntryPointResource(
            noticeLink: NUNoticeLink( href: url))
        
        
        
        // Return the resource
        return .success( resource)
        
    }
    
}




/*
 Overload Subscript of JsonDictionary to accept a JsonKey as Index
 */
extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    
    subscript(index: NUEntryPointJsonParser.JsonKeys) -> AnyObject {
        get {
            return self[ index.rawValue as! Key] as! AnyObject
        }
    }
    
}
