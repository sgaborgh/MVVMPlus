//
//  MockSplashRouter.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
@testable import MVVMDemo

final class MockSplashRouter: SplashRouterProtocol {

    weak var navigationController: UINavigationController?
    var isNavigatedToDashboard: Bool = false

    init() {}
    init(withNavigationController navigationController: UINavigationController) {}

    func navigateToDashboard() {
        isNavigatedToDashboard = true
    }
    
}
