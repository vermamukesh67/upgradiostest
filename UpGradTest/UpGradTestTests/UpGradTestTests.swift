//
//  UpGradTestTests.swift
//  UpGradTestTests
//
//  Created by Mukesh Verma on 21/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import XCTest
@testable import UpGradTest

class UpGradTestTests: XCTestCase {

    var viewModel : MovieListViewModel! = MovieListViewModel()
    
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel.loadMoreData()
    }

    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test View model functions + attribute values
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       
        XCTAssertGreaterThan(viewModel.tableDataSource.count, 0)
        XCTAssertTrue(viewModel.shouldLoadMoreData(totalPage: viewModel.totalPages , totalPageLoaded: viewModel.pageNumber))
    }
    
    // Test WebApiManager for -> request + response : sucess/ failure, response time, response content type = application/json
    func testAsynchronousURLConnection() {
        
        let URL = "https://api.themoviedb.org/3/discover/movie?page=1&include_video=false&include_adult=false&sort_by=popularity.desc&language=en-US&api_key=b3f499b62957665be727e11b35d53ed8"
        
        let objExpectation : XCTestExpectation = expectation(description: "GET \(URL)")
        
        WebApiManager.sharedService.requestAPI(url: URL, parameter: nil, httpMethodType: .GET) { (data, response, error) in
            
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? HTTPURLResponse,
                let responseURL = HTTPResponse.url,
                let MIMEType = HTTPResponse.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, URL, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "application/json", "HTTP response content type should be application/json")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            objExpectation.fulfill()
            
        }
        // put timeout as per your expectation
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
