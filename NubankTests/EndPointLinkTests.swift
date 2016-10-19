//
//  EndPointLinkTests.swift
//  Nubank
//
//  Created by Tancrède on 10/11/16.
//  Copyright © 2016 MadeWithCaipirinha. All rights reserved.
//

import XCTest
@testable import Nubank

import BrightFutures




class EndPointLinkTests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Happy Path
    func testGetEntryPointResource() {
        
        let expect = expectation( description: "GetEntryPointResource")
        
        
        let entryPointLink = NUAPIStack.defaultStack().entryPointLink
        let future: Future<NUEntryPointResource, NUResourceError> =
            entryPointLink
                |> callAPI
                |> getResource
        
        
        future.onSuccess { resource in
                
                log.debug("Resource: \(resource)")
                
                
                guard let entryPointResource = resource as? NUEntryPointResource else {
                    XCTFail( "Resource has the wrong type")
                    expect.fulfill()
                    return
                }
                
                
                XCTAssertTrue(entryPointResource.noticeLink.href.absoluteString == "https://nu-mobile-hiring.herokuapp.com/notice", "Notice Link does not point to the correct URL")
                
                
                expect.fulfill()
                
            
            }.onFailure { error in
                
                XCTFail("Future failed with: \(error)")
                
                expect.fulfill()
                
            }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
        
    }
    
    
    func testErrorWrongStatusCode() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/580402fe240000291c135c35")!)
        
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is LoadingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    
    func testErrorWrongContentType() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040b1d240000221d135c38")!)
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is LoadingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    
    func testErrorContentNotJson() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040ba5240000311d135c39")!)
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is LoadingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    
    func testErrorJsonEmpty() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040c3f240000431d135c3a")!)
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is ParsingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    

    func testErrorNoLinksInJson() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040cb4240000511d135c3b")!)
        
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is ParsingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    
    
    
    
    
    func testErrorNoNoticeInJson() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040d94240000691d135c3e")!)
        
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is ParsingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
    
    
    
    
    
    func testErrorHrefIsNoURL() {
        
        let expect = expectation( description: "GetEntryPointResource")
        let entryPointLink = NUEntryPointLink( href: URL(string: "http://www.mocky.io/v2/58040e5b240000821d135c41")!)
        
        
        let future: Future<NUEntryPointResource, NUResourceError> = entryPointLink.callAPI().getResource()
        
        future.onSuccess { resource in
                
                
                XCTFail("GetResource must fail. ")
                
                log.debug("Resource: \(resource)")
                
                expect.fulfill()
                
                
            }.onFailure { error in
                
                log.debug("Error: \(error)")
                
                switch error {
                case is ParsingAPIContentFailed:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Wrong error type: \(error)")
                }
                
                
                expect.fulfill()
                
                
        }
        
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail("Future failed with: \(error)")
            } else {
                XCTAssertTrue(true)
            }
        }
        
    }
    
}
