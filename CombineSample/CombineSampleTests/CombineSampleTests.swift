//
//  CombineSampleTests.swift
//  CombineSampleTests
//
//  Created by home on 2021/07/08.
//

import XCTest
@testable import CombineSample
import Combine

class CombineSampleTests: XCTestCase {

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK:TimerSampleTest
    func testStart() {
        let viewModel = TimerSampleViewModel()
        
        var cancellables = Set<AnyCancellable>()
        
        let expectation = XCTestExpectation(description: "Counting")
        
        viewModel.start(end: 100)
            .sink { _ in
                XCTAssertEqual(viewModel.count, 100)
                cancellables.removeAll()
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 3.0)
    }
}
