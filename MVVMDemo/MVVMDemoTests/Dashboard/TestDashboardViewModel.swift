//
//  TestDashboardViewModel.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import XCTest
import Combine
@testable import MVVMDemo

final class TestDashboardViewModel: XCTestCase {

    
    // MARK: properties

    private let mockUrlString: String = Config.Api.carListUrlString // now it's not really a mock url, but in a real app it could be

    private var sut: DashboardViewModel! // the system under test
    private var router: MockDashboardRouter!
    private var formatter: MockDashboardFormatter!
    private var apiManager: MockApiManager!
    private var subscriptions: Array<AnyCancellable> = []


    // MARK: setup / teardown

    override func setUpWithError() throws {
        router = .init()
        formatter = .init()
        apiManager = .init()
        subscriptions = []

        sut = try DashboardViewModel(
            withRouter: router,
            formatter: formatter,
            carListUrlString: mockUrlString,
            apiManager: apiManager
        )
    }

    override func tearDownWithError() throws {
    }


    // MARK: tests

    func testInit() throws {
        XCTAssertTrue(sut.combineUIModel.carList.isEmpty)
        XCTAssertTrue(formatter.isUIModelCreationCalled)
        XCTAssertFalse(apiManager.isRequestMethodCalled)
    }

    func testViewDidLoadEvent() throws {
        let carListExpectation = XCTestExpectation(description: "Car list should be downloaded to the given car array structure")

        // test with combine
        sut
            .$combineUIModel
            .removeDuplicates()
            .dropFirst()
            .sink(receiveValue: { [weak self] newUIModel in
                defer { carListExpectation.fulfill() }

                guard let self = self else { return }

                XCTAssertTrue(apiManager.isRequestMethodCalled)
                XCTAssertTrue(self.formatter.isUIModelCreationCalled)
                XCTAssertFalse(newUIModel.carList.isEmpty)
            })
            .store(in: &subscriptions)

        // test with the own binding solution
        //        sut.uiModel.bindToValue({ [weak self] newUIModel in
        //            defer { carListExpectation.fulfill() }
        //
        //            guard let self = self else { return }
        //
        //            XCTAssertTrue(apiManager.isRequestMethodCalled)
        //            XCTAssertNotNil(newUIModel)
        //            XCTAssertTrue(self.formatter.isUIModelCreationCalled)
        //            XCTAssertFalse(newUIModel!.carList.isEmpty)
        //        })
        
        sut.handleEvent(.viewDidLoad)

        wait(for: [carListExpectation])
    }

}
