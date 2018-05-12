//
//  ExerciseFetcherTests.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase
@testable import MBNetworking

class ExerciseFetcherTests: XCTestCase {
    func testThatExercisesAreReturnedForValidData() {
        //GIVEN mocked data
        let mockGetter = MockGetter(with: "Sample_Exercises", andType: "json")
        let mockCacher = MockCacher(with: "Sample_Exercises", andType: "json")
        
        let sut = ExerciseFetcher(getter: mockGetter, cacher: mockCacher)
        
        //WHEN I request fetchExercises
        let expect = expectation(description: "Exercises expectation")
        sut.fetchExercises { (result) in
            //THEN 10 seconds are allowed for the download.
            XCTAssert(mockGetter.timeout == 10.0, "Exercise fetcher no longer setting timeout of 10 seconds.")
            
            //AND The request succeeds with 3 exercises.
            switch result {
            case .failure(error: let error, defaultExercises: _):
                XCTFail("An error was returned, this ain't cricket. Error: \(error)")
            case .success(exercises: let exercises):
                XCTAssert(exercises.count == 3, "Incorrect exercises loaded, check MockGetter")
            }
            
            //AND There is cached data set in the cache.
            XCTAssertNotNil(mockCacher.currentData, "Data not cached, wai?")
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 5.0)
    }
}
