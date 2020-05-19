//
//  NetworkTests.swift
//  ItuneRssNikeCodeAssignTests
//
//  Created by Ruoming Gao on 5/5/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import XCTest
@testable import NetworkController

class NetworkTests: XCTestCase {
    
    var sut: APIRequestLoader!
    var validUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    
    struct TestModel: Codable {
        let name: String
        let id: Int
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadRequestNoData() {
        let mockSession = URLMockSession(data: nil, error: nil)
        let networkRequestConfig = NetworkRequestConfigure(url: validUrl, cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        sut = APIRequestLoader(apiRequest: networkRequestConfig, urlSession: mockSession)
        sut.loadRequest { (data: Data?, error) in
            XCTAssertNil(data)
            let networkerror = error as? NetworkError
            XCTAssertTrue(networkerror == NetworkError.noData)
        }
    }
    
    func testInvalidUrl() {
        let session = URLMockSession(data: nil, error: nil)
        let networkRequestConfig = NetworkRequestConfigure(url: "", cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        sut = APIRequestLoader(apiRequest: networkRequestConfig, urlSession: session)
        sut.loadRequest { (_: Data?, error) in
            let networkerror = error as? NetworkError
            XCTAssertTrue(networkerror == NetworkError.invalidRequest)
        }
    }
    
    func testinvalidJSONData() {
        let jsonObject: [String: String] = [
            "firstName": "fail",
            "lastName": "failure",
            "id": "9"
        ]
        let exp = expectation(description: "wait for network")
        let jsonEncoder = try? JSONEncoder().encode(jsonObject)
        let session = URLMockSession(data: jsonEncoder, error: nil)
        let networkConfig = NetworkRequestConfigure(url: validUrl, cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        sut = APIRequestLoader(apiRequest: networkConfig, urlSession: session)
        sut.loadRequest { (data: TestModel?, error) in
            exp.fulfill()
            XCTAssertNil(data)
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, NetworkError.invalidJSONData)
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testValidData() {
        let jsonencoder = JSONEncoder()
        let jsonData = try? jsonencoder.encode(TestModel(name: "Jerry", id: 132))
        let session = URLMockSession(data: jsonData, error: nil)
        let networkConfig = NetworkRequestConfigure(url: validUrl, cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        sut = APIRequestLoader(apiRequest: networkConfig, urlSession: session)
        sut.loadRequest { (data: TestModel?, error) in
            XCTAssertEqual(data?.name, "Jerry")
            XCTAssertNil(error)
        }
    }
    
    func testUnknownError() {
        let unknownErrorSession = URLMockSession(data: nil, error: NetworkError.unknown)
        let networkConfig = NetworkRequestConfigure(url: validUrl, cachePolicy: nil, timeoutInterval: nil, header: nil, httpBody: nil, httpMethod: nil)
        sut = APIRequestLoader(apiRequest: networkConfig, urlSession: unknownErrorSession)
        let exp = expectation(description: "wait for network")
        sut.loadRequest { (data: TestModel?, error) in
            XCTAssertNil(data)
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, NetworkError.unknown)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
