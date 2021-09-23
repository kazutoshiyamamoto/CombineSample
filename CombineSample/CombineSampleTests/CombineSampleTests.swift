//
//  CombineSampleTests.swift
//  CombineSampleTests
//
//  Created by home on 2021/07/08.
//

import XCTest
@testable import CombineSample
import Combine

class FakeSearchUserModel: SearchUserModelProtocol {
    var result: Result<Void, ValidateError>?
    
    func validate(searchText: String) -> Result<Void, ValidateError> {
        guard let result = result else {
            fatalError("validationResult has not been set.")
        }
        
        return result
    }
    
    // TODO: ユーザー情報取得処理のテスト
    let users: [User] = []
    func fetchUser(query: String) -> Future<[User], Error> {
        return Future() { promise in
            promise(.success(self.users))
        }
    }
}

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
    
    // MARK: TimerSampleTest
    func testStart_カウントアップ後のcountがstartの引数で指定した数字と等しくなること() {
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
    
    // MARK: DataTaskPublisherSampleTest
    var fakeModel: FakeSearchUserModel!
    var viewModel: SearchUserViewModel!
    
    func testSearchButtonTapped_検索ワードのバリデーション() {
        XCTContext.runActivity(named: "検索ワードのバリデーションに成功する場合") {_ in
            setup()
            
            fakeModel.result = .success(())
            
            viewModel.searchButtonTapped()
            
            XCTAssert(viewModel.errorMessage.isEmpty)
            
            clean()
        }
        
        XCTContext.runActivity(named: "検索ワードのバリデーションに失敗する場合") { _ in
            setup()
            
            fakeModel.result = .failure(.invalidSearchText)
            
            viewModel.searchButtonTapped()
            
            XCTAssertEqual("Please enter a search word", viewModel.errorMessage)
            
            clean()
        }
    }
    
    private func setup() {
        fakeModel = FakeSearchUserModel()
        viewModel = SearchUserViewModel(searchUserModel: fakeModel)
    }
    
    private func clean() {
        fakeModel = nil
        viewModel = nil
    }
}
