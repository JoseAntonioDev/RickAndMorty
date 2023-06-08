//
//  RickAndMortyAppTests.swift
//  RickAndMortyAppTests
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

import XCTest
@testable import RickAndMortyApp

final class RickAndMortyAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCharacters() async throws {
        await WelcomeViewController().viewModel?.getAllCharacters()
    }
    
    func testMeasureGetCharacters() async throws {
        self.measure {
            Task {
                await WelcomeViewController().viewModel?.getAllCharacters()
            }
            stopMeasuring()
        }
    }
}
