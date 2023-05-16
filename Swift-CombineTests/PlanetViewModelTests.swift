//
//  Combine_GettingStartedTests.swift
//  Combine-GettingStartedTests
//
//  Created by Glenn Ludszuweit on 05/05/2023.
//

import XCTest
@testable import Combine_GettingStarted

final class PlanetViewModelTests: XCTestCase {
    
    var viewModel: PlanetViewModel!
    var networkManager: TestNetworkManager!
    var errorManager: TestErrorManager!
    
    override func setUpWithError() throws {
        networkManager = TestNetworkManager()
        errorManager = TestErrorManager()
        viewModel = PlanetViewModel(networkManager: networkManager, errorManager: errorManager)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        networkManager = nil
        errorManager = nil
    }
    
    func testGetAllPlanets() {
        let duration = 3.0
        let expectation = expectation(description: "Get all planets.")
        
        viewModel.getAllPlanets(apiUrl: "planets")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            XCTAssertEqual(self.viewModel.filteredPlanets.count, 10)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: duration)
    }
    
    func testSearchPlanets() {
        let duration = 3.0
        let expectation = expectation(description: "Search for planets with character T.")
        
        viewModel.getAllPlanets(apiUrl: "planets")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.viewModel.searchPlanets(searchText: "T")
            XCTAssertEqual(self.viewModel.filteredPlanets.count, 3)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: duration)
    }
    
    func testCancellable() {
        let duration = 3.0
        let expectation = expectation(description: "Cancel fetching API.")
        
        viewModel.getAllPlanets(apiUrl: "planets")
        viewModel.cancelFetch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            XCTAssertNotEqual(self.viewModel.filteredPlanets.count, 10)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: duration)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
