//
//  MovieAssignmentTests.swift
//  MovieAssignmentTests
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import XCTest
import CoreData

@testable import MovieAssignment

class MovieAssignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func test_loadMoviesFromServer()
    {
        let moviesExpectation = expectation(description: "movies")

        StoreManager.getAllMovies(success: {(movies:Array<Movie>) in
                        
            if movies.count > 0
            {
                moviesExpectation.fulfill()
                
                XCTAssertGreaterThan(movies.count,200, "We should have loaded minimum 200 movies.")
            }
            else
            {
                XCTAssertNotNil(nil)
            }
            
        }) { (error:Error?) in
            XCTAssertNotNil(nil)
        }
        
        waitForExpectations(timeout:10)
    }
    
    func testPerformanceOfMovieNetworkCall() throws
    {
        self.measure
        {
            test_loadMoviesFromServer()
        }
    }
}
