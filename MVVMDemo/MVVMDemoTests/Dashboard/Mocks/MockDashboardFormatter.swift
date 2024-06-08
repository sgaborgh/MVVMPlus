//
//  MockDashboardFormatter.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
@testable import MVVMDemo

final class MockDashboardFormatter: DashboardFormatterProtocol {

    var isUIModelCreationCalled: Bool = false

    func createUIModel(withCarList carList: [Car]) -> DashboardUIModel {
        isUIModelCreationCalled = true
        return .init(carList: carList)
    }

}
