//
//  TestSplashViewModel.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import XCTest
@testable import MVVMDemo

final class TestSplashViewModel: XCTestCase {


    // MARK: properties

    private let showingScreenForMockSeconds: TimeInterval = 0.1
    private let mockWelcomeTextList: [String] = ["Welcome", "Hello"]

    var sut: SplashViewModel! // the system under test
    var router: MockSplashRouter!
    var formatter: MockSplashFormatter!


    // MARK: setup / teardown

    override func setUpWithError() throws {
        router = .init()
        formatter = .init()
        
        sut = try SplashViewModel(
            withRouter: router,
            formatter: formatter,
            possibleWelcomeTextList: mockWelcomeTextList,
            showingScreenForSeconds: showingScreenForMockSeconds
        )
    }

    override func tearDownWithError() throws {
    }


    // MARK: tests

    func testInit() throws {
        XCTAssertTrue(sut.combineUIModel.welcomeLabelText.isEmpty)
    }

    func testViewDidLoadEvent() throws {
        sut.handleEvent(.viewDidLoad)

        let lateRoutingExpectation = XCTestExpectation(description: "Waiting for splash screen's show time, checking if next screen is being displayed")
        DispatchQueue.main.asyncAfter(deadline: .now() + showingScreenForMockSeconds, execute: { [weak self] in
            defer { lateRoutingExpectation.fulfill() }

            guard let self = self else { return }

            XCTAssertTrue(self.formatter.isUIModelCreationCalled)
            XCTAssertTrue(self.router.isNavigatedToDashboard)
        })
        wait(for: [lateRoutingExpectation])
    }

}
