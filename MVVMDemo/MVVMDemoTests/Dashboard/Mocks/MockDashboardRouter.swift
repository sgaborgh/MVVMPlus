//
//  MockDashboardRouter.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
@testable import MVVMDemo

final class MockDashboardRouter: DashboardRouterProtocol {
    
    weak var navigationController: UINavigationController?

    init() {}
    init(withNavigationController navigationController: UINavigationController) {}

}
